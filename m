Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290228AbSCSSof>; Tue, 19 Mar 2002 13:44:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290593AbSCSSob>; Tue, 19 Mar 2002 13:44:31 -0500
Received: from air-2.osdl.org ([65.201.151.6]:43790 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S290228AbSCSSoR>;
	Tue, 19 Mar 2002 13:44:17 -0500
Date: Tue, 19 Mar 2002 10:43:44 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Adrian Bunk <bunk@fs.tum.de>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.19pre3-ac2
In-Reply-To: <Pine.NEB.4.44.0203191852570.3932-100000@mimas.fachschaften.tu-muenchen.de>
Message-ID: <Pine.LNX.4.33L2.0203191043240.8339-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, I'll look into it.

~Randy

On Tue, 19 Mar 2002, Adrian Bunk wrote:

| On Tue, 19 Mar 2002, Alan Cox wrote:
|
| > Linux 2.4.19pre3-ac2
| >...
| > o	Add iconfig  (save/extract config from kernel	(Randy Dunlap)
| > 	image file)
| >...
|
| This sounds like a nice feature. Unfortunately it doesn't compile when you
| are building a kernel without module support (CONFIG_MODULES is not set):
|
| <--  snip  -->
|
| ...
| gcc -D__KERNEL__ -I/home/bunk/linux/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=k6   -DEXPORT_SYMTAB -c -o configs.o configs.c
| In file included from configs.c:2:
| /home/bunk/linux/linux/include/linux/module.h:21: linux/modversions.h: No such file or directory
| make[2]: *** [configs.o] Error 1
| make[2]: Leaving directory `/home/bunk/linux/linux/kernel'
| make[1]: *** [first_rule] Error 2
| make[1]: Leaving directory `/home/bunk/linux/linux/kernel'
| make: *** [_dir_kernel] Error 2
|
| <--  snip  -->
|
| cu
| Adrian
|
| -

