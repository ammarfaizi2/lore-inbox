Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265224AbUEMXD6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265224AbUEMXD6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 19:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265243AbUEMXCX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 19:02:23 -0400
Received: from mail.kroah.org ([65.200.24.183]:43934 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265244AbUEMXB6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 19:01:58 -0400
Date: Thu, 13 May 2004 15:40:44 -0700
From: Greg KH <greg@kroah.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Duncan Sands <baldrick@free.fr>,
       Nuno Ferreira <nuno.ferreira@graycell.biz>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: PATCH: (as279) Don't delete interfaces until all are unbound
Message-ID: <20040513224044.GC20521@kroah.com>
References: <200405131845.29812.baldrick@free.fr> <Pine.LNX.4.44L0.0405131352500.651-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0405131352500.651-100000@ida.rowland.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2004 at 01:56:32PM -0400, Alan Stern wrote:
> On Thu, 13 May 2004, Duncan Sands wrote:
> 
> > No, but the pointer for another (previous) interface may just have been
> > set to NULL, causing an Oops when usb_ifnum_to_if loops over all
> > interfaces.
> 
> Of course!  I trust you won't mind me changing your suggested fix
> slightly.  This should do an equally good job of repairing things, and it
> will prevent other possible invalid references as well.
> 
> Greg, please apply.

Applied, thanks.

greg k-h
