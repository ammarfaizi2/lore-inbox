Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289829AbSAWMZU>; Wed, 23 Jan 2002 07:25:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289831AbSAWMZK>; Wed, 23 Jan 2002 07:25:10 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:1189 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S289829AbSAWMY5>; Wed, 23 Jan 2002 07:24:57 -0500
Date: Wed, 23 Jan 2002 14:21:28 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Ingo Molnar <mingo@elte.hu>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.2-pre2-3 SMP broken on UP boxen
In-Reply-To: <Pine.LNX.4.33.0201231516390.1396-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0201231420270.20635-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jan 2002, Ingo Molnar wrote:

> 
> On Wed, 23 Jan 2002, Zwane Mwaikambo wrote:
> 
> > 	My test box is a single proc machine running an SMP kernel. As
> > of 2.5.2-pre2 it panics on boot. [...]
> 
> the same on 2.5.3-pre3 as well?

Yes -pre3 too, started at -pre2. I'm testing on -pre3 currently

> > [...] The reason is kinda obvious, smp_processor_id() will always
> > return the same as global_irq_holder. How come we do this check now?
> 
> it should only be set when the current CPU has disabled global IRQs.

Al Viro just asked me to try something, patch coming in...

Regards,
	Zwane Mwaikambo


