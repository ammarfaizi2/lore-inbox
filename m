Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269090AbUJKQsU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269090AbUJKQsU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 12:48:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269106AbUJKQr5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 12:47:57 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:54192 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S269090AbUJKPJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 11:09:52 -0400
Subject: Re: Linux 2.6.9-rc4 - pls test (and no more patches)
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andre Tomt <andre@tomt.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0410110758500.3897@ppc970.osdl.org>
References: <Pine.LNX.4.58.0410102016180.3897@ppc970.osdl.org>
	<416A53D3.9020002@tomt.net> 
	<Pine.LNX.4.58.0410110758500.3897@ppc970.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 11 Oct 2004 10:09:35 -0500
Message-Id: <1097507381.2029.40.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-10-11 at 10:02, Linus Torvalds wrote:
> 
> 
> On Mon, 11 Oct 2004, Andre Tomt wrote:
> > 
> > The data corruption bug in the new megaraid driver version seems still 
> > not to be fixed. LSI posted a fix some weeks ago, not sure how that went..
> > 
> > "[PATCH]: megaraid 2.20.4: Fixes a data corruption bug"
> 
> I think that one is already in the SCSI BK tree, just not pushed to me. 
> Perhaps because the tree contains other less important patches that James 
> doesn't think are worthy yet.. James? Should I just take the small 
> megaraid patch directly (and leave the compat ioctl cleanups etc to you)?

I have no objections.  However, I was planning on pushing it through the
SCSI tree because it's in the new megaraid driver which is experimental
at the moment (the old megaraid driver is still in and still
selectable).  It's been in -mm for a few days now with no ill effects, I
think, but I'm not sure how many megaraid owners have actually tested
it.

James


