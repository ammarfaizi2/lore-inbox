Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262346AbSJVJT0>; Tue, 22 Oct 2002 05:19:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262354AbSJVJT0>; Tue, 22 Oct 2002 05:19:26 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:43447 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262346AbSJVJTZ>; Tue, 22 Oct 2002 05:19:25 -0400
Subject: Re: [PATCH] linux-2.5.43_vsyscall_A0
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@digeo.com>
Cc: Andi Kleen <ak@muc.de>, Jeff Dike <jdike@karaya.com>,
       Andrea Arcangeli <andrea@suse.de>, john stultz <johnstul@us.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>,
       george anzinger <george@mvista.com>,
       Stephen Hemminger <shemminger@osdl.org>,
       Bill Davidsen <davidsen@tmr.com>
In-Reply-To: <3DB4D41E.12454389@digeo.com>
References: <20021020023321.GS23930@dualathlon.random>
	<200210220507.AAA06089@ccure.karaya.com> <20021022041524.GA11474@averell> 
	<3DB4D41E.12454389@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 22 Oct 2002 10:39:16 +0100
Message-Id: <1035279556.31917.12.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-10-22 at 05:29, Andrew Morton wrote:
> Andi Kleen wrote:
> > 
> > For example
> > you would need to special case this in uaccess.h's access_ok(), which
> > would be quite a lot of overhead (any change to this function causes
> > many KB of binary bloat because *_user is so heavily used all over the kernel)
> 
> That's all uninlined in the -mm patches.  Saves 33k of text.

I assume it saves a sizable amount of exception tables too ?

