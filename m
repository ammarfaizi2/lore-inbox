Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263544AbUCTVbG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 16:31:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263548AbUCTVbG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 16:31:06 -0500
Received: from mail.kroah.org ([65.200.24.183]:13240 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263544AbUCTVbD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 16:31:03 -0500
Date: Sat, 20 Mar 2004 13:30:30 -0800
From: Greg KH <greg@kroah.com>
To: Kronos <kronos@kronoz.cjb.net>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Sysfs for framebuffer
Message-ID: <20040320213030.GA3950@kroah.com>
References: <20040320174956.GA3177@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040320174956.GA3177@dreamland.darkstar.lan>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 20, 2004 at 06:49:56PM +0100, Kronos wrote:
> Hi,
> the following patch (against 2.6.5-rc2) teaches fb to use class_simple.
> With this patch udev will automagically create device nodes for each
> framebuffer registered. Once all drivers are converted to
> framebuffer_{alloc,release} we can switch to our own class.

yeah, it's about time!  Didn't I post this patch a few months ago... :)

Anyway, it looks good, I only have one comment:

> notebook:~# tree /sys/class/graphics/
> /sys/class/graphics/

"graphics"?  Why that?  Why not "fb"?

It doesn't really matter to me, just curious.

thanks,

greg k-h
