Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267050AbTBYFDY>; Tue, 25 Feb 2003 00:03:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267368AbTBYFDY>; Tue, 25 Feb 2003 00:03:24 -0500
Received: from virtisp1.zianet.com ([216.234.192.105]:23824 "HELO
	mesatop.zianet.com") by vger.kernel.org with SMTP
	id <S267050AbTBYFDX>; Tue, 25 Feb 2003 00:03:23 -0500
Subject: Re: Minutes from Feb 21 LSE Call
From: Steven Cole <elenstev@mesatop.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Hans Reiser <reiser@namesys.com>, LKML <linux-kernel@vger.kernel.org>,
       Larry McVoy <lm@bitmover.com>
In-Reply-To: <10580000.1046144972@[10.10.2.4]>
References: <Pine.LNX.4.44.0302221648010.2686-100000@coffee.psychology.mcmast er.ca>
	<3E5AD2BA.1010608@namesys.com>  <10580000.1046144972@[10.10.2.4]>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 24 Feb 2003 22:12:50 -0700
Message-Id: <1046149973.2544.186.camel@spc1.mesatop.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-02-24 at 20:49, Martin J. Bligh wrote:
> > I expect to have 16-32 CPUs in my $3000 desktop in 5 years .  If you all
> > start planning for that now, you might get it debugged before it happens
> > to me.;-)
> 
> Thank you ... some sanity amongst the crowd
> 
> > I don't expect to connect the 16-32 CPUs with ethernet.... but it won't
> > surprise me if they have non-uniform memory.
> 
> Indeed. Just look at AMD hammer for NUMA effects, and SMT and multiple
> chip on die technologies for the way things are going.
> 
> M.

Hans may have 32 CPUs in his $3000 box, and I expect to have 8 CPUs in
my $500 Walmart special 5 or 6 years hence.  And multiple chip on die
along with HT is what will make it possible.

What concerns me is that this will make it possible to put insane
numbers of CPUs in those $250,000 and higher boxes.  If Martin et al can
scale Linux to 64 CPUs, can they make it scale several binary orders of
magnitude higher? Why do this?  NUMA memory is much faster than even
very fast network connections any day.   

Is there a market for such a thing?  I won't pretend to know that
answer.  But the capability to do it will be there, and in 5 years the
3.2 kernel probably won't be quite stable yet, so decisions made in the
next year for 2.9/3.0 may have to last until then.

Please listen to Larry.  When he says you can't scale endlessly, I have
a feeling he knows what he's talking about.  The Nirvana machine has 48
SGI boxes with 128 CPUs in each.  I don't hear about many 128 CPU
machines nowadays.  Perhaps Irix just wasn't quite up to the job.  But
new technologies will make this kind of machine affordable (by the
government and financial institutions) in the not too distant future.  

Just my two cents.  Enough ranting for today.

Steven

