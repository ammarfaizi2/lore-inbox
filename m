Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310825AbSCHMM7>; Fri, 8 Mar 2002 07:12:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310823AbSCHMMu>; Fri, 8 Mar 2002 07:12:50 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:49620 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S310827AbSCHMMb>; Fri, 8 Mar 2002 07:12:31 -0500
Date: Fri, 8 Mar 2002 13:57:31 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH][2.5] BUG check in elevator.c:237
In-Reply-To: <3C88A796.2070301@evision-ventures.com>
Message-ID: <Pine.LNX.4.44.0203081350190.5383-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Mar 2002, Martin Dalecki wrote:

> Please let me elaborate a bit on this, to give you may be
> some hints about where to look for an actual solution of
> the problem:

Thanks for taking the time to explain.

> However for cd-rom there are commands, which can
> take quite a long time. Therefore there is the possiblity there
> to provide a polling function, which will be engaged after the
> interrupt happens in the above function:

So are you suggesting perhaps that we change the request servicing to 
polling? I'm a bit confused as to how this would fit in with 
cdrom_decode_status (which in this case is called from the read_intr). You 
might need to whip out a larger clue stick ;)

Thanks again,
	Zwane


