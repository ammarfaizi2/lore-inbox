Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267205AbSKPC1U>; Fri, 15 Nov 2002 21:27:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267206AbSKPC1U>; Fri, 15 Nov 2002 21:27:20 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:52400 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267205AbSKPC1T>; Fri, 15 Nov 2002 21:27:19 -0500
Subject: Re: 2.5.47 - unresolved symbols
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: trelane@digitasaru.net
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021115174417.GC2828@digitasaru.net>
References: <20021115174417.GC2828@digitasaru.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 16 Nov 2002 03:00:43 +0000
Message-Id: <1037415643.21974.31.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-11-15 at 17:44, Joseph Pingenot wrote:
> The following seem to be unresolved symbols when make modules_install:
> if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.47; fi
> depmod: *** Unresolved symbols in /lib/modules/2.5.47/kernel/drivers/char/raw.o
> depmod:         blkdev_ioctl

Patch on the list 

> depmod: *** Unresolved symbols in /lib/modules/2.5.47/kernel/fs/binfmt_aout.o
> depmod:         ptrace_notify

Ditto and fixed in -ac4

