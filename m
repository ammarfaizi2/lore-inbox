Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272450AbRIKN4Q>; Tue, 11 Sep 2001 09:56:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268017AbRIKN4H>; Tue, 11 Sep 2001 09:56:07 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:55361 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S272462AbRIKNz5>; Tue, 11 Sep 2001 09:55:57 -0400
Date: Tue, 11 Sep 2001 15:56:52 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: alan@lxorguk.ukuu.org.uk, Paul Mckenney <paul.mckenney@us.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.10pre7aa1
Message-ID: <20010911155652.A715@athlon.random>
In-Reply-To: <20010911183534.A2340@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010911183534.A2340@in.ibm.com>; from dipankar@in.ibm.com on Tue, Sep 11, 2001 at 06:35:34PM +0530
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2001 at 06:35:34PM +0530, Dipankar Sarma wrote:
> In article <E15gmqD-0002YK-00@the-village.bc.nu> you wrote:
> >> BTW, I fixed a few more issues in the rcu patch (grep for
> >> down_interruptible for instance), here an updated patch (will be
> >> included in 2.4.10pre8aa1 [or later -aa]) with the name of rcu-2.
> 
> > I've been made aware of one other isue with the RCU patch
> > US Patent #05442758
> 
> > In the absence of an actual real signed header paper patent use grant for GPL 
> > usage from the Sequent folks that seems to be rather hard to fix.
> 
> > Alan
> 
> Hi Alan,
> 
> IBM bought us a couple of years ago and linux RCU is an IBM approved 
> project. I am not sure I understand what exactly is needed for patent use 
> grant for GPL, but whatever it is, I see absolutely no problem getting it done.
> I would appreciate if you let me know what is needed for GPL.

Nothing is needed but without changes we would prefer not to include the
rcu patch in the kernel. AFIK (and I'm far from being an expert here) I
can upload the source protected by patent to kernel.org and everybody
but US citizens can safely run the code protected by patent without
having to pay the patent holder. So in short the problem is that it
wouldn't be nice if you could download freely the linux kernel but you
couldn't use it freely in the US without first dropping the rcu patch.

In short AFIK from your part you should just make a modification to the
patent (or whatever else legal paperwork) saying that the usage of the
rcu technology in GPL code is allowed free of charge.

Andrea
