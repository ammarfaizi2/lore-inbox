Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131138AbRCGSOh>; Wed, 7 Mar 2001 13:14:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131139AbRCGSO1>; Wed, 7 Mar 2001 13:14:27 -0500
Received: from infis-gw.ts.infn.it ([140.105.7.230]:41738 "EHLO
	sole.infis.univ.trieste.it") by vger.kernel.org with ESMTP
	id <S131138AbRCGSOW>; Wed, 7 Mar 2001 13:14:22 -0500
Date: Wed, 7 Mar 2001 19:13:55 +0100 (CET)
From: Andrea Barisani <lcars@infis.univ.trieste.it>
To: Manfred Spraul <manfred@colorfullife.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.2 command execution hangs and then succeded after 2
  minutes....!? END!
In-Reply-To: <Pine.LNX.4.10.10103071458560.9169-100000@sole.infis.univ.trieste.it>
Message-ID: <Pine.LNX.4.10.10103071906430.13221-100000@sole.infis.univ.trieste.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Mar 2001, Andrea Barisani wrote:

> On Wed, 7 Mar 2001, Manfred Spraul wrote:
> 
> > Could you use strace and check what the apps are doing during these 2
> > minutes?
> > 
> > Perhaps it's a variation of the nis hang:
> > 2.4 doesn't forword udp error messages to the user space app, and thus a
> > nis query to a nonexistant nis server blocks until the udp packets time
> > out.
> > 

Ok!

I've removed all nis reference in /etc/nsswitch.conf and now there are no
more hangs...I have to admit, learning that thew execution process of tar
is somehow related to nis,portmap is a little weird :) (but that's part of
the fun isn't it?).

Thanks again for the help

Bye

P.S. 
Does anyone think that this kind of problem must be documentated in
the kernel documentation?

