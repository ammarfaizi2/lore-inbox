Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263040AbUF0PXN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263040AbUF0PXN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 11:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263134AbUF0PXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 11:23:13 -0400
Received: from netrider.rowland.org ([192.131.102.5]:33287 "HELO
	netrider.rowland.org") by vger.kernel.org with SMTP id S263040AbUF0PXK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 11:23:10 -0400
Date: Sun, 27 Jun 2004 11:23:10 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Greg KH <greg@kroah.com>
cc: Pete Zaitcev <zaitcev@redhat.com>, <arjanv@redhat.com>,
       <jgarzik@redhat.com>, <tburke@redhat.com>,
       <linux-kernel@vger.kernel.org>, <mdharm-usb@one-eyed-alien.net>,
       <david-b@pacbell.net>, <oliver@neukum.org>
Subject: Re: drivers/block/ub.c
In-Reply-To: <20040627050201.GA24788@kroah.com>
Message-ID: <Pine.LNX.4.44L0.0406271120520.10357-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Jun 2004, Greg KH wrote:

> On Sun, Jun 27, 2004 at 12:05:22AM -0400, Alan Stern wrote:
> > It look like you are targeting ub for Linux 2.4.  Do you intend to use it 
> > with 2.6?  An important difference between the two kernel versions is that 
> > in 2.6 we do not try to make devices persistent across disconnections by 
> > recognizing some type of unique ID.
> 
> The patch was against 2.6.7.  Why do you think this is for 2.4?

So it is.  I was mistaken because it was late at night, and I read this 
entry in the to-do list:

+ * -- use serial numbers to hook onto same hosts (same minor) after
disconnect

That feature is present in usb-storage for 2.4 but not 2.6, so I assumed 
there would be no reason to add it to ub for 2.6 either.

Alan Stern

