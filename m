Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262119AbSJVEXU>; Tue, 22 Oct 2002 00:23:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262122AbSJVEXU>; Tue, 22 Oct 2002 00:23:20 -0400
Received: from packet.digeo.com ([12.110.80.53]:56229 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262119AbSJVEXU>;
	Tue, 22 Oct 2002 00:23:20 -0400
Message-ID: <3DB4D41E.12454389@digeo.com>
Date: Mon, 21 Oct 2002 21:29:18 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.42 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: Jeff Dike <jdike@karaya.com>, Andrea Arcangeli <andrea@suse.de>,
       john stultz <johnstul@us.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>,
       george anzinger <george@mvista.com>,
       Stephen Hemminger <shemminger@osdl.org>,
       Bill Davidsen <davidsen@tmr.com>
Subject: Re: [PATCH] linux-2.5.43_vsyscall_A0
References: <20021020023321.GS23930@dualathlon.random> <200210220507.AAA06089@ccure.karaya.com> <20021022041524.GA11474@averell>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Oct 2002 04:29:18.0939 (UTC) FILETIME=[96516AB0:01C27983]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> 
> For example
> you would need to special case this in uaccess.h's access_ok(), which
> would be quite a lot of overhead (any change to this function causes
> many KB of binary bloat because *_user is so heavily used all over the kernel)

That's all uninlined in the -mm patches.  Saves 33k of text.
