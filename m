Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292962AbSBVTaX>; Fri, 22 Feb 2002 14:30:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292960AbSBVTaN>; Fri, 22 Feb 2002 14:30:13 -0500
Received: from mailout.zma.compaq.com ([161.114.64.104]:55050 "EHLO
	zmamail04.zma.compaq.com") by vger.kernel.org with ESMTP
	id <S292959AbSBVT3z>; Fri, 22 Feb 2002 14:29:55 -0500
Message-ID: <3C769C2A.80059D73@zk3.dec.com>
Date: Fri, 22 Feb 2002 14:29:46 -0500
From: Peter Rival <frival@zk3.dec.com>
X-Mailer: Mozilla 4.77 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Jesse Barnes <jbarnes@sgi.com>
Cc: Mike Kravetz <kravetz@us.ibm.com>, lse-tech@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] NUMA scheduling
In-Reply-To: <20020222105606.C1575@w-mikek2.des.beaverton.ibm.com> <20020222111404.A1515593@sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ditto.  Maybe I'll even get a chance to check it out on an EV7. ;)

 - Pete

Jesse Barnes wrote:

> On Fri, Feb 22, 2002 at 10:56:06AM -0800, Mike Kravetz wrote:
> > Below is preliminary patch to implement some form of NUMA scheduling
> > on top of Ingo's K3 scheduler patch for 2.4.17.  This is VERY early
> > code and brings up some issues that need to be discussed/explored in
> > more detail.  This patch was created to form a basis for discussion,
> > rather than as a solution.  The patch was created for the i386 based
> > NUMA system I have access to.  It will not work on other architectures.
> > However, the only architecture specific code is a call to initialize
> > some of the NUMA specific scheduling data structures.  Therefore, it
> > should be trivial to port.
>
> Ah, you beat me to it; I was working on code very similar to this when
> I got your e-mail.  I think this sort of thing will address the
> problem we've been seeing on machines with more than 16 cpus or so
> (IDLE_REBALANCE_TICK is too small, flooding CPUs with load_balance
> requests), as well as making numa scheduling a little more efficient.
> I'll see if I can make it work on our platform and let you know how it
> goes.
>
> Jesse
>
> _______________________________________________
> Lse-tech mailing list
> Lse-tech@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/lse-tech

