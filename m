Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273213AbRKDTJx>; Sun, 4 Nov 2001 14:09:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273588AbRKDTJo>; Sun, 4 Nov 2001 14:09:44 -0500
Received: from Expansa.sns.it ([192.167.206.189]:5135 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S273261AbRKDTJc>;
	Sun, 4 Nov 2001 14:09:32 -0500
Date: Sun, 4 Nov 2001 20:09:31 +0100 (CET)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Dan Kegel <dank@kegel.com>
cc: Mike Galbraith <mikeg@wen-online.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <stp@osdlab.org>
Subject: Re: Regression testing of 2.4.x before release?
In-Reply-To: <3BE581CF.F1AABA25@kegel.com>
Message-ID: <Pine.LNX.4.33.0111041955290.30596-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Problem is:
there is a lot of HW out there, and we should ALL do stress tests, to have
a wide basis for HWs and test cases.
Basically it is very hard to agree
about a set of stress tests, because we all have different needs, and our
tests are based on our needs. That is a streght, because they tend to be
real life tests.

In my esperience, if some default set of tests comes out, then software
tend to be optimized for this set. And that is badly wrong.

Our disomogeneous tests are a good thing indeed.

For example, with servers with not so mutch memory (128/256 Mbyte RAM
256/512 MByte SWAP) I am interested for interactive uses, because usually
I have 20/50 users connected to them using Xwin (from X session on
localhost and many Xterms), netscape, KDE, a lot of mail software and TeX.

With bigger Iron (sparc64 with some Gbytes of RAM/SWAP) I am mutch more
interested in DB performances and web servers with zope and other
application servers.

My stress test have been developed during those years thinking on my
needs.
Thanx to this test, it was possible to see some VM bugs that was very
difficoult to be seen under other conditions. Then it was easy to work
with AA to fix them, and I have to say, he has been always available and
interested to solve every problem.


Other people will test other cases.

Then it belongs to Linus to see if he is satisfied with reports.
He can just take advantage of actual situation with testers.
This way Linux has a lot of possibility to run well on the most HW
(I am also thinking to alpha, sparc64, mips ecc.), and
with the most cases.



On Sun, 4 Nov 2001, Dan Kegel wrote:

> Mike Galbraith wrote:
> >
> > On Sat, 3 Nov 2001, Dan Kegel wrote:
> >
> > > I get the impression that Alan stress-tests his kernels
> > > more than Linus does before releasing them.
> >
> > That's _our_ collective job.  We're supposed to beat the snot out
> > of the -pre kernels and report.  One guy can't cover effectively,
> > even if his name is Linus "stress-testing is boring" Torvalds ;-)
>
> I'm not saying Linus should do the testing.
>
> It's good that Linus is asking others to test with cerberus, as he
> did in http://marc.theaimsgroup.com/?l=linux-kernel&m=100451768023436&w=2
>
> It would be even better if Linus came out and stated that he would
> refuse to call a kernel final if there is an outstanding report of
> it failing an agreed-upon set of stress tests.
>
> And it would be *even better* if http://osdl.org/stp/ were used
> to do stress testing in a nice, automated way on 1, 4, 8, and 16-cpu
> machines on release candidates.
>
> Almost none of this requires any work by Linus.  All Linus has to
> do is say "The 2.4.x kernels will pass stress tests before release",
> and recruit someone to run his kernels through OSDL's STP in a
> timely manner.
>
> (I'd be happy to help if it weren't for my darn tendinitis, which
> makes it hard even to stir up trouble on mailing lists these days.)
> - Dan
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

