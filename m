Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130777AbRCTUfO>; Tue, 20 Mar 2001 15:35:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130902AbRCTUfF>; Tue, 20 Mar 2001 15:35:05 -0500
Received: from zeus.kernel.org ([209.10.41.242]:62661 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S130777AbRCTUew> convert rfc822-to-8bit;
	Tue, 20 Mar 2001 15:34:52 -0500
Date: Tue, 20 Mar 2001 14:29:47 -0600 (CST)
From: Josh Grebe <squash@primary.net>
To: Jakob Østergaard <jakob@unthought.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Question about memory usage in 2.4 vs 2.2
In-Reply-To: <20010320183238.B1508@unthought.net>
Message-ID: <Pine.LNX.4.21.0103201156070.2405-100000@scarface.primary.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As far as performance goes, I can only say that my max load is slightly
lower on the 2.4 box then on the 2.2 boxes. Our average load for yesterday
on 2.4 was .23, with a max of 1.11. In comparison, my averages for the
other machines are .27, .27, .23, and .23. The maxes are 1.85, 1.33, 2.06,
1.47.

As far as speed goes, I am not able to measure any real difference (only
testing pop3) between 2.2 and 2.4. I would blame this on the NAS device, a
NetApp Filer F760 being only able to push about 110mbit sustained on the
gig-e network.

Thanks,

Josh
---
Josh Grebe
Senior Unix Systems Administrator
Primary Network, an MPower Company
http://www.primary.net

On Tue, 20 Mar 2001, [iso-8859-1] Jakob Østergaard wrote:

> On Tue, Mar 20, 2001 at 11:01:52AM -0600, Josh Grebe wrote:
> > Greetings,
> ...
> > Doing the math, the 2.4 machine is using 44% of available memory, while
> > the 2.2 is using only about 14%.
> 
> How is the performance difference ?
> 
> ...
> > These machines are dual P2-400's, with 512M ECC ram, adaptec 2940, and
> > dual intel etherexpress pro 100 cards.
> > 
> > I also tried 2.4.2-ac20 with similar results.
> > 
> > Am I missing something here? I'd really like to move the farm back up to
> > 2.4 series.
> 
> Free memory is wasted memory.   It seemed like 2.4 wasted a lot less memory
> than 2.2 on your workload.
> 
> Could you do some performance measurements (eg. average latency on IMAP
> connection or something like that)   ?    It would be great to know wheter
> 2.4 is better or worse than 2.2  (it's most likely better, since it probably
> uses the memory better, but it would be nice to know)
> 
> -- 
> ................................................................
> :   jakob@unthought.net   : And I see the elder races,         :
> :.........................: putrid forms of man                :
> :   Jakob Østergaard      : See him rise and claim the earth,  :
> :        OZ9ABN           : his downfall is at hand.           :
> :.........................:............{Konkhra}...............:
> 



