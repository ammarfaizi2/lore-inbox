Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264789AbSKEKk7>; Tue, 5 Nov 2002 05:40:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264792AbSKEKk7>; Tue, 5 Nov 2002 05:40:59 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:47508 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264789AbSKEKk6>; Tue, 5 Nov 2002 05:40:58 -0500
Subject: Re: Linux v2.5.46 (compile error)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: michael@kummer.cc
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0211051032580.246-100000@epo>
References: <Pine.LNX.4.44.0211051032580.246-100000@epo>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 05 Nov 2002 11:09:37 +0000
Message-Id: <1036494577.4827.16.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-11-05 at 09:35, Michael Kummer wrote:
> drivers/message/i2o/i2o_block.o drivers/message/i2o/i2o_block.c
> drivers/message/i2o/i2o_block.c: In function `i2o_block_init':
> drivers/message/i2o/i2o_block.c:1672: warning: implicit declaration of
> function `BLK_DEFAULT_QUEUE'

Fixed in -ac

>   gcc -Wp,-MD,drivers/message/i2o/.i2o_lan.o.d -D__KERNEL__ -Iinclude
> -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
> -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
> -march=i686 -malign-functions=4 -Iarch/i386/mach-generic -nostdinc
> -iwithprefix include    -DKBUILD_BASENAME=i2o_lan   -c -o
> drivers/message/i2o/i2o_lan.o drivers/message/i2o/i2o_lan.c

Anyone who wants i2o_lan will be fixing it themselves. I don't have any
usable i2o_lan hardware any more. nor in truth was there much ever in
existance.


