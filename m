Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264434AbUAYPl4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 10:41:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264445AbUAYPl4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 10:41:56 -0500
Received: from mid-1.inet.it ([213.92.5.18]:19628 "EHLO mid-1.inet.it")
	by vger.kernel.org with ESMTP id S264434AbUAYPly (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 10:41:54 -0500
From: Fabio Coatti <cova@ferrara.linux.it>
Organization: FerraraLUG
To: Adrian Bunk <bunk@fs.tum.de>
Subject: Re: Kernels > 2.6.1-mm3 do not boot.
Date: Sun, 25 Jan 2004 16:39:56 +0100
User-Agent: KMail/1.6
Cc: Eric <eric@cisu.net>, linux-kernel@vger.kernel.org
References: <200401232253.08552.eric@cisu.net> <200401251452.58318.cova@ferrara.linux.it> <20040125143438.GI513@fs.tum.de>
In-Reply-To: <20040125143438.GI513@fs.tum.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200401251639.56799.cova@ferrara.linux.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alle Sunday 25 January 2004 15:34, Adrian Bunk ha scritto:

> I sent the following to Eric:

[...]

sorry, I've seen your mail just few seconds after sending my message; anyway 
I've tried following your suggestions:

>
> Please try 2.6.2-rc1 (without any -mm patch).

Works just fine.

>
> If this kernel works, please try -mm4 with disabled SMP support and
> support for the Athlon (and no other CPUs).

Doesn't work

> If you compile with
>   make V=1

  gcc -Wp,-MD,fs/.dcache.o.d -nostdinc -iwithprefix include -D__KERNEL__ 
-Iinclude  -D__KERNEL__ -Iinclude  -Wall -Wstrict-prototypes -Wno-trigraphs 
-fno-strict-aliasing -fno-common -pipe -msoft-float 
-mpreferred-stack-boundary=2 -march=pentium4 -Iinclude/asm-i386/mach-default 
-O2 -fomit-frame-pointer -funit-at-a-time     -DKBUILD_BASENAME=dcache 
-DKBUILD_MODNAME=dcache -c -o fs/.tmp_dcache.o fs/dcache.c


-- 
Fabio Coatti       http://www.ferrara.linux.it/members/cova     
Ferrara Linux Users Group           http://ferrara.linux.it
GnuPG fp:9765 A5B6 6843 17BC A646  BE8C FA56 373A 5374 C703
Old SysOps never die... they simply forget their password.
