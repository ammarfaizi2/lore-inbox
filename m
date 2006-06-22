Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161461AbWFVXxE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161461AbWFVXxE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 19:53:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161464AbWFVXxE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 19:53:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:61156 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1161461AbWFVXxD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 19:53:03 -0400
Date: Thu, 22 Jun 2006 16:52:59 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [GIT PATCH] USB patches for 2.6.17
Message-ID: <20060622235259.GA30639@suse.de>
References: <20060621220656.GA10652@kroah.com> <Pine.LNX.4.64.0606221546120.6483@g5.osdl.org> <20060622234040.GB30143@suse.de> <Pine.LNX.4.64.0606221646200.6483@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606221646200.6483@g5.osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2006 at 04:48:43PM -0700, Linus Torvalds wrote:
> 
> 
> On Thu, 22 Jun 2006, Greg KH wrote:
> >
> > I saw this once when debugging the usb code, but could never reproduce
> > it, so I attributed it to an incomplete build at the time, as a reboot
> > fixed it.
> 
> I'm pretty sure the build was good, but it may well be timing-related.
> 
> > Is this easy to trigger for you?
> 
> No. I've never seen it before on this machine (and it's that Mac Mini that 
> I've been rebooting several times a day for the last week), so if it's an 
> old bug, it's definitely not repeatable. I was thinking it would be 
> something new..

I would think it's something new too, as I did change that very line
that oopsed.  That's why I found it odd that I couldn't reproduce it
anymore.

> I'll let you know if I can repro it.

Thanks, that would help out a lot.

greg k-h
