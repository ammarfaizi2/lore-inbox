Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267400AbRGLBSh>; Wed, 11 Jul 2001 21:18:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267401AbRGLBS3>; Wed, 11 Jul 2001 21:18:29 -0400
Received: from woodyjr.wcnet.org ([63.174.200.2]:46250 "EHLO woodyjr.wcnet.org")
	by vger.kernel.org with ESMTP id <S267400AbRGLBSX>;
	Wed, 11 Jul 2001 21:18:23 -0400
Message-ID: <000901c10a70$6acb2e40$0200000a@laptop>
From: "C. Slater" <cslater@wcnet.org>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <200107112344.f6BNijh2010363@webber.adilger.int>
Subject: Re: Switching Kernels without Rebooting?
Date: Wed, 11 Jul 2001 21:17:19 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2314.1300
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I will say that you are incredibly correct. Accualy rather funny.

> Not to be overly negative, I don't intend this email as an insult, but
rather
> as a "shed a little light" on the discussion email.  I would be _happy_ if
> you actually succeed in your project, but your comments come out as
follows:

> a) we want this "sounds real good" feature
 But at least it sounds good.

> b) we don't know how we will do it, beyond some hand waving ideas
We don't. We would like to change that.

> c) we want kernel experts who know what they are doing to help us
  Quite correct

> d) kernel experts who have replied so far (negatively) don't know what
>    they are talking about, so please butt out
We would like any information that they have. I hope they do not.

> e) you have "started coding" by setting up a sourceforge project
That line is hillarious to me. And you are right! I merely intended to show
that we are trying to go somewhere beyond a mailing list thread. To avoid
anything more i will say *trying* agin.

> Note that you are talking about a VERY difficult problem, which is
> not available on 99.9% of systems out there.  Maybe on a few highly
> specialized *nixes which were designed for this (Sequent or such),
> and probably have extra hardware support to help along.  I'm _pretty_
> sure that Solaris and AIX and HP/UX do NOT do this, and don't you think
> they would want to if it were easy?  It would be easier than under
> Linux from the perspective that their kernels change far less often,
> and have relatively static interfaces.
>
> The best proposal I've heard so far was to use MOSIX to do live job
> migration between machines, and then upgrade the kernel like normal.
> In the end, it is the jobs that are running on the kernel, and not
> the kernel or the individual machine that are the most important.  One
> person pointed out that there is a single point of failure in the
> MOSIX "stub" machine, which doesn't help you in the end (how do you
> update the kernel there?).  If you can figure a way to enhance MOSIX
> to allow migrating the MOSIX "stub" processes to another machine, you
> will have solved your problem in a much easier way, IMHO.

Unfortunatly I have not heard this yet. I have not been able to look at the
list
archives to see all of what has been posted there.

> Note also that you need to look at the _specific_ reason why you want to
> do live kernel upgrades, besides it "sounds real good".  If you have such
> tight uptime deadlines that you can't take 5 minutes of downtime to boot
> a new kernel, then you are probably using a load balancing cluster anyways
> in case of hardware failure, so live kernel updates are not needed here.
>
> Note that all real-world high-availability systems I ever worked on
> still allowed for SCHEDULED maintenance downtime, but highly frowned
> upon UNSCHEDULED downtime.  Even IBM's S/390 99.999% uptime numbers
> exclude downtime for SCHEDULED outages, which are simply a fact of life

> Please prove everyone wrong by developing a way to do this, or even
> showing a proof-of-concept (i.e. a user-space framework for translating
> every kernel data structures from one kernel version to another, that
> works across, say, a large fraction of the 2.2 kernel, or maybe from
> 2.4.0-test until 2.4.current).  It doesn't have to be in-kernel (yet).
>
> Cheers, Andreas
> --
> Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
>                  \  would they cancel out, leaving him still hungry?"
> http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

Thanks for you'r insight. Will try.

