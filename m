Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132811AbRAETBB>; Fri, 5 Jan 2001 14:01:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132812AbRAETAv>; Fri, 5 Jan 2001 14:00:51 -0500
Received: from smtpgw.bnl.gov ([130.199.3.16]:27658 "EHLO smtpgw.sec.bnl.local")
	by vger.kernel.org with ESMTP id <S132811AbRAETAs>;
	Fri, 5 Jan 2001 14:00:48 -0500
Date: Fri, 5 Jan 2001 14:00:21 -0500
From: Tim Sailer <sailer@bnl.gov>
To: linux-kernel@vger.kernel.org
Subject: Re: Network Performance?
Message-ID: <20010105140021.A2016@bnl.gov>
In-Reply-To: <20010104013340.A20552@bnl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20010104013340.A20552@bnl.gov>; from sailer@bnl.gov on Thu, Jan 04, 2001 at 01:33:40AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 04, 2001 at 01:33:40AM -0500, Tim Sailer wrote:
> This may not be the right forum to ask this. If not, please let me know
> where to ask.
> 
> I have a Debian box with 2 NICs. Both 100/full duplex. This machine is 
> running as a ftp proxy (T.Rex suite). As part of the traffic going through the
> box, some streams have 1000k window size for a certain reason. How do
> I tune the NICs to handle the streams better? There are ways of doing this
> on other OSs. Right now, the box only does about 1.8Mb when it should be doing
> 80+Mb.
> 
> Thanks,
> Tim
> 
> PS: This is really something to do with the window size and WAN latency.
> The ultimate source and destination points are either Solaris or AIX
> boxes. The files being sent are > 1GB in size.
> The box does well when traffic goes in one NIC and out the other, as long
> as the end point is local When it hits the WAN, it all dies. Traffic not
> going through the box just flies right along, as long as both the end points
> have the large tcp window size. Putting the Linux box in the middle is a 
> severe choke point. :(

I have followed the suggestions in http://www.psc.edu/networking/perf_tune.html
but I still can not get any kind of real throughput. 250kB is all I can
get from the Linux box. Setting [r|w]mem_[default|max] larger than 16k
makes no difference, smaller slows things down even more. Has anyone else
ran across this and fixed it? I can't be the only one with a Linux box
on a fat pipe looking for maximum throughput...

Tim

-- 
Tim Sailer <sailer@bnl.gov> Cyber Security Operations
Brookhaven National Laboratory  (631) 344-3001
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
