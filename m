Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266377AbRGBGD4>; Mon, 2 Jul 2001 02:03:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266378AbRGBGDq>; Mon, 2 Jul 2001 02:03:46 -0400
Received: from freya.yggdrasil.com ([209.249.10.20]:9709 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S266377AbRGBGD3>; Mon, 2 Jul 2001 02:03:29 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sun, 1 Jul 2001 23:03:23 -0700
Message-Id: <200107020603.XAA02015@baldur.yggdrasil.com>
To: kaos@ocs.com.au
Subject: Re: [PATCH] Re: 2.4.6p6: dep_{bool,tristate} $CONFIG_ARCH_xxx bugs
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, rhw@MemAlpha.CX,
        rmk@arm.linux.org.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have minor correction to make.  I wrote:
>        In linux-2.4.6-pre8, there are only three configuration variables
>that are defined with an indented 'define_bool' statement
>(CONFIG_BLK_DEV_IDE{DMA,PCI}, and CONFIG_PCI),

I meant three configuration variables that are defined with an
indented 'define_bool' statement _and are used as arguments to
a dep_* command_.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
