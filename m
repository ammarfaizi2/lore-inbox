Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264352AbRFHVke>; Fri, 8 Jun 2001 17:40:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264347AbRFHVkY>; Fri, 8 Jun 2001 17:40:24 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:38406 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S264364AbRFHVkH>; Fri, 8 Jun 2001 17:40:07 -0400
Date: Fri, 8 Jun 2001 17:04:33 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: John Stoffel <stoffel@casc.com>
Cc: Mike Galbraith <mikeg@wen-online.de>,
        Tobias Ringstrom <tori@unhappy.mine.nu>,
        Jonathan Morton <chromi@cyberspace.org>, Shane Nay <shane@minirl.com>,
        "Dr S.M. Huen" <smh1008@cus.cam.ac.uk>,
        Sean Hunter <sean@dev.sportingbet.com>,
        Xavier Bestel <xavier.bestel@free.fr>,
        lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: VM Report was:Re: Break 2.4 VM in five easy steps
In-Reply-To: <15137.15472.264539.290588@gargle.gargle.HOWL>
Message-ID: <Pine.LNX.4.21.0106081701300.2422-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 8 Jun 2001, John Stoffel wrote:

> 
> Marcelo> Now the stock kernel gives us crappy interactivity compared
> Marcelo> to my patch.  (Note: my patch still does not gives me the
> Marcelo> interactivity I want under high VM loads, but I hope to get
> Marcelo> there soon).
> 
> This raises the important question, how can we objectively measure
> interactive response in the kernel and relate it to the user's
> perceived interactive response?  If we could come up with some sort of
> testing system that would show us this, it would help alot, since we
> could just have people run tests in a more automatic and repeatable
> manner.
> 
> And I think it would also help us automatically tune the Kernel, since
> it would have a knowledge of it's own performance.  
> 
> There is the problem in terms of some people want pure interactive
> performance, while others are looking for throughput over all else,
> but those are both extremes of the spectrum.  Though I suspect
> raw throughput is the less wanted (in terms of numbers of systems)
> than keeping interactive response good during VM pressure.

And this raises a very very important point: raw throughtput wins
enterprise-like benchmarks, and the enterprise people are the ones who pay
most of hackers here. (including me and Rik)

We have to be careful about that. 

> I have zero knowledge of how we could do this, but giving the kernel
> some counters, even if only for use during debugging runs, which would
> give us some objective feedback on performance would be a big win.
> 
> Having people just send in reports of "I ran X,Y,Z and it was slow"
> doesn't help us, since it's so hard to re-create their environment so
> you can run tests against it.

Lets wait for some test system to be set up (eg the OSDL thing).

Once thats done, I'm sure we will find out some way of doing it. 

Well, good weekend for you too. 

