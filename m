Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263123AbVCJVgo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263123AbVCJVgo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 16:36:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263175AbVCJVgn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 16:36:43 -0500
Received: from mail.kroah.org ([69.55.234.183]:6568 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263226AbVCJVgL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 16:36:11 -0500
Date: Thu, 10 Mar 2005 13:35:54 -0800
From: Greg KH <greg@kroah.com>
To: Chris Wright <chrisw@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Netdev <netdev@oss.sgi.com>,
       Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       stable@kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCHES] 2.6.x net driver oops fixes
Message-ID: <20050310213554.GA21061@kroah.com>
References: <422F59E8.2090707@pobox.com> <20050310202548.GV5389@shell0.pdx.osdl.net> <20050310203112.GA20337@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050310203112.GA20337@kroah.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2005 at 12:31:12PM -0800, Greg KH wrote:
> On Thu, Mar 10, 2005 at 12:25:48PM -0800, Chris Wright wrote:
> > * Jeff Garzik (jgarzik@pobox.com) wrote:
> > 
> > > This will update the following files:
> > > 
> > >  drivers/net/sis900.c    |   41 +++++++++++++++++++++--------------------
> > >  drivers/net/via-rhine.c |    3 +++
> > 
> > The via-rhine fix is already in the stable queue.  But the sis900 oops
> > fix does not apply to the stable tree.  It relies on a few intermediate
> > patches.  Appears to still be an issue for the older version which is in
> > 2.6.11.  Here's a stab at a backport.  Would you like to review/validate
> > or drop this one?
> 
> The pci_name() portion of this patch is not necessary for the -stable
> tree.  Care to remove it?

Oh nevermind, I was completly wrong, it's fine.

greg k-h
