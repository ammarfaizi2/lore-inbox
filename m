Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964780AbWACU3y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964780AbWACU3y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 15:29:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964781AbWACU3y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 15:29:54 -0500
Received: from mail.kroah.org ([69.55.234.183]:46212 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964780AbWACU3x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 15:29:53 -0500
Date: Tue, 3 Jan 2006 12:28:53 -0800
From: Greg KH <greg@kroah.com>
To: Dave Jones <davej@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: userspace breakage
Message-ID: <20060103202853.GF12617@kroah.com>
References: <20051228212313.GA4388@elte.hu> <20051228214845.GA7859@elte.hu> <20051228201150.b6cfca14.akpm@osdl.org> <20051229073259.GA20177@elte.hu> <Pine.LNX.4.64.0512290923420.14098@g5.osdl.org> <20051229202852.GE12056@redhat.com> <Pine.LNX.4.64.0512291240490.3298@g5.osdl.org> <20051229224103.GF12056@redhat.com> <Pine.LNX.4.64.0512291451440.3298@g5.osdl.org> <20051229230307.GB24452@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051229230307.GB24452@redhat.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 29, 2005 at 06:03:07PM -0500, Dave Jones wrote:
> On Thu, Dec 29, 2005 at 02:56:16PM -0800, Linus Torvalds wrote:
> 
>  > That really isn't acceptable. Breaking user space - even things that are 
>  > "close" to the kernel like udev scripts and alsa-lib, really is NOT a good 
>  > idea.
>  > 
>  > If you cannot upgrade a kernel without ugrading some user package, that 
>  > should be considered a real bug and a regression.
> 
> I'm glad you agree.  I've decided to try something different once 2.6.16
> is out.  Every day, I'm going to push the -git snapshot of the day into
> a testing branch for Fedora users. (Normally, only rawhide[1] users 
> get to test kernel-de-jour, and this always has the latest userspace, so
> we don't notice problems until a kernel point release and the stable
> distro gets an update).

Ah, nice idea, I'll try to set up the same thing for Gentoo's kernels.
Hopefully the expanded coverage will help...

thanks,

greg k-h
