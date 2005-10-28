Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030261AbVJ1UCR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030261AbVJ1UCR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 16:02:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030262AbVJ1UCQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 16:02:16 -0400
Received: from mail.kroah.org ([69.55.234.183]:37584 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030261AbVJ1UCQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 16:02:16 -0400
Date: Fri, 28 Oct 2005 13:01:39 -0700
From: Greg KH <greg@kroah.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, gregkh@suse.de,
       linux-kernel@vger.kernel.org, david-b@pacbell.net
Subject: Re: [PATCH] pci device wakeup flags
Message-ID: <20051028200139.GA17478@kroah.com>
References: <11304810221338@kroah.com> <11304810223093@kroah.com> <20051028035116.112ba2ca.akpm@osdl.org> <20051028155044.GA11924@kroah.com> <20051028123434.09c5cb2f.akpm@osdl.org> <Pine.LNX.4.64.0510281247010.4664@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0510281247010.4664@g5.osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2005 at 12:47:50PM -0700, Linus Torvalds wrote:
> 
> 
> On Fri, 28 Oct 2005, Andrew Morton wrote:
> 
> > Greg KH <greg@kroah.com> wrote:
> > >
> > > I
> > >  thought that it was one of the usb patches in my tree that was causing
> > >  you problems.
> > 
> > That's a separate problem.  gregkh-usb-usb-pm-09.patch causes my x86 box to
> > hang partway though boot.  I drop that from -mm as well.
> 
> Just to verify: that one isn't in the current driver core tree, right? I 
> assume that's in Greg's USB tree..
> 
> Greg?

Yes, that is correct, that patch is not in this git tree that I asked
you to pull from.  All of the patches that break Andrew's boxes will not
be sent to you until I figure out what is happening and fix them.

thanks,

greg k-h
