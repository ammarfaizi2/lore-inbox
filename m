Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265187AbSL0Wfm>; Fri, 27 Dec 2002 17:35:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265198AbSL0Wfm>; Fri, 27 Dec 2002 17:35:42 -0500
Received: from m3.azalea.se ([217.75.96.207]:5575 "HELO m3.azalea.se")
	by vger.kernel.org with SMTP id <S265187AbSL0Wfl>;
	Fri, 27 Dec 2002 17:35:41 -0500
Subject: Re: Alot of DMA errors in 2.4.18, 2.4.20 and 2.5.52
From: Mikael Olenfalk <mikael@netgineers.se>
To: jw schultz <jw@pegasys.ws>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20021227071353.A4614@pegasys.ws>
References: <1040815160.533.6.camel@devcon-x>
	 <20021225115820.GB7348@louise.pinerecords.com>
	 <20021226123710.GA2442@iapetus.localdomain>
	 <1040994876.518.13.camel@devcon-x>  <20021227071353.A4614@pegasys.ws>
Content-Type: text/plain
Organization: Netgineers
Message-Id: <1041028693.1620.4.camel@devcon-x>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 27 Dec 2002 23:38:13 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jw schultz wrote:
> I'm a bit suprised noone else has mentioned this so i will.
> Your RAID description seems to indicate it is built of four
> drives on a two channel HBA.  In other words you have two
> pairs of drives each pair sharing a cable (master/slave).
> It is my understanding that that is at best a recepe for
> poor performance.  From what i have heard ata66 and above is
> problematic (out of spec) in that configuration.  I imagine
> such a configuration might also cause poor interactions
> between the drives.  

I've tried another setup with One Disk Per Channel(tm), I'm at 37.1% of
the parity sync now with amazing speeds of 40K/sec and 20314.20 minutes
left.

The new setup is:

> 
> Aside from the reputed problems with PDC and with the IBM
> "deathstar" drives you might first try adding another HBA
> and use better cables before you scrap the drives.

What reputed problems? I've heard of problems with IBM disks (like dying
after just one year of use and so on) But I've never heard of any PDC
problems (BTW I have never heard of any success stories either 8) )...
Can you recommend another controller, what's about the HPT, is that one
usable?


Thanks for your time, Mikael


-- 
Mikael Olenfalk <mikael@netgineers.se>
Netgineers

