Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264230AbRFHVDk>; Fri, 8 Jun 2001 17:03:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264294AbRFHVDa>; Fri, 8 Jun 2001 17:03:30 -0400
Received: from alpo.casc.com ([152.148.10.6]:44173 "EHLO alpo.casc.com")
	by vger.kernel.org with ESMTP id <S264230AbRFHVDU>;
	Fri, 8 Jun 2001 17:03:20 -0400
From: John Stoffel <stoffel@casc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15137.15472.264539.290588@gargle.gargle.HOWL>
Date: Fri, 8 Jun 2001 16:58:24 -0400
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: John Stoffel <stoffel@casc.com>, Mike Galbraith <mikeg@wen-online.de>,
        Tobias Ringstrom <tori@unhappy.mine.nu>,
        Jonathan Morton <chromi@cyberspace.org>, Shane Nay <shane@minirl.com>,
        "Dr S.M. Huen" <smh1008@cus.cam.ac.uk>,
        Sean Hunter <sean@dev.sportingbet.com>,
        Xavier Bestel <xavier.bestel@free.fr>,
        lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: VM Report was:Re: Break 2.4 VM in five easy steps
In-Reply-To: <Pine.LNX.4.21.0106081426010.2422-100000@freak.distro.conectiva>
In-Reply-To: <15137.3796.287765.4809@gargle.gargle.HOWL>
	<Pine.LNX.4.21.0106081426010.2422-100000@freak.distro.conectiva>
X-Mailer: VM 6.92 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Marcelo> Now the stock kernel gives us crappy interactivity compared
Marcelo> to my patch.  (Note: my patch still does not gives me the
Marcelo> interactivity I want under high VM loads, but I hope to get
Marcelo> there soon).

This raises the important question, how can we objectively measure
interactive response in the kernel and relate it to the user's
perceived interactive response?  If we could come up with some sort of
testing system that would show us this, it would help alot, since we
could just have people run tests in a more automatic and repeatable
manner.

And I think it would also help us automatically tune the Kernel, since
it would have a knowledge of it's own performance.  

There is the problem in terms of some people want pure interactive
performance, while others are looking for throughput over all else,
but those are both extremes of the spectrum.  Though I suspect
raw throughput is the less wanted (in terms of numbers of systems)
than keeping interactive response good during VM pressure.

I have zero knowledge of how we could do this, but giving the kernel
some counters, even if only for use during debugging runs, which would
give us some objective feedback on performance would be a big win.

Having people just send in reports of "I ran X,Y,Z and it was slow"
doesn't help us, since it's so hard to re-create their environment so
you can run tests against it.

Anyway, enjoy the weekend all.

John
   John Stoffel - Senior Unix Systems Administrator - Lucent Technologies
	 stoffel@lucent.com - http://www.lucent.com - 978-952-7548
