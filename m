Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289839AbSAWNL3>; Wed, 23 Jan 2002 08:11:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289840AbSAWNLK>; Wed, 23 Jan 2002 08:11:10 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:6840 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S289839AbSAWNKx>; Wed, 23 Jan 2002 08:10:53 -0500
Date: Wed, 23 Jan 2002 15:06:53 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Ingo Molnar <mingo@elte.hu>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.2-pre2-3 SMP broken on UP boxen
In-Reply-To: <Pine.LNX.4.33.0201231555100.2467-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0201231505090.20902-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jan 2002, Ingo Molnar wrote:

> Al found the bug, in smpboot.c:
> 
> -        global_irq_holder = 0;
> +        global_irq_holder = NO_PROC_ID;
> 
> does this fix it?
> 

Unfortunately i'd have to go home to try it out, if you don't mind waiting 
till 10:00 GMT Thursday 24th i can send you a confirmation.

Thanks,
	Zwane Mwaikambo


