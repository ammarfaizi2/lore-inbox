Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262275AbTE2Osi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 10:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262283AbTE2Ord
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 10:47:33 -0400
Received: from ip-64-7-1-79.dsl.lax.megapath.net ([64.7.1.79]:14836 "EHLO
	ip-64-7-1-79.dsl.lax.megapath.net") by vger.kernel.org with ESMTP
	id S262275AbTE2OrI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 10:47:08 -0400
Date: Thu, 29 May 2003 08:00:23 -0700 (PDT)
From: <lk@trolloc.com>
X-X-Sender: <bpape@ip-64-7-1-79.dsl.lax.megapath.net>
To: "Wm. Josiah Erikson" <josiah@insanetechnology.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: siimage driver status
In-Reply-To: <Pine.LNX.4.44.0305291025550.11675-100000@bork.hampshire.edu>
Message-ID: <Pine.LNX.4.33.0305290757050.8303-100000@ip-64-7-1-79.dsl.lax.megapath.net>
X-keyboard: Happy Hacking Keyboard Lite
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	I have an Asus A7V8X Deluxe motherboard with a couple of WD Raptor 
> hard drives that I'm trying to get to work with linux 2.4.21-rc6. The 
> problem I'm having is that it's REALLY slow and crashy. The kernel reports 
> this on bootup:

> SiI3112 Serial ATA: IDE controller at PCI slot 01:0b.0

> If I try and enable DMA, the machine instantly hardlocks.
> 
> Is there anything I should try, or is the siimage driver just still very 
> early on in its development? I would be more than happy to beta- (or 
> alpha) test code, or give developers access to my box if testbed platforms 
> are needed. Whatever I can do to make it work :)

I have the same problem, and reported it back in 2.4.21-pre-something, but
nobody seemed interested.  I have the same problem with onboard chipsets
as with addon PCI cards from various manufacturers.  It's absolutely
impossible to enable DMA on the SiI controllers.  The "funny" thing is
that I purchased them on a recommendation from someone on lk who glowed
over their robustness.



