Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263513AbUAHCTv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 21:19:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263522AbUAHCTv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 21:19:51 -0500
Received: from fw.osdl.org ([65.172.181.6]:17824 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263513AbUAHCTu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 21:19:50 -0500
Date: Wed, 7 Jan 2004 18:19:42 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andries Brouwer <aebr@win.tue.nl>
cc: Greg KH <greg@kroah.com>, Andrey Borzenkov <arvidjaar@mail.ru>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: removable media revalidation - udev vs. devfs or static /dev
In-Reply-To: <20040108031357.A1396@pclin040.win.tue.nl>
Message-ID: <Pine.LNX.4.58.0401071815320.12602@home.osdl.org>
References: <200401012333.04930.arvidjaar@mail.ru> <20040103055847.GC5306@kroah.com>
 <Pine.LNX.4.58.0401071036560.12602@home.osdl.org> <20040108031357.A1396@pclin040.win.tue.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 8 Jan 2004, Andries Brouwer wrote:
>
> Now the plan (or at least my plan) has always been to remove all
> partition detection from the kernel. It can all be done from user space.

We had this discussion last year. It makes no sense to cripple the kernel 
that way. Not gonna happen.

When I insert a card in my card reader, it had better "just work". WITHOUT 
any strange "poll another device Y to make device X" work.

		Linus
