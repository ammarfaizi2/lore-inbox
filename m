Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317483AbSGOL7X>; Mon, 15 Jul 2002 07:59:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317484AbSGOL7W>; Mon, 15 Jul 2002 07:59:22 -0400
Received: from noc.easyspace.net ([62.254.202.67]:50184 "EHLO
	noc.easyspace.net") by vger.kernel.org with ESMTP
	id <S317483AbSGOL7W>; Mon, 15 Jul 2002 07:59:22 -0400
Date: Mon, 15 Jul 2002 13:02:01 +0100
From: Sam Vilain <sam@vilain.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: dax@gurulabs.com, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Ext3 vs Reiserfs benchmarks
In-Reply-To: <1026736251.13885.108.camel@irongate.swansea.linux.org.uk>
References: <1026490866.5316.41.camel@thud>
	<1026679245.15054.9.camel@thud>
	<E17U1BD-0000m0-00@hofmann>
	<1026736251.13885.108.camel@irongate.swansea.linux.org.uk>
X-Mailer: Sylpheed version 0.7.8claws (GTK+ 1.2.10; i386-debian-linux-gnu)
X-Face: NErb*2NY4\th?$s.!!]_9le_WtWE'b4;dk<5ot)OW2hErS|tE6~D3errlO^fVil?{qe4Lp_m\&Ja!;>%JqlMPd27X|;b!GH'O.,NhF*)e\ln4W}kFL5c`5t'9,(~Bm_&on,0Ze"D>rFJ$Y[U""nR<Y2D<b]&|H_C<eGu?ncl.w'<
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <E17U4YE-0000TL-00@hofmann>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> > You are testing for a mail server - how many mailboxes are in your spool 
> > directory for the tests?  Try it with about five to ten thousand
> > mailboxes and see how your results vary.
> If your mail server can't get heirarchical mail spools right, get one
> that can. 

Translation

   "Yes, we know that there is no directory hashing in ext2/3.  You'll have to find another solution to the problem, I'm afraid.  Why not ease the burden on the filesystem by breaking up the task for it, and giving it to it in small pieces.  That way it's much less likely to choke."

 :-)

Sure, you could set up hierarchical mail spools.  But it sure stinks of a temporary solution for a long-term problem.  What about the next application that grows to massive proportions?

Hey, while I've got your attention, how do you go about debugging your kernel?  I'm trying to add fair scheduling to the new O(1) scheduler, something of a token bucket filter counting jiffies used by a process/user/s_context (in scheduler_tick()) and tweaking their priority accordingly (in effective_prio()).  It'd be really nice if I could run it under UML or something like that so I can trace through it with gdb, but I couldn't get the UML patch to apply to your tree.  Any hints?
--
   Sam Vilain, sam@vilain.net     WWW: http://sam.vilain.net/
    7D74 2A09 B2D3 C30F F78E      GPG: http://sam.vilain.net/sam.asc
    278A A425 30A9 05B5 2F13

