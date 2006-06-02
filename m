Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932168AbWFBPLg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932168AbWFBPLg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 11:11:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932212AbWFBPLg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 11:11:36 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:20488 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S932168AbWFBPLf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 11:11:35 -0400
Date: Fri, 2 Jun 2006 11:11:33 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: David Liontooth <liontooth@cogweb.net>
cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>, <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] USB devices fail unnecessarily on unpowered
 hubs
In-Reply-To: <447F8057.4000109@cogweb.net>
Message-ID: <Pine.LNX.4.44L0.0606021109390.7076-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Jun 2006, David Liontooth wrote:

> What are the reasons not to do this? What happens if a USB stick is
> underpowered to one unit? Nothing? Slower transmission? Data loss? Flash
> memory destruction? If it's just speed, it's a price well worth paying.

I do wish people would read the earlier messages in this thread before 
posting.  Go back and look at this one:

http://marc.theaimsgroup.com/?l=linux-kernel&m=114918113822427&w=2

Trying to draw too much current from an unpowered hub can and does cause 
data loss.

Alan Stern

