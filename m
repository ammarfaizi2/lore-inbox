Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263959AbTCWWci>; Sun, 23 Mar 2003 17:32:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263963AbTCWWch>; Sun, 23 Mar 2003 17:32:37 -0500
Received: from 205-158-62-136.outblaze.com ([205.158.62.136]:25741 "HELO
	fs5-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S263959AbTCWWcg>; Sun, 23 Mar 2003 17:32:36 -0500
Subject: Re: Ptrace hole / Linux 2.2.25
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       James Bourne <jbourne@mtroyal.ab.ca>, linux-kernel@vger.kernel.org,
       Robert Love <rml@tech9.net>, Martin Mares <mj@ucw.cz>,
       Alan Cox <alan@redhat.com>, Stephan von Krawczynski <skraw@ithnet.com>,
       szepe@pinerecords.com, arjanv@redhat.com, Pavel Machek <pavel@ucw.cz>
In-Reply-To: <3E7E335C.2050509@pobox.com>
References: <20030323193457.GA14750@atrey.karlin.mff.cuni.cz>
	 <200303231938.h2NJcAq14927@devserv.devel.redhat.com>
	 <20030323194423.GC14750@atrey.karlin.mff.cuni.cz>
	 <1048448838.1486.12.camel@phantasy.awol.org>
	 <20030323195606.GA15904@atrey.karlin.mff.cuni.cz>
	 <1048450211.1486.19.camel@phantasy.awol.org>
	 <402760000.1048451441@[10.10.2.4]>
	 <20030323203628.GA16025@atrey.karlin.mff.cuni.cz>
	 <Pine.LNX.4.51.0303231410250.17155@skuld.mtroyal.ab.ca>
	 <920000.1048456387@[10.10.2.4]>  <3E7E335C.2050509@pobox.com>
Content-Type: text/plain
Organization: 
Message-Id: <1048459411.2721.14.camel@teapot>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-1) 
Date: 23 Mar 2003 23:43:32 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-03-23 at 23:21, Jeff Garzik wrote:
> akpm has suggested something like this in the past.  I respectfully 
> disagree.
> 
> The 2.4 kernel will not benefit from constant churn of backporting core 
> kernel changes like a new scheduler.  We need to let it settle, simply 
> get it stable, and concentrate on fixing key problems in 2.6.  Otherwise 
> you will never have a stable 2.4 tree, and it will look suspiciously 
> more and more like 2.6 as time goes by.  Constantly breaking working 
> configurations and changing core behaviors is _not_ the way to go for 2.4.
> 
> I see 2.4 O(1) scheduler and similar features as _pain_ brought on the 
> vendors by themselves (and their customers).
> 
> Surely it is better to concentrate developer time and mindshare on 
> making 2.6 sane?

I'm no hardcore kernel hacker, but I fully agree with you.
2.4 is pretty stable... Introducing new code (VM, IDE, etc) is just a
bit risky, more even when current 2.4 is 2.4.21 (I would say mature
enough).

________________________________________________________________________
        Felipe Alfaro Solana
   Linux Registered User #287198
http://counter.li.org

