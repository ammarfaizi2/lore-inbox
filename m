Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312136AbSDDX4v>; Thu, 4 Apr 2002 18:56:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312277AbSDDX4l>; Thu, 4 Apr 2002 18:56:41 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:62225 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S312136AbSDDX4b>; Thu, 4 Apr 2002 18:56:31 -0500
Date: Thu, 4 Apr 2002 15:55:40 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Robert Love <rml@tech9.net>
cc: Andrew Morton <akpm@zip.com.au>, Roger Larsson <roger.larsson@norran.net>,
        Dave Hansen <haveblue@us.ibm.com>,
        "Adam J. Richter" <adam@yggdrasil.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Patch: linux-2.5.8-pre1/kernel/exit.c change caused BUG() at
 boot  time
In-Reply-To: <1017964079.23629.662.camel@phantasy>
Message-ID: <Pine.LNX.4.33.0204041554350.26177-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 4 Apr 2002, Robert Love wrote:
> 
> Hm, how so?  I contend not to rudely set the task state but instead mark
> the task as "preempted" in preempt_schedule and handle this case in
> schedule.

Ahh, I misunderstood - I thought you meant setting the bit when setting 
current->state.

Fair enough. Send me a patch to look at.

		Linus

