Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269265AbUJKViT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269265AbUJKViT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 17:38:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269282AbUJKViT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 17:38:19 -0400
Received: from redfish.gatech.edu ([130.207.165.230]:37764 "EHLO
	cyberbuzz.gatech.edu") by vger.kernel.org with ESMTP
	id S269277AbUJKVhr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 17:37:47 -0400
Date: Mon, 11 Oct 2004 17:37:46 -0400 (EDT)
From: Chris Ricker <kaboom@gatech.edu>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andre Tomt <andre@tomt.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.9-rc4 - pls test (and no more patches)
In-Reply-To: <1097507381.2029.40.camel@mulgrave>
Message-ID: <Pine.GSO.4.58.0410111737110.24598@redfish.gatech.edu>
References: <Pine.LNX.4.58.0410102016180.3897@ppc970.osdl.org>
 <416A53D3.9020002@tomt.net>  <Pine.LNX.4.58.0410110758500.3897@ppc970.osdl.org>
 <1097507381.2029.40.camel@mulgrave>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Oct 2004, James Bottomley wrote:

> On Mon, 2004-10-11 at 10:02, Linus Torvalds wrote:
> > 
> > 
> > On Mon, 11 Oct 2004, Andre Tomt wrote:
> > > 
> > > The data corruption bug in the new megaraid driver version seems still 
> > > not to be fixed. LSI posted a fix some weeks ago, not sure how that went..
> > > 
> > > "[PATCH]: megaraid 2.20.4: Fixes a data corruption bug"
> > 
> > I think that one is already in the SCSI BK tree, just not pushed to me. 
> > Perhaps because the tree contains other less important patches that James 
> > doesn't think are worthy yet.. James? Should I just take the small 
> > megaraid patch directly (and leave the compat ioctl cleanups etc to you)?
> 
> I have no objections.  However, I was planning on pushing it through the
> SCSI tree because it's in the new megaraid driver which is experimental
> at the moment (the old megaraid driver is still in and still
> selectable).  It's been in -mm for a few days now with no ill effects, I
> think, but I'm not sure how many megaraid owners have actually tested
> it.

No problems here with the 2.20.4....

later,
chris
