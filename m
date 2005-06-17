Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261891AbVFQBs7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261891AbVFQBs7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 21:48:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261894AbVFQBs6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 21:48:58 -0400
Received: from [140.247.233.35] ([140.247.233.35]:27379 "HELO
	netrider.rowland.org") by vger.kernel.org with SMTP id S261891AbVFQBsn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 21:48:43 -0400
Date: Thu, 16 Jun 2005 21:48:36 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Denis Vlasenko <vda@ilport.com.ua>
cc: Pete Zaitcev <zaitcev@redhat.com>, <linux-kernel@vger.kernel.org>,
       <linux-usb-devel@lists.sourceforge.net>, <gregkh@suse.de>,
       <dbrownell@users.sourceforge.net>, <mdharm-usb@one-eyed-alien.net>
Subject: Re: [linux-usb-devel] Re: USB flash "drive" is not working sometimes
In-Reply-To: <200506161135.42392.vda@ilport.com.ua>
Message-ID: <Pine.LNX.4.44L0.0506162145340.31849-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jun 2005, Denis Vlasenko wrote:

> On Thursday 16 June 2005 10:51, Pete Zaitcev wrote:

> > At this point the device is toast, the microcontroller is not running.
> 
> Do you mean: "this is a problem with the stick. Sometimes its
> electronics simply do not work at first plug in" ?

I agree with the comments posted previously.  The stick doesn't always 
work right at first plug-in.

> Can USB controller momentarily cut power to the stick, thus electrically
> simulating a replug? I'd likr to try something like this.

In general, no.  Most external hubs have that capability, but most host 
controllers do not.  In any case, Linux does not currently have an API for 
powering down USB ports.

Alan Stern

