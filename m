Return-Path: <linux-kernel-owner+w=401wt.eu-S932122AbXAIOxo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122AbXAIOxo (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 09:53:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932124AbXAIOxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 09:53:44 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:42927 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932122AbXAIOxo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 09:53:44 -0500
Date: Tue, 9 Jan 2007 09:53:43 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Greg KH <greg@kroah.com>
cc: Andrew Morton <akpm@osdl.org>, Kay Sievers <kay.sievers@novell.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Driver core: fix refcounting bug
In-Reply-To: <20070109071321.GA5679@kroah.com>
Message-ID: <Pine.LNX.4.44L0.0701090952240.3102-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jan 2007, Greg KH wrote:

> On Mon, Jan 08, 2007 at 08:23:59PM -0800, Andrew Morton wrote:
> > On Mon, 8 Jan 2007 11:06:44 -0500 (EST)
> > Alan Stern <stern@rowland.harvard.edu> wrote:
> > 
> > > This patch (as832) fixes a newly-introduced bug in the driver core.
> > > When a kobject is assigned to a kset, it must acquire a reference to
> > > the kset.

> > OK, I give up.  What kernel is this against?
> 
> I think this is against my private tree, with the "driver-class" patches
> that are not in -mm (for good reason at this point in time.)  Right
> Alan?

That's exactly right.  And it's also why I didn't CC: Andrew on the 
original patch submission.

Alan Stern

