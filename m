Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932226AbWARFES@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226AbWARFES (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 00:04:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932275AbWARFES
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 00:04:18 -0500
Received: from mail.kroah.org ([69.55.234.183]:30848 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932226AbWARFER (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 00:04:17 -0500
Date: Tue, 17 Jan 2006 20:59:30 -0800
From: Greg KH <greg@kroah.com>
To: David R <david@unsolicited.net>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.16-rc1
Message-ID: <20060118045930.GC7292@kroah.com>
References: <Pine.LNX.4.64.0601170001530.13339@g5.osdl.org> <43CD4504.8020705@unsolicited.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43CD4504.8020705@unsolicited.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2006 at 07:27:00PM +0000, David R wrote:
> Linus Torvalds wrote:
> > Ok, it's two weeks since 2.6.15, and the merge window is closed.
> 
> Everything seems fine with rc1 on my VIA Based Athlon 64 (64 bit kernel, SuSE
> 10 base) apart from my USB2 scanner. It's detected just fine (as normal), but
> the (32bit) copy of VueScan that I use crawls along during preview like a
> constipated tortoise. This is markedly similar to when 2.6.15 is under heavy
> CPU load... high speed USB transfers slow to a crawl then too but everything
> is fine at other times.
> 
> dmesg etc looks ok. I'd appreciate it if anyone has any thoughts?

Nothing has changed in usbfs that might cause this that I know of.  Can
you use git to bisect what patch caused it?

thanks,

greg k-h
