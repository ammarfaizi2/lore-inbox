Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261957AbTLLUsv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 15:48:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261973AbTLLUsv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 15:48:51 -0500
Received: from ida.rowland.org ([192.131.102.52]:16644 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S261957AbTLLUsu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 15:48:50 -0500
Date: Fri, 12 Dec 2003 15:48:50 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: David Brownell <david-b@pacbell.net>
cc: Duncan Sands <baldrick@free.fr>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] Re: [OOPS,  usbcore, releaseintf] 2.6.0-test10-mm1
In-Reply-To: <3FDA1AF7.8010604@pacbell.net>
Message-ID: <Pine.LNX.4.44L0.0312121547430.677-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Dec 2003, David Brownell wrote:

> Alan Stern wrote:
> 
> >>That would also reduce the length of time the address0_sem
> >>is held,
> > 
> > 
> > It would?  How so?
> 
> It would be dropped after the address is assigned (the bus
> no longer has an "address zero") ... rather than waiting
> until after the device was configured and all its interfaces
> were probed.  I think that's the issue Oliver alluded to in
> his followup to your comment.

I thought it did that already.  Oh well...

Alan Stern

