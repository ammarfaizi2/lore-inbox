Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262247AbVBVIxc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262247AbVBVIxc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 03:53:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262249AbVBVIxc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 03:53:32 -0500
Received: from orb.pobox.com ([207.8.226.5]:45262 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S262247AbVBVIxa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 03:53:30 -0500
Date: Tue, 22 Feb 2005 00:53:26 -0800
From: "Barry K. Nathan" <barryn@pobox.com>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: OT: Why is usb data many times the cpu hog that firewire is?
Message-ID: <20050222085326.GD7524@ip68-4-98-123.oc.oc.cox.net>
References: <200502211216.35194.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502211216.35194.gene.heskett@verizon.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2005 at 12:16:35PM -0500, Gene Heskett wrote:
> Greetings;
> 
> Motherboard is a biostar with nforce2 chipset, 2800xp cpu, gig of ram.
> 
> I've recently made the observation that while I can view 30fps video 
> from my firewire equipt movie camera with a minimal cpu hit of 2-3%, 
> but viewing the video from a webcam on a usb 1.1 circuit takes 30-40% 
> of the cpu, at half the frame rate.
> 
> Do I have something fubar in the usb?  Or is this just the nature of 
> the beast?

Is your USB 1.1 controller UHCI or OHCI? If it's UHCI, perhaps you could
try an OHCI controller (e.g. some USB PCI cards) and see if that makes
any difference. (I remember reading something about OHCI being more
efficient than UHCI in some cases, although I don't remember the details
now.)

-Barry K. Nathan <barryn@pobox.com>

