Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263979AbUDFTaj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 15:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263980AbUDFTaj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 15:30:39 -0400
Received: from karnickel.franken.de ([193.141.110.11]:55308 "EHLO
	karnickel.franken.de") by vger.kernel.org with ESMTP
	id S263979AbUDFTai (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 15:30:38 -0400
Date: Tue, 6 Apr 2004 21:27:08 +0200
To: Alex Riesen <fork0@users.sourceforge.net>,
       Alan Stern <stern@rowland.harvard.edu>,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] Re: Oops with bluetooth dongle
Message-ID: <20040406192708.GA5327@debian.franken.de>
References: <Pine.LNX.4.44L0.0404061036480.1042-100000@ida.rowland.org> <Pine.LNX.4.44L0.0404061247490.1042-100000@ida.rowland.org> <20040406184736.GA1413@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040406184736.GA1413@steel.home>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: erik@debian.franken.de (Erik Tews)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2004 at 08:47:36PM +0200, Alex Riesen wrote:
> Alan Stern, Tue, Apr 06, 2004 18:49:51 +0200:
> > I've seen a couple of different problems coming up with this bluetooth 
> > stuff.  One of them may be fixed by a recent patch, as David Brownell 
> > mentioned.  Below is the relevant part excerpted from that patch; maybe it 
> > will help some of you.
> > 
> > --- 1.47/drivers/usb/core/message.c	Tue Mar 30 01:04:29 2004
> > +++ edited/drivers/usb/core/message.c	Tue Mar 30 17:34:54 2004
> 
> no change for me. Still oopses.

I have been running 2.6.5 with the bk-usb patch broken out of mm1. I
still got the problem.

If I rmmod uhci-hcd, the kernel oopses too.

Still any ideas?
