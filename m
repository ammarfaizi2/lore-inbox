Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261238AbTH2OXM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 10:23:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261271AbTH2OXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 10:23:12 -0400
Received: from ip-64-7-1-79.dsl.lax.megapath.net ([64.7.1.79]:42232 "EHLO
	ip-64-7-1-79.dsl.lax.megapath.net") by vger.kernel.org with ESMTP
	id S261238AbTH2OXK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 10:23:10 -0400
Date: Fri, 29 Aug 2003 07:22:55 -0700 (PDT)
From: <lk@trolloc.com>
X-X-Sender: <bpape@ip-64-7-1-79.dsl.lax.megapath.net>
To: Nick Urbanik <nicku@vtc.edu.hk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Single P4, many IDE PCI cards == trouble??
In-Reply-To: <3F4F5C9A.5BAA1542@vtc.edu.hk>
Message-ID: <Pine.LNX.4.33.0308290716500.26957-100000@ip-64-7-1-79.dsl.lax.megapath.net>
X-keyboard: Happy Hacking Keyboard Lite
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is there _anyone_ who is using a number of ATA133 IDE disks (>=6), each on
> its own IDE channel, on a number of PCI IDE cards, and doing so
> successfully and reliably?  I begin to suspect not!  If so, please tell us
> what motherboard, IDE cards you are using.  I used to imagine that a
> terabyte of RAID storage on one P4 machine with ordinary cheap IDE cards
> with software RAID would be feasible.  I believe it is not (although I
> cannot afford to play musical motherboards).

We've tried it with five or six different motherboards, with Intel, Via,
and Serverworks onboard chipsets, and Promise, Highpoint, and Silicon
Image add-in cards, and had no luck.  After extensive testing and
patching, we finally gave up and bought 3ware 8500 cards.  The only
non-3ware IDE we've found to be stable is the Intel onboard chipset.  

> > > My machine locks solid at unpredictable intervals with no response
> > > from keyboard lights, no Alt-Sysrq-x response, etc, with a wide
> > > variety of 2.4.x kernels, including 2.4.22.

We generally got lost DMA messages, but still, we were unable to obtain 
any stability.

> I am giving up now, and have shelled out big dollars for a 3ware 7506-8,
> which I will install early next week once I've figured out how to back up
> and restore 203GB without shelling out even more money.


