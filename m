Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314929AbSFDQfg>; Tue, 4 Jun 2002 12:35:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315192AbSFDQff>; Tue, 4 Jun 2002 12:35:35 -0400
Received: from front1.mail.megapathdsl.net ([66.80.60.31]:6916 "EHLO
	front1.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S315191AbSFDQfd>; Tue, 4 Jun 2002 12:35:33 -0400
Subject: 2.5.20-dj1 + fbcmap.c patch -- neofb.c:71: video/neomagic.h: No
	such file or directory
From: Miles Lane <miles@megapathdsl.net>
To: linux-kernel@vger.kernel.org, jsimmons@transvirtual.com
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5.99 
Date: 04 Jun 2002 09:56:14 -0700
Message-Id: <1023209774.20260.24.camel@agate>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



gcc -D__KERNEL__ -I/usr/src/linux-2.5/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer
-pipe -mpreferred-stack-boundary=2 -march=i686   
-DKBUILD_BASENAME=neofb  -c -o neofb.o neofb.c
neofb.c:71: video/neomagic.h: No such file or directory
neofb.c:108: parse error before `bios8'
neofb.c:108: warning: type defaults to `int' in declaration of `bios8'
neofb.c:109: warning: braces around scalar initializer
neofb.c:109: warning: (near initialization for `bios8[0]')
neofb.c:109: warning: excess elements in scalar initializer
...
neofb.c: In function `neoFindMode':
neofb.c:145: `biosMode' undeclared (first use in this function)
neofb.c:145: (Each undeclared identifier is reported only once
neofb.c:145: for each function it appears in.)
neofb.c:145: `mode' undeclared (first use in this function)
neofb.c:145: warning: statement with no effect
neofb.c:182: warning: control reaches end of non-void function
neofb.c: In function `neoCalcVCLK':
neofb.c:228: dereferencing pointer to incomplete type
neofb.c:229: dereferencing pointer to incomplete type
neofb.c:231: dereferencing pointer to incomplete type
neofb.c:233: dereferencing pointer to incomplete type
neofb.c: At top level:
neofb.c:252: warning: `struct xtimings' declared inside parameter list
neofb.c:252: warning: its scope is only this definition or declaration,
which is probably not what you want.
neofb.c: In function `vgaHWInit':
neofb.c:254: dereferencing pointer to incomplete type
...

