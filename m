Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264746AbRFSTeU>; Tue, 19 Jun 2001 15:34:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264745AbRFSTeJ>; Tue, 19 Jun 2001 15:34:09 -0400
Received: from 22dyn160.com21.casema.net ([213.17.92.160]:16397 "HELO
	home.ds9a.nl") by vger.kernel.org with SMTP id <S264744AbRFSTeG>;
	Tue, 19 Jun 2001 15:34:06 -0400
Date: Tue, 19 Jun 2001 21:32:18 +0200
From: bert hubert <ahu@ds9a.nl>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Alan Cox quote? (was: Re: accounting for threads)
Message-ID: <20010619213218.A3812@home.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20010619211038.A3704@home.ds9a.nl> <E15CR1f-0006Wh-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E15CR1f-0006Wh-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Tue, Jun 19, 2001 at 08:18:59PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2001 at 08:18:59PM +0100, Alan Cox wrote:

> > But that foregoes the point that the code is far more complex and harder to
> > make 'obviously correct', a concept that *does* translate well to userspace.
> 
> There I disagree. Threads introduce parallelism that the majority of user
> space programmers have trouble getting right (not that C is helpful here).

True. Balancing with what Larry said, threads require education. In good
Unix tradition you can shoot yourself in the foot in many ways. 

> A threaded program has a set of extremely complex hard to repeat timing based
> behaviour dependancies. An unthreaded app almost always does the same thing on
> the same input. From a verification and coverage point of view that is 
> incredibly important.

Reproducability is very important. But where threads may become inefficient
if used unwisely (I handily do many megabits of DNS traffic with our
threaded daemon by the way), statemachines have a way if becoming very
intractable - leading to whole new problems.

It's an 'enough rope' thing. Bad programmers will always write broken code -
the saving grace of state machines are that they are hard to write, which
means that *if* they are being used, it is often by a skilled programmer.

Regards,

bert

-- 
http://www.PowerDNS.com      Versatile DNS Services  
Trilab                       The Technology People   
'SYN! .. SYN|ACK! .. ACK!' - the mating call of the internet
