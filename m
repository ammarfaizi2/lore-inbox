Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288972AbSAPP7i>; Wed, 16 Jan 2002 10:59:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289983AbSAPP72>; Wed, 16 Jan 2002 10:59:28 -0500
Received: from cj326439-a.alex1.va.home.com ([65.1.135.172]:38134 "EHLO
	xabean.xabean.net") by vger.kernel.org with ESMTP
	id <S288972AbSAPP7N>; Wed, 16 Jan 2002 10:59:13 -0500
Message-Id: <200201161601.g0GG1BB27489@xabean.xabean.net>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: linux-kernel@vger.kernel.org
From: Richard Harman <rharman@xabean.net>
Subject: Re: aic7xxx driver v6.2.4 "queue abort message" questions 
In-Reply-To: Your message of "Wed, 16 Jan 2002 08:47:41 MST."
             <200201161547.g0GFlfx06709@aslan.scsiguy.com> 
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <27485.1011196870.1@xabean.xabean.net>
Date: Wed, 16 Jan 2002 11:01:11 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's a dual P3 600/100 with 512mb of ram, tyan thunder 100 gx (s1836dulan model) with an onboard aic-7895 dual channel UW SCSI.  I'm booting off channel B (the 68pin only channel) Id 1, which is my seagate 36g SCA drive in a 5 bay sca enclosure.  Id 0 is a ultraplex 40x. Channel A has a 50pin 8x2x20 plexwriter.  The motherboard has a PIIX4 (GX) chipset.  (http://www.tyan.com/products/html/a_thunder100gx.html)

I've hand copied down what I could of the v6.2.4 driver's debug messages, but wasn't able to catch all of it.  (I hope to switch to serial console as soon as I find a null modem cable and log it that way.)  Shall I send the screenfull to the list or you directly?

Thanks,
Richard G Harman Jr <rharman+nospam@xabean.net>

  Quoted from "Justin T. Gibbs":
> >I've got a box that will nolonger boot off it's scsi disk anymore, (but dual b
> >ooting to windows works just fine...) did anyone ever get to the bottom of wha
> >t caused the "attempting to queue an abort message" bug was?
> 
> Those messages don't usually indicate bugs.  Without knowing more about
> your system, the devices attached to it, if you happen to have one of
> those broken VIA chipsets, etc. its hard to diagnose your problem.
> 
> --
> Justin
> 
