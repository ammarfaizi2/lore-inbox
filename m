Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275224AbRJJKUE>; Wed, 10 Oct 2001 06:20:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275255AbRJJKTy>; Wed, 10 Oct 2001 06:19:54 -0400
Received: from fismat1.fcfm.buap.mx ([148.228.125.1]:31150 "EHLO
	fismat1.fcfm.buap.mx") by vger.kernel.org with ESMTP
	id <S275224AbRJJKTh>; Wed, 10 Oct 2001 06:19:37 -0400
Date: Wed, 10 Oct 2001 04:19:29 -0500 (CDT)
From: Luis Montgomery <monty@fismat1.fcfm.buap.mx>
To: linux-kernel@vger.kernel.org
Subject: 2.4.11: problem with at1700
Message-ID: <Pine.GSO.4.21.0110100409260.27961-100000@fismat1.fcfm.buap.mx>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I try to compile 2.4.11 and find this error:

gcc -D__KERNEL__ -I/usr/src/linux-2.4.11/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE -DMODVERSIONS
-include /usr/src/linux-2.4.11/include/linux/modversions.h   -c -o
at1700.o at1700.c
at1700.c:475: conflicting types for `read_eeprom'
at1700.c:161: previous declaration of `read_eeprom'
make[2]: *** [at1700.o] Error 1

Luis Montgomery

