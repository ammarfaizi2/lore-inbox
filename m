Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269756AbRHQI2r>; Fri, 17 Aug 2001 04:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269905AbRHQI2h>; Fri, 17 Aug 2001 04:28:37 -0400
Received: from [209.10.41.242] ([209.10.41.242]:42454 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S269756AbRHQI20>;
	Fri, 17 Aug 2001 04:28:26 -0400
Date: Fri, 17 Aug 2001 03:06:58 +0200 (CEST)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.9 does not compile (adaptec new driver)
In-Reply-To: <200108162111.XAA07177@db0bm.ampr.org>
Message-ID: <Pine.LNX.4.33.0108170305040.2148-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


HI, fast to patch, but still noisy

make[5]: Entering directory
`/usr/src/linux-2.4.9/drivers/scsi/aic7xxx/aicasm'
gcc -I/usr/include -I. -ldb aicasm_gram.c aicasm_scan.c aicasm.c
aicasm_symbol.c -o aicasm
aicasm/aicasm_scan.l: In function `yylex':
aicasm/aicasm_scan.l:115: `T_VERSION' undeclared (first use in this
function)
aicasm/aicasm_scan.l:115: (Each undeclared identifier is reported only
once
aicasm/aicasm_scan.l:115: for each function it appears in.)
aicasm/aicasm_scan.l:132: `T_STRING' undeclared (first use in this
function)
make[5]: *** [aicasm] Error 1
make[5]: Leaving directory
`/usr/src/linux-2.4.9/drivers/scsi/aic7xxx/aicasm'
make[4]: *** [aicasm/aicasm] Error 2
make[4]: Leaving directory `/usr/src/linux-2.4.9/drivers/scsi/aic7xxx'
make[3]: *** [first_rule] Error 2
make[3]: Leaving directory `/usr/src/linux-2.4.9/drivers/scsi/aic7xxx'
make[2]: *** [_subdir_aic7xxx] Error 2
make[2]: Leaving directory `/usr/src/linux-2.4.9/drivers/scsi'
make[1]: *** [_subdir_scsi] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.9/drivers'
make: *** [_dir_drivers] Error 2

bests
Luigi


