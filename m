Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269387AbRHTVJa>; Mon, 20 Aug 2001 17:09:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269392AbRHTVJU>; Mon, 20 Aug 2001 17:09:20 -0400
Received: from cp26357-a.gelen1.lb.nl.home.com ([213.51.0.86]:62998 "HELO
	lunchbox.oisec.net") by vger.kernel.org with SMTP
	id <S269387AbRHTVJH>; Mon, 20 Aug 2001 17:09:07 -0400
Date: Mon, 20 Aug 2001 23:09:10 +0200
From: Cliff Albert <cliff@oisec.net>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: aic7xxx errors with 2.4.8-ac7 on 440gx mobo
Message-ID: <20010820230909.A28422@oisec.net>
In-Reply-To: <20010820105520.A22087@oisec.net> <200108202027.f7KKRnY41946@aslan.scsiguy.com> <20010820224536.A28179@oisec.net> <20010820230410.A28323@oisec.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010820230410.A28323@oisec.net>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > >I'm getting similair errors on 2.4.8-ac7 on my P2B-S motherboard using
> > > >the NEW AIC7xxx driver, the old isn't experiencing these problems. Further
> > > >i've been getting these errors since 2.4.3.
> > > >
> > > >> booting with append="noapic", gives the same errors
> > > 
> > > Can you send me the full messages when you boot with "aic7xxx=verbose"?
> > > That should help indicate the source of your problems.  I also
> > > need to see the devices that are attached to the bus, so a full dmesg
> > > from a successful boot with the old driver would be helpful.
> > 
> > Well booting is successful on my board, but the same errors that almost
> > everyone is getting are the same i'm getting. I just turned on verbose.
> > 
> > Most debugging info i already send to the linux-kernel mailinglist, i'll
> > forward it on to you. The verbose info will be send also in about a few 
> > hours.
> 
> And here they are, the dmesg is my bootup dmesg with the devices drivers 
> and stuff, and the second dmesg is the actual errors (verbose turned on)

Some more research pointed out that the errors/lock of the scsi bus always 
appears about 20 seconds after kernel load when i cold boot the machine. 
With a warm boot the machine gives these errors/lock at random times.

-- 
Cliff Albert		ripe:  CA3348-RIPE 	IPng: IPv6 Deployment
cliff@ipng.nl		6bone: CA2-6BONE	http://www.ipng.nl/ 
