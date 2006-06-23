Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750774AbWFWO2u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbWFWO2u (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 10:28:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750785AbWFWO2u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 10:28:50 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:47634 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1750774AbWFWO2t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 10:28:49 -0400
Date: Fri, 23 Jun 2006 10:28:48 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Greg KH <greg@kroah.com>
cc: David Brownell <david-b@pacbell.net>, Mattia Dongili <malattia@linux.it>,
       Jiri Slaby <jirislaby@gmail.com>, Andrew Morton <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>, <linux-usb-devel@lists.sourceforge.net>,
       <linux-pm@osdl.org>, <pavel@suse.cz>
Subject: Re: [PATCH] get USB suspend to work again on 2.6.17-mm1
In-Reply-To: <20060623042614.GB23232@kroah.com>
Message-ID: <Pine.LNX.4.44L0.0606231027330.5966-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2006, Greg KH wrote:

> > In my upcoming patch set this test isn't needed at all, because suspending
> > a device automatically suspends all of its interfaces first.  I've already
> > submitted the first few revised patches in that set (not the part that
> > removes the test, though), but you've probably been too busy to look at
> > them yet.
> 
> I've glanced at them (and yes, been busy, they are still in my TO-APPLY
> queue, trying to sync up with Linus first), but I don't see anything in
> that set that changes the suspend logic.
> 
> Or am I just missing something obvious?  Which patch does that in your
> revised series?

It's not in any of the pieces you've gotten so far.  It's about 3 patches 
farther down the line.

Alan Stern

