Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265664AbUBFSvP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 13:51:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265693AbUBFStL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 13:49:11 -0500
Received: from chaos.analogic.com ([204.178.40.224]:55936 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S265664AbUBFSsM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 13:48:12 -0500
Date: Fri, 6 Feb 2004 13:50:42 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Valdis.Kletnieks@vt.edu
cc: Roland Dreier <roland@topspin.com>, "Hefty, Sean" <sean.hefty@intel.com>,
       Troy Benjegerdes <hozer@hozed.org>,
       infiniband-general@lists.sourceforge.net,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Infiniband-general] Getting an Infiniband access layer in
 theLinux kernel 
In-Reply-To: <200402061822.i16IMdHJ013686@turing-police.cc.vt.edu>
Message-ID: <Pine.LNX.4.53.0402061336120.4238@chaos>
References: <C1B7430B33A4B14F80D29B5126C5E9470326258C@orsmsx401.jf.intel.com>
 <Pine.LNX.4.53.0402061150100.3862@chaos> <52smhounpn.fsf@topspin.com>     
       <Pine.LNX.4.53.0402061258110.4045@chaos> <200402061822.i16IMdHJ013686@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Feb 2004 Valdis.Kletnieks@vt.edu wrote:

> On Fri, 06 Feb 2004 13:00:38 EST, "Richard B. Johnson" said:
>
> > Yes you can. You just don't use an ';' if you are going
> > to use 'else'.
>
> You did realize we've changed things from macros to inline functions
> (and vice versa) on occasion?
>
> Yes, you *can* hack around the "problem".  Is there any actual
> evidence that any real performance issues arise from the null
> do/while?  Does said issue outweigh the increased fragility of
> the code?
>

Well the 'problem' is a demonstration. The last time I answered
a query about the "do {} while(0)", stuff (as an advocate), there
were tons of 'experts' that jumped on me for helping to propagate
this "atrocious" (as I recall) abuse of the 'C' language. I
was severely tongue-lashed into believing that there was no
actual reason for doing it that way.

Now, after I have been properly "trained" that "do {} while (0)" is
an abuse, we get the other 'experts' who say I'm wrong again!
Can't win.

In spite of the fact that the gcc compiler I'm using doesn't
care, and generates the same code either way, there are others
in the world who have looked at Linux code, in particular
the headers, and turned various shades of grey just before
running off to the head. I have spent a bunch of time looking
at C/C++ headers for Sun and W$ and the only place I've
ever seen the "do {} while(0)" stuff is in Linux. I think
it started with Linux (was a Linux Invention!), as some
kind of work-around, then it became a "Linux Signature".

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i986 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


