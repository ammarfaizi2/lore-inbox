Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281062AbRKDR4u>; Sun, 4 Nov 2001 12:56:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280970AbRKDR4b>; Sun, 4 Nov 2001 12:56:31 -0500
Received: from lsmls01.we.mediaone.net ([24.130.1.20]:12696 "EHLO
	lsmls01.we.mediaone.net") by vger.kernel.org with ESMTP
	id <S281057AbRKDR4U>; Sun, 4 Nov 2001 12:56:20 -0500
Message-ID: <3BE581CF.F1AABA25@kegel.com>
Date: Sun, 04 Nov 2001 09:58:39 -0800
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Galbraith <mikeg@wen-online.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        stp@osdlab.org
Subject: Re: Regression testing of 2.4.x before release?
In-Reply-To: <Pine.LNX.4.33.0111040832060.364-100000@mikeg.weiden.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith wrote:
> 
> On Sat, 3 Nov 2001, Dan Kegel wrote:
> 
> > I get the impression that Alan stress-tests his kernels
> > more than Linus does before releasing them.
> 
> That's _our_ collective job.  We're supposed to beat the snot out
> of the -pre kernels and report.  One guy can't cover effectively,
> even if his name is Linus "stress-testing is boring" Torvalds ;-)

I'm not saying Linus should do the testing.  

It's good that Linus is asking others to test with cerberus, as he
did in http://marc.theaimsgroup.com/?l=linux-kernel&m=100451768023436&w=2

It would be even better if Linus came out and stated that he would
refuse to call a kernel final if there is an outstanding report of 
it failing an agreed-upon set of stress tests.

And it would be *even better* if http://osdl.org/stp/ were used
to do stress testing in a nice, automated way on 1, 4, 8, and 16-cpu 
machines on release candidates.

Almost none of this requires any work by Linus.  All Linus has to
do is say "The 2.4.x kernels will pass stress tests before release",
and recruit someone to run his kernels through OSDL's STP in a
timely manner.

(I'd be happy to help if it weren't for my darn tendinitis, which
makes it hard even to stir up trouble on mailing lists these days.)
- Dan
