Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261595AbUB0BDv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 20:03:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261571AbUB0BC2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 20:02:28 -0500
Received: from mail.kroah.org ([65.200.24.183]:26848 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261672AbUB0BAd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 20:00:33 -0500
Date: Thu, 26 Feb 2004 16:53:49 -0800
From: Greg KH <greg@kroah.com>
To: glauber@mpcnet.com.br
Cc: linux-kernel@vger.kernel.org
Subject: Re: help in sysfs
Message-ID: <20040227005349.GD15075@kroah.com>
References: <20040226043302.GB2892@zion.matrix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040226043302.GB2892@zion.matrix>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 26, 2004 at 01:33:02AM -0300, glauber@mpcnet.com.br wrote:
> 
> I did not yet fully understand how sysfs works, 
> and so, any docs would be welcome

Lots of docs in the Documentation/ tree.  Did you look at them?

> My main problem is: 
> I'm trying to use udev, but some devices for
> drivers that are compiled in the kernel does
> not appear in.

What devices?  There are still a few that are not exposed in sysfs that
need to be converted.

> I searched for entries representing then in /sys, and found no one
> Specifically, no pts is found there in my .config, I have
> CONFIG_UNIX98_PTYS=y What can I do in order to solve this problem?

This is well documented.  You need to mount devpts at /dev/pts.  It's
not a sysfs or udev issue at all.


thanks,

greg k-h
