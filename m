Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264002AbTE0RmW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 13:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264005AbTE0RlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 13:41:15 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:55045 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S264002AbTE0Rkb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 13:40:31 -0400
Date: Tue, 27 May 2003 10:53:11 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Ricky Beam <jfbeam@bluetronic.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.70
In-Reply-To: <1054054133.18814.3.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0305271048380.6665-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 27 May 2003, Alan Cox wrote:
> 
> Architectures are also normally just a sync up job and its again easier
> to do once the core has stoppee changing.

Indeed. I think its more the rule than the exception that non-x86 
architectures "get with the program" sometime during the stable release 
rather than before. There's just not a lot of incentive for the odd-ball 
architectures to care before the fact.

Would I prefer to have everything fixed by 2.6.0 (or even the pre-2.6 
kernels)? Sure, everybody would. But it's just a fact of life that we 
won't see people who care about the issues before that happens.

In fact, judging by past performance, a lot of things won't get fixed 
before the actual vendors have made _releases_ that use 2.6.x (and the 
first ones inevitably will have 2.4.x as a fall-back: that's only prudent 
and sane).

This is not just a core kernel issue - we've seen this with subsystems 
like ext3 and ReiserFS: they were "finished' and "stable", but what made 
them _really_ stable was a release or two on vendor kernels, and thousands 
of users.

			Linus

