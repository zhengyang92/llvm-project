; RUN: opt -S -passes=vector-combine -data-layout=e < %s | FileCheck %s --check-prefixes=SMALL,CHECK
; RUN: opt -S -passes=vector-combine -data-layout=E < %s | FileCheck %s --check-prefixes=BIG,CHECK

define <8 x i16> @ShufZ64i8Ext8i8to8i16(<64 x i8> %0) {
; CHECK-LABEL: @ShufZ64i8Ext8i8to8i16(
; SMALL-NEXT:    [[SHIFT:%.*]] = shufflevector <64 x i8> [[X:%.*]], <64 x i8> zeroinitializer, <16 x i32> <i32 2, i32 64, i32 10, i32 64, i32 18, i32 64, i32 26, i32 64, i32 34, i32 64, i32 42, i32 64, i32 50, i32 64, i32 58, i32 64>
; BIG-NEXT:      [[SHIFT:%.*]] = shufflevector <64 x i8> [[X:%.*]], <64 x i8> zeroinitializer, <16 x i32> <i32 64, i32 2, i32 64, i32 10, i32 64, i32 18, i32 64, i32 26, i32 64, i32 34, i32 64, i32 42, i32 64, i32 50, i32 64, i32 58>
; CHECK-NEXT:    [[EXT:%.*]] = bitcast <16 x i8> [[SHIFT]] to <8 x i16>
; CHECK-NEXT:    ret <8 x i16> [[EXT]]
  %2 = shufflevector <64 x i8> %0, <64 x i8> poison, <8 x i32> <i32 2, i32 10, i32 18, i32 26, i32 34, i32 42, i32 50, i32 58>
  %3 = zext <8 x i8> %2 to <8 x i16>
  ret <8 x i16> %3
}

define <8 x i32> @Shuf64i8ZExt8i8to8i32(<64 x i8> %0) {
; CHECK-LABEL: @Shuf64i8ZExt8i8to8i32(
; SMALL-NEXT:    [[SHIFT:%.*]] = shufflevector <64 x i8> [[X:%.*]], <64 x i8> zeroinitializer, <32 x i32> <i32 2, i32 64, i32 64, i32 64, i32 10, i32 64, i32 64, i32 64, i32 18, i32 64, i32 64, i32 64, i32 26, i32 64, i32 64, i32 64, i32 34, i32 64, i32 64, i32 64, i32 42, i32 64, i32 64, i32 64, i32 50, i32 64, i32 64, i32 64, i32 58, i32 64, i32 64, i32 64>
; BIG-NEXT:      [[SHIFT:%.*]] = shufflevector <64 x i8> [[X:%.*]], <64 x i8> zeroinitializer, <32 x i32> <i32 64, i32 64, i32 64, i32 2, i32 64, i32 64, i32 64, i32 10, i32 64, i32 64, i32 64, i32 18, i32 64, i32 64, i32 64, i32 26, i32 64, i32 64, i32 64, i32 34, i32 64, i32 64, i32 64, i32 42, i32 64, i32 64, i32 64, i32 50, i32 64, i32 64, i32 64, i32 58>
; CHECK-NEXT:    [[EXT:%.*]] = bitcast <32 x i8> [[SHIFT]] to <8 x i32>
; CHECK-NEXT:    ret <8 x i32> [[EXT]]
  %2 = shufflevector <64 x i8> %0, <64 x i8> poison, <8 x i32> <i32 2, i32 10, i32 18, i32 26, i32 34, i32 42, i32 50, i32 58>
  %3 = zext <8 x i8> %2 to <8 x i32>
  ret <8 x i32> %3
}

define <8 x i64> @Shuf64i8ZExt8i8to8i64(<64 x i8> %0) {
; CHECK-LABEL: @Shuf64i8ZExt8i8to8i64(
; SMALL-NEXT:    [[SHIFT:%.*]] = shufflevector <64 x i8> [[X:%.*]], <64 x i8> zeroinitializer, <64 x i32> <i32 2, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 10, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 18, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 26, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 34, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 42, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 50, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 58, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64>
; BIG-NEXT:      [[SHIFT:%.*]] = shufflevector <64 x i8> [[X:%.*]], <64 x i32> <i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 2, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 10, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 18, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 26, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 34, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 42, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 50, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 58>
; CHECK-NEXT:    [[EXT:%.*]] = bitcast <64 x i8> [[SHIFT]] to <8 x i64>
; CHECK-NEXT:    ret <8 x i64> [[EXT]]
  %2 = shufflevector <64 x i8> %0, <64 x i8> poison, <8 x i32> <i32 2, i32 10, i32 18, i32 26, i32 34, i32 42, i32 50, i32 58>
  %3 = zext <8 x i8> %2 to <8 x i64>
  ret <8 x i64> %3
}

define <8 x i96> @Shuf64i8ZExt8i8to8i96(<64 x i8> %0) {
; CHECK-LABEL: @Shuf64i8ZExt8i8to8i96(
; SMALL-NEXT:    [[SHIFT:%.*]] = shufflevector <64 x i8> [[X:%.*]], <64 x i8> zeroinitializer, <96 x i32> <i32 2, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 10, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 18, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 26, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 34, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 42, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 50, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 58, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64>
; BIG-NEXT:      [[SHIFT:%.*]] = shufflevector <64 x i8> [[X:%.*]], <64 x i8> zeroinitializer, <96 x i32> <i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 2, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 10, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 18, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 26, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 34, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 42, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 50, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 58>
; CHECK-NEXT:    [[EXT:%.*]] = bitcast <96 x i8> [[SHIFT]] to <8 x i96>
; CHECK-NEXT:    ret <8 x i96> [[EXT]]
  %2 = shufflevector <64 x i8> %0, <64 x i8> poison, <8 x i32> <i32 2, i32 10, i32 18, i32 26, i32 34, i32 42, i32 50, i32 58>
  %3 = zext <8 x i8> %2 to <8 x i96>
  ret <8 x i96> %3
}

define <8 x i128> @Shuf64i8ZExt8i8to8i128(<64 x i8> %0) {
; CHECK-LABEL: @Shuf64i8ZExt8i8to8i128(
; SMALL-NEXT:    [[SHIFT:%.*]] = shufflevector <64 x i8> [[X:%.*]], <64 x i8> zeroinitializer, <128 x i32> <i32 2, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 10, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 18, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 26, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 34, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 42, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 50, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 58, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64>
; BIG-NEXT:      [[SHIFT:%.*]] = shufflevector <64 x i8> [[X:%.*]], <64 x i8> zeroinitializer, <128 x i32> <i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 2, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 10, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 18, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 26, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 34, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 42, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 50, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 58>
; CHECK-NEXT:    [[EXT:%.*]] = bitcast <128 x i8> [[SHIFT]] to <8 x i128>
; CHECK-NEXT:    ret <8 x i128> [[EXT]]
  %2 = shufflevector <64 x i8> %0, <64 x i8> poison, <8 x i32> <i32 2, i32 10, i32 18, i32 26, i32 34, i32 42, i32 50, i32 58>
  %3 = zext <8 x i8> %2 to <8 x i128>
  ret <8 x i128> %3
}


define <8 x i16> @Shuf1i8ZExt8i8to8i16(<1 x i8> %0) {
; CHECK-LABEL: @Shuf1i8ZExt8i8to8i16(
; SMALL-NEXT:    [[SHIFT:%.*]] = shufflevector <1 x i8> [[X:%.*]], <1 x i8> zeroinitializer, <16 x i32> <i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1>
; BIG-NEXT:      [[SHIFT:%.*]] = shufflevector <1 x i8> [[X:%.*]], <1 x i8> zeroinitializer, <16 x i32> <i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0>
; CHECK-NEXT:    [[EXT:%.*]] = bitcast <16 x i8> [[SHIFT]] to <8 x i16>
; CHECK-NEXT:    ret <8 x i16> [[EXT]]
  %2 = shufflevector <1 x i8> %0, <1 x i8> poison, <8 x i32> <i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0>
  %3 = zext <8 x i8> %2 to <8 x i16>
  ret <8 x i16> %3
}

define <8 x i32> @Shuf1i8ZExt8i8to8i32(<1 x i8> %0) {
; CHECK-LABEL: @Shuf1i8ZExt8i8to8i32(
; SMALL-NEXT:    [[SHIFT:%.*]] = shufflevector <1 x i8> [[X:%.*]], <1 x i8> zeroinitializer, <32 x i32> <i32 0, i32 1, i32 1, i32 1, i32 0, i32 1, i32 1, i32 1, i32 0, i32 1, i32 1, i32 1, i32 0, i32 1, i32 1, i32 1, i32 0, i32 1, i32 1, i32 1, i32 0, i32 1, i32 1, i32 1, i32 0, i32 1, i32 1, i32 1, i32 0, i32 1, i32 1, i32 1>
; BIG-NEXT:      [[SHIFT:%.*]] = shufflevector <1 x i8> [[X:%.*]], <1 x i8> zeroinitializer, <32 x i32> <i32 1, i32 1, i32 1, i32 0, i32 1, i32 1, i32 1, i32 0, i32 1, i32 1, i32 1, i32 0, i32 1, i32 1, i32 1, i32 0, i32 1, i32 1, i32 1, i32 0, i32 1, i32 1, i32 1, i32 0, i32 1, i32 1, i32 1, i32 0, i32 1, i32 1, i32 1, i32 0>
; CHECK-NEXT:    [[EXT:%.*]] = bitcast <32 x i8> [[SHIFT]] to <8 x i32>
; CHECK-NEXT:    ret <8 x i32> [[EXT]]
  %2 = shufflevector <1 x i8> %0, <1 x i8> poison, <8 x i32> <i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0>
  %3 = zext <8 x i8> %2 to <8 x i32>
  ret <8 x i32> %3
}

define <8 x i64> @Shuf1i8ZExt8i8to8i64(<1 x i8> %0) {
; CHECK-LABEL: @Shuf1i8ZExt8i8to8i64(
; SMALL-NEXT:    [[SHIFT:%.*]] = shufflevector <1 x i8> [[X:%.*]], <1 x i8> zeroinitializer, <64 x i32> <i32 0, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 0, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 0, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 0, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 0, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 0, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 0, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 0, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
; BIG-NEXT:      [[SHIFT:%.*]] = shufflevector <1 x i8> [[X:%.*]], <1 x i8> zeroinitializer, <64 x i32> <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 0, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 0, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 0, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 0, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 0, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 0, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 0, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 0>
; CHECK-NEXT:    [[EXT:%.*]] = bitcast <64 x i8> [[SHIFT]] to <8 x i64>
; CHECK-NEXT:    ret <8 x i64> [[EXT]]
  %2 = shufflevector <1 x i8> %0, <1 x i8> poison, <8 x i32> <i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0>
  %3 = zext <8 x i8> %2 to <8 x i64>
  ret <8 x i64> %3
}

define <8 x i96> @Shuf1i8ZExt8i8to8i96(<1 x i8> %0) {
; CHECK-LABEL: @Shuf1i8ZExt8i8to8i96(
; SMALL-NEXT:    [[SHIFT:%.*]] = shufflevector <1 x i8> [[X:%.*]], <1 x i8> zeroinitializer, <96 x i32> <i32 0, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 0, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 0, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 0, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 0, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 0, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 0, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 0, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
; BIG-NEXT:      [[SHIFT:%.*]] = shufflevector <1 x i8> [[X:%.*]], <1 x i8> zeroinitializer, <96 x i32> <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 0, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 0, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 0, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 0, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 0, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 0, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 0, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 0>
; CHECK-NEXT:    [[EXT:%.*]] = bitcast <96 x i8> [[SHIFT]] to <8 x i96>
; CHECK-NEXT:    ret <8 x i96> [[EXT]]
  %2 = shufflevector <1 x i8> %0, <1 x i8> poison, <8 x i32> <i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0>
  %3 = zext <8 x i8> %2 to <8 x i96>
  ret <8 x i96> %3
}

define <8 x i128> @Shuf1i8ZExt8i8to8i128(<1 x i8> %0) {
; CHECK-LABEL: @Shuf1i8ZExt8i8to8i128(
; SMALL-NEXT:    [[SHIFT:%.*]] = shufflevector <1 x i8> [[X:%.*]], <1 x i8> zeroinitializer, <128 x i32> <i32 0, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 0, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 0, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 0, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 0, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 0, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 0, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 0, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
; BIG-NEXT:      [[SHIFT:%.*]] = shufflevector <1 x i8> [[X:%.*]], <1 x i8> zeroinitializer, <128 x i32> <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 0, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 0, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 0, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 0, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 0, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 0, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 0, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 0>
; CHECK-NEXT:    [[EXT:%.*]] = bitcast <128 x i8> [[SHIFT]] to <8 x i128>
; CHECK-NEXT:    ret <8 x i128> [[EXT]]
  %2 = shufflevector <1 x i8> %0, <1 x i8> poison, <8 x i32> <i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0>
  %3 = zext <8 x i8> %2 to <8 x i128>
  ret <8 x i128> %3
}


define <8 x i8> @ShufZ64i4Ext8i4to8i8(<64 x i4> %0) {
; CHECK-LABEL: @ShufZ64i4Ext8i4to8i8(
; SMALL-NEXT:    [[SHIFT:%.*]] = shufflevector <64 x i4> [[X:%.*]], <64 x i4> zeroinitializer, <16 x i32> <i32 2, i32 64, i32 10, i32 64, i32 18, i32 64, i32 26, i32 64, i32 34, i32 64, i32 42, i32 64, i32 50, i32 64, i32 58, i32 64>
; BIG-NEXT:      [[SHIFT:%.*]] = shufflevector <64 x i4> [[X:%.*]], <64 x i4> zeroinitializer, <16 x i32> <i32 64, i32 2, i32 64, i32 10, i32 64, i32 18, i32 64, i32 26, i32 64, i32 34, i32 64, i32 42, i32 64, i32 50, i32 64, i32 58>
; CHECK-NEXT:    [[EXT:%.*]] = bitcast <16 x i4> [[SHIFT]] to <8 x i8>
; CHECK-NEXT:    ret <8 x i8> [[EXT]]
  %2 = shufflevector <64 x i4> %0, <64 x i4> poison, <8 x i32> <i32 2, i32 10, i32 18, i32 26, i32 34, i32 42, i32 50, i32 58>
  %3 = zext <8 x i4> %2 to <8 x i8>
  ret <8 x i8> %3
}

define <8 x i16> @ShufZ64i4Ext8i4to8i16(<64 x i4> %0) {
; CHECK-LABEL: @ShufZ64i4Ext8i4to8i16(
; SMALL-NEXT:    [[SHIFT:%.*]] = shufflevector <64 x i4> [[X:%.*]], <64 x i4> zeroinitializer, <32 x i32> <i32 2, i32 64, i32 64, i32 64, i32 10, i32 64, i32 64, i32 64, i32 18, i32 64, i32 64, i32 64, i32 26, i32 64, i32 64, i32 64, i32 34, i32 64, i32 64, i32 64, i32 42, i32 64, i32 64, i32 64, i32 50, i32 64, i32 64, i32 64, i32 58, i32 64, i32 64, i32 64>
; BIG-NEXT:      [[SHIFT:%.*]] = shufflevector <64 x i4> [[X:%.*]], <64 x i4> zeroinitializer, <32 x i32> <i32 64, i32 64, i32 64, i32 2, i32 64, i32 64, i32 64, i32 10, i32 64, i32 64, i32 64, i32 18, i32 64, i32 64, i32 64, i32 26, i32 64, i32 64, i32 64, i32 34, i32 64, i32 64, i32 64, i32 42, i32 64, i32 64, i32 64, i32 50, i32 64, i32 64, i32 64, i32 58>
; CHECK-NEXT:    [[EXT:%.*]] = bitcast <32 x i4> [[SHIFT]] to <8 x i16>
; CHECK-NEXT:    ret <8 x i16> [[EXT]]
  %2 = shufflevector <64 x i4> %0, <64 x i4> poison, <8 x i32> <i32 2, i32 10, i32 18, i32 26, i32 34, i32 42, i32 50, i32 58>
  %3 = zext <8 x i4> %2 to <8 x i16>
  ret <8 x i16> %3
}

define <8 x i32> @Shuf64i4ZExt8i4to8i32(<64 x i4> %0) {
; CHECK-LABEL: @Shuf64i4ZExt8i4to8i32(
; SMALL-NEXT:    [[SHIFT:%.*]] = shufflevector <64 x i4> [[X:%.*]], <64 x i4> zeroinitializer, <64 x i32> <i32 2, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 10, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 18, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 26, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 34, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 42, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 50, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 58, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64>
; BIG-NEXT:      [[SHIFT:%.*]] = shufflevector <64 x i4> [[X:%.*]], <64 x i4> zeroinitializer, <64 x i32> <i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 2, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 10, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 18, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 26, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 34, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 42, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 50, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 58>
; CHECK-NEXT:    [[EXT:%.*]] = bitcast <64 x i4> [[SHIFT]] to <8 x i32>
; CHECK-NEXT:    ret <8 x i32> [[EXT]]
  %2 = shufflevector <64 x i4> %0, <64 x i4> poison, <8 x i32> <i32 2, i32 10, i32 18, i32 26, i32 34, i32 42, i32 50, i32 58>
  %3 = zext <8 x i4> %2 to <8 x i32>
  ret <8 x i32> %3
}

define <8 x i64> @Shuf64i4ZExt8i4to8i64(<64 x i4> %0) {
; CHECK-LABEL: @Shuf64i4ZExt8i4to8i64(
; SMALL-NEXT:    [[SHIFT:%.*]] = shufflevector <64 x i4> [[X:%.*]], <64 x i4> zeroinitializer, <128 x i32> <i32 2, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 10, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 18, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 26, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 34, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 42, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 50, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 58, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64>
; BIG-NEXT:      [[SHIFT:%.*]] = shufflevector <64 x i4> [[X:%.*]], <64 x i4> zeroinitializer, <128 x i32> <i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 2, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 10, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 18, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 26, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 34, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 42, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 50, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 58>
; CHECK-NEXT:    [[EXT:%.*]] = bitcast <128 x i4> [[SHIFT]] to <8 x i64>
; CHECK-NEXT:    ret <8 x i64> [[EXT]]
  %2 = shufflevector <64 x i4> %0, <64 x i4> poison, <8 x i32> <i32 2, i32 10, i32 18, i32 26, i32 34, i32 42, i32 50, i32 58>
  %3 = zext <8 x i4> %2 to <8 x i64>
  ret <8 x i64> %3
}

define <8 x i96> @Shuf64i4ZExt8i4to8i96(<64 x i4> %0) {
; CHECK-LABEL: @Shuf64i4ZExt8i4to8i96(
; SMALL-NEXT:    [[SHIFT:%.*]] = shufflevector <64 x i4> [[X:%.*]], <64 x i4> zeroinitializer, <192 x i32> <i32 2, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 10, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 18, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 26, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 34, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 42, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 50, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 58, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64>
; BIG-NEXT:      [[SHIFT:%.*]] = shufflevector <64 x i4> [[X:%.*]], <64 x i4> zeroinitializer, <192 x i32> <i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 2, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 10, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 18, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 26, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 34, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 42, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 50, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 58>
; CHECK-NEXT:    [[EXT:%.*]] = bitcast <192 x i4> [[SHIFT]] to <8 x i96>
; CHECK-NEXT:    ret <8 x i96> [[EXT]]
  %2 = shufflevector <64 x i4> %0, <64 x i4> poison, <8 x i32> <i32 2, i32 10, i32 18, i32 26, i32 34, i32 42, i32 50, i32 58>
  %3 = zext <8 x i4> %2 to <8 x i96>
  ret <8 x i96> %3
}

define <8 x i128> @Shuf64i4ZExt8i4to8i128(<64 x i4> %0) {
; CHECK-LABEL: @Shuf64i4ZExt8i4to8i128(
; SMALL-NEXT:    [[SHIFT:%.*]] = shufflevector <64 x i4> [[X:%.*]], <64 x i4> zeroinitializer, <256 x i32> <i32 2, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 10, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 18, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 26, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 34, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 42, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 50, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 58, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64>
; BIG-NEXT:      [[SHIFT:%.*]] = shufflevector <64 x i4> [[X:%.*]], <64 x i4> zeroinitializer, <256 x i32> <i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 2, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 10, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 18, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 26, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 34, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 42, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 50, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 58>
; CHECK-NEXT:    [[EXT:%.*]] = bitcast <256 x i4> [[SHIFT]] to <8 x i128>
; CHECK-NEXT:    ret <8 x i128> [[EXT]]
  %2 = shufflevector <64 x i4> %0, <64 x i4> poison, <8 x i32> <i32 2, i32 10, i32 18, i32 26, i32 34, i32 42, i32 50, i32 58>
  %3 = zext <8 x i4> %2 to <8 x i128>
  ret <8 x i128> %3
}


define <1 x i16> @Shuf64i8ZExt1i8to1i16(<64 x i8> %0) {
; CHECK-LABEL: @Shuf64i8ZExt1i8to1i16(
; SMALL-NEXT:    [[SHIFT:%.*]] = shufflevector <64 x i8> [[X:%.*]], <64 x i8> zeroinitializer, <2 x i32> <i32 1, i32 64>
; BIG-NEXT:      [[SHIFT:%.*]] = shufflevector <64 x i8> [[X:%.*]], <64 x i8> zeroinitializer, <2 x i32> <i32 64, i32 1>
; CHECK-NEXT:    [[EXT:%.*]] = bitcast <2 x i8> [[SHIFT]] to <1 x i16>
; CHECK-NEXT:    ret <1 x i16> [[EXT]]
  %2 = shufflevector <64 x i8> %0, <64 x i8> poison, <1 x i32> <i32 1>
  %3 = zext <1 x i8> %2 to <1 x i16>
  ret <1 x i16> %3
}

define <1 x i32> @Shuf64i8ZExt1i8to8i32(<64 x i8> %0) {
; CHECK-LABEL: @Shuf64i8ZExt1i8to8i32(
; SMALL-NEXT:    [[SHIFT:%.*]] = shufflevector <64 x i8> [[X:%.*]], <64 x i8> zeroinitializer, <4 x i32> <i32 2, i32 64, i32 64, i32 64>
; BIG-NEXT:      [[SHIFT:%.*]] = shufflevector <64 x i8> [[X:%.*]], <64 x i8> zeroinitializer, <4 x i32> <i32 64, i32 64, i32 64, i32 2>
; CHECK-NEXT:    [[EXT:%.*]] = bitcast <4 x i8> [[SHIFT]] to <1 x i32>
; CHECK-NEXT:    ret <1 x i32> [[EXT]]
  %2 = shufflevector <64 x i8> %0, <64 x i8> poison, <1 x i32> <i32 2>
  %3 = zext <1 x i8> %2 to <1 x i32>
  ret <1 x i32> %3
}

define <1 x i64> @Shuf64i8ZExt1i8to1i64(<64 x i8> %0) {
; CHECK-LABEL: @Shuf64i8ZExt1i8to1i64(
; SMALL-NEXT:    [[SHIFT:%.*]] = shufflevector <64 x i8> [[X:%.*]], <64 x i8> zeroinitializer, <8 x i32> <i32 3, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64>
; BIG-NEXT:      [[SHIFT:%.*]] = shufflevector <64 x i8> [[X:%.*]], <64 x i8> zeroinitializer, <8 x i32> <i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 3>
; CHECK-NEXT:    [[EXT:%.*]] = bitcast <8 x i8> [[SHIFT]] to <1 x i64>
; CHECK-NEXT:    ret <1 x i64> [[EXT]]
  %2 = shufflevector <64 x i8> %0, <64 x i8> poison, <1 x i32> <i32 3>
  %3 = zext <1 x i8> %2 to <1 x i64>
  ret <1 x i64> %3
}

define <1 x i96> @Shuf64i8ZExt1i8to1i96(<64 x i8> %0) {
; CHECK-LABEL: @Shuf64i8ZExt1i8to1i96(
; SMALL-NEXT:    [[SHIFT:%.*]] = shufflevector <64 x i8> [[X:%.*]], <64 x i8> zeroinitializer, <12 x i32> <i32 4, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64>
; BIG-NEXT:      [[SHIFT:%.*]] = shufflevector <64 x i8> [[X:%.*]], <64 x i8> zeroinitializer, <12 x i32> <i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 4>
; CHECK-NEXT:    [[EXT:%.*]] = bitcast <12 x i8> [[SHIFT]] to <1 x i96>
; CHECK-NEXT:    ret <1 x i96> [[EXT]]
  %2 = shufflevector <64 x i8> %0, <64 x i8> poison, <1 x i32> <i32 4>
  %3 = zext <1 x i8> %2 to <1 x i96>
  ret <1 x i96> %3
}

define <1 x i128> @Shuf64i8ZExt1i8to1i128(<64 x i8> %0) {
; CHECK-LABEL: @Shuf64i8ZExt1i8to1i128(
; SMALL-NEXT:    [[SHIFT:%.*]] = shufflevector <64 x i8> [[X:%.*]], <64 x i8> zeroinitializer, <16 x i32> <i32 5, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64>
; BIG-NEXT:      [[SHIFT:%.*]] = shufflevector <64 x i8> [[X:%.*]], <64 x i8> zeroinitializer, <16 x i32> <i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 5>
; CHECK-NEXT:    [[EXT:%.*]] = bitcast <16 x i8> [[SHIFT]] to <1 x i128>
; CHECK-NEXT:    ret <1 x i128> [[EXT]]
  %2 = shufflevector <64 x i8> %0, <64 x i8> poison, <1 x i32> <i32 5>
  %3 = zext <1 x i8> %2 to <1 x i128>
  ret <1 x i128> %3
}
