Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966196AbWKXVxm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966196AbWKXVxm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 16:53:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966203AbWKXVxm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 16:53:42 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:38867
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S966196AbWKXVxl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 16:53:41 -0500
Date: Fri, 24 Nov 2006 13:53:51 -0800 (PST)
Message-Id: <20061124.135351.94073762.davem@davemloft.net>
To: art@usfltd.com
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: 2.6.19-git compilation error pulled-2006/11/24/14:30CST -
 spin_lock_irqsave_nested
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061124144015.g6dnes3jb808884k@69.222.0.225>
References: <20061124144015.g6dnes3jb808884k@69.222.0.225>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: art@usfltd.com
Date: Fri, 24 Nov 2006 14:40:15 -0600

> [linux-git-pull]$ make -j 8
>    CHK     include/linux/version.h
>    CHK     include/linux/utsrelease.h
>    CHK     include/linux/compile.h
>    MODPOST vmlinux
>    Building modules, stage 2.
> Kernel: arch/x86_64/boot/bzImage is ready  (#26)
>    MODPOST 1290 modules
> WARNING: "spin_lock_irqsave_nested" [net/irda/irda.ko] undefined!
> make[1]: *** [__modpost] Error 1
> make: *** [modules] Error 2

Well know problem, probably reported 5 or so times already on
this list, and it will be fixed when a patch is merged by Andrew
to Linus.

Please check the archives before making reports, thanks!
