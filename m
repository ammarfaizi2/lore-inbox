Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316500AbSFUJOf>; Fri, 21 Jun 2002 05:14:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316512AbSFUJOe>; Fri, 21 Jun 2002 05:14:34 -0400
Received: from cibs9.sns.it ([192.167.206.29]:27150 "EHLO cibs9.sns.it")
	by vger.kernel.org with ESMTP id <S316500AbSFUJOd>;
	Fri, 21 Jun 2002 05:14:33 -0400
Date: Fri, 21 Jun 2002 11:14:32 +0200 (CEST)
From: venom@sns.it
To: linux-kernel@vger.kernel.org
Subject: khttpd module compile error with kernel 2.5.24 
Message-ID: <Pine.LNX.4.43.0206211114100.15090-100000@cibs9.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HI,

make[2]: Entering directory `/usr/src/linux-2.5.24/net/khttpd'
  gcc -Wp,-MD,./.rfc_time.o.d -D__KERNEL__ -I/usr/src/linux-2.5.24/include
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=pentium3 -nostdinc -iwithprefix include -DMODULE
-DKBUILD_BASENAME=rfc_time   -c -o rfc_time.o rfc_time.c
rfc_time.c: In function `time_Unix2RFC':
rfc_time.c:73: `KHTTPD_NUMYEARS' undeclared (first use in this function)
rfc_time.c:73: (Each undeclared identifier is reported only once
rfc_time.c:73: for each function it appears in.)
rfc_time.c:75: `TimeDays' undeclared (first use in this function)
rfc_time.c:97: `WeekDays' undeclared (first use in this function)
rfc_time.c:109: `KHTTPD_YEAROFFSET' undeclared (first use in this
function)
rfc_time.c: In function `mimeTime_to_UnixTime':
rfc_time.c:220: `KHTTPD_YEAROFFSET' undeclared (first use in this
function)
rfc_time.c:223: `TimeDays' undeclared (first use in this function)
make[2]: *** [rfc_time.o] Error 1


Hope this helps.

Luigi



