Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290274AbSAXGnl>; Thu, 24 Jan 2002 01:43:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290277AbSAXGnb>; Thu, 24 Jan 2002 01:43:31 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:45261 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S290274AbSAXGnX>; Thu, 24 Jan 2002 01:43:23 -0500
Date: Thu, 24 Jan 2002 08:39:46 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Ingo Molnar <mingo@elte.hu>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@math.psu.edu>
Subject: Re: 2.5.2-pre2-3 SMP broken on UP boxen
In-Reply-To: <Pine.LNX.4.44.0201231505090.20902-100000@netfinity.realnet.co.sz>
Message-ID: <Pine.LNX.4.44.0201240838220.28541-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jan 2002, Zwane Mwaikambo wrote:

> On Wed, 23 Jan 2002, Ingo Molnar wrote:
> 
> > Al found the bug, in smpboot.c:
> > 
> > -        global_irq_holder = 0;
> > +        global_irq_holder = NO_PROC_ID;
> > 
> > does this fix it?
> > 
> 
> Unfortunately i'd have to go home to try it out, if you don't mind waiting 
> till 10:00 GMT Thursday 24th i can send you a confirmation.

I can confirm that it works (but you both knew that ;).

Thanks,
	Zwane Mwaikambo

