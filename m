Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965189AbVH0OpE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965189AbVH0OpE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Aug 2005 10:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965187AbVH0OpE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Aug 2005 10:45:04 -0400
Received: from web33304.mail.mud.yahoo.com ([68.142.206.119]:62585 "HELO
	web33304.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S965189AbVH0OpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Aug 2005 10:45:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=ZXm0410257GtFTArOrBvCQzZNyozv1c1kVtkBug5k1YQPqPn4uQHUkD+9LesuomasOQhhNIft2O0jJyzXqiiw1Nl/xaDTd3IJAEkjM/d5AEAh5KiOhmIY2JCMK/t5ULsUKbUCBZF0qTiGculFKGfKWdxrQCIjFVkqW9CFAMLAqA=  ;
Message-ID: <20050827144459.66078.qmail@web33304.mail.mud.yahoo.com>
Date: Sat, 27 Aug 2005 07:44:59 -0700 (PDT)
From: Danial Thom <danial_thom@yahoo.com>
Reply-To: danial_thom@yahoo.com
Subject: Re: 2.6.12 Performance problems
To: Ben Greear <greearb@candelatech.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <430FA544.8000603@candelatech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- Ben Greear <greearb@candelatech.com> wrote:

> Danial Thom wrote:
> 
> > I didn't refuse. I just chose to take help
> from
> > Ben, because Ben took the time to reproduce
> the
> > problem and to provide useful settings that
> made
> > sense to me. There's nothing wrong with my
> > machine. 
> 
> Well, I didn't see the slowdown on my system
> when I tried 2.6
> v/s 2.4.  You reported a 3x slowdown.  In your
> original mail,
> you didn't mention trying to do compiles at the
> same time
> as your network test.  I *did* see a pathetic
> slowdown (from 250kpps
> bridging to about 6kpps getting through the
> bridge) when I coppied
> a 512MB CDROM to the HD, but let's get the pure
> network slowdown
> on your system figured out before we start
> looking at the impact
> of disk IO.
> 
> So, if you see a 3x slowdown on an unloaded
> machine when going
> from 2.4 to 2.6, then there is something unique
> about your system
> and we should figure out what it is.
> 
> Also, my numbers (about 250kpps with moderate
> amount of drops)
> was a lot better than the 100kpps you reported
> for 2.6.  My
> hardware is different (P-IV, HT, 3.0Ghz 1MB
> Cache, 1GB RAM,
> dual Intel pro/1000 NIC in PCI-X 66/133 slot),
> but I would not
> expect that to be 2x faster than your Opteron
> (or whatever you had).
> 
> You could mention what you are using to
> generate traffic.  (I was
> using pktgen to generate a stream of 60 byte
> pkts.)
> 
> I think you should give us some better
> information on exactly
> what you are doing on 2.4 v/s 2.6.  And for
> heaven's sake,
> don't hesitate to send kernel configs and
> hardware listings
> to folks that ask.  Ruling out problems is as
> useful as finding
> problems in this sort of thing.

Ok, good point, but I think  the original issue
has evolved into "why does linux drop packets
even when its not close to capacity". Its not
really a "slow down" now that we've been
discussing it, its the point at which packet loss
begins to occur. And since it appears that packet
loss can occur at usage levels not even close to
capacity, I can't really determine the capacity.
Since CPU usage also doesn't seem to register
correctly, I can't get a handle on the load for
various activities. So it may not have anything
to do with "slowness". I feel like I'm trying to
weigh a big blob of Jell-o that keeps falling off
the scale. 

The bottom line is that if I can't get it to stop
dropping packets, the performance is moot,
because its simply not suitable for my needs.

DT


		
____________________________________________________
Start your day with Yahoo! - make it your home page 
http://www.yahoo.com/r/hs 
 
