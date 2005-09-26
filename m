Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964840AbVI0HS6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964840AbVI0HS6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 03:18:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964837AbVI0HS5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 03:18:57 -0400
Received: from mail.kroah.org ([69.55.234.183]:25038 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964840AbVI0HS5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 03:18:57 -0400
Date: Mon, 26 Sep 2005 13:27:53 -0700
From: Greg KH <greg@kroah.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: torvalds@osdl.org, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.14-rc2: USB storage-related #GP on x86-64
Message-ID: <20050926202753.GB18523@kroah.com>
References: <200509231502.02344.rjw@sisk.pl> <20050923130658.GA11908@kroah.com> <200509231843.51432.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509231843.51432.rjw@sisk.pl>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2005 at 06:43:50PM +0200, Rafael J. Wysocki wrote:
> On Friday, 23 of September 2005 15:06, Greg KH wrote:
> > On Fri, Sep 23, 2005 at 03:02:01PM +0200, Rafael J. Wysocki wrote:
> > > Hi,
> > > 
> > > I've just triggered a general protection fault on Asus L5D (x86-64) by
> > > unplugging a USB floppy.
> > 
> > Can you try the latest -git snapshots?  The scsi changes that should
> > have fixed this went in after -rc2.
> 
> Tried -git3, works.

Great, thanks for letting us know.

> Tested with a pendrive instead of the floppy, but I assume it doesn't
> matter?

It shouldn't, but it can't hurt to test :)

thanks,

greg k-h
