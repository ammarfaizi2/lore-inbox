Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266335AbSKGEaP>; Wed, 6 Nov 2002 23:30:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266339AbSKGEaP>; Wed, 6 Nov 2002 23:30:15 -0500
Received: from air-2.osdl.org ([65.172.181.6]:52920 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S266335AbSKGEaP>;
	Wed, 6 Nov 2002 23:30:15 -0500
Date: Wed, 6 Nov 2002 20:32:16 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: mike <mike@redtux.demon.co.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: problem with unresolved symbols 2.5.46
In-Reply-To: <1036638244.19136.2.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.33L2.0211062031180.25965-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 Nov 2002, mike wrote:

| I am, getting the following error at the end of a kernel compile
|
| make -f scripts/Makefile.modinst obj=arch/i386/lib
| if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.46; fi
| depmod: *** Unresolved symbols in
| /lib/modules/2.5.46/kernel/drivers/char/raw.o
| depmod:         blkdev_ioctl
|
| I have tried with gcc 3.2 and 2.96 no difference

You are trying to build the 'raw' driver as a module.
Either build it in-kernel or find the patch for this that
was posted last Thurs. or Friday by Bob Miller (rem@osdl.org).

-- 
~Randy

