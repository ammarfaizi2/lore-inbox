Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262310AbTKXCT6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Nov 2003 21:19:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262328AbTKXCT6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Nov 2003 21:19:58 -0500
Received: from mail-05.iinet.net.au ([203.59.3.37]:16773 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S262310AbTKXCT5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Nov 2003 21:19:57 -0500
Message-ID: <3FC16AC8.4030400@cyberone.com.au>
Date: Mon, 24 Nov 2003 13:19:52 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Andi Kleen <ak@colin2.muc.de>,
       Ingo Molnar <mingo@elte.hu>, Andi Kleen <ak@muc.de>,
       Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>,
       jbarnes@sgi.com, efocht@hpce.nec.com, John Hawkes <hawkes@sgi.com>,
       wookie@osdl.org
Subject: Re: [RFC] generalise scheduling classes
References: <Pine.LNX.4.56.0311171638140.29083@earth> <20031118173607.GA88556@colin2.muc.de> <Pine.LNX.4.56.0311181846360.23128@earth> <20031118235710.GA10075@colin2.muc.de> <3FBAF84B.3050203@cyberone.com.au> <501330000.1069443756@flay> <3FBF099F.8070403@cyberone.com.au> <1010800000.1069532100@[10.10.2.4]> <3FC01817.3090705@cyberone.com.au> <3FC0A0C2.90800@cyberone.com.au> <20031123213817.GU22764@holomorphy.com>
In-Reply-To: <20031123213817.GU22764@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



William Lee Irwin III wrote:

>On Sun, Nov 23, 2003 at 10:57:54PM +1100, Nick Piggin wrote:
>
>>Class is struct sched_class in include/linux/sched.h
>>Default classes are built by arch_init_sched_classes in kernel/sched.c
>>http://www.kerneltrap.org/~npiggin/w23/
>>The patch in question is this one
>>http://www.kerneltrap.org/~npiggin/w23/broken-out/sched-domain.patch
>>
>
>There's a small terminological oddity in that "class" is usually meant
>to describe policies governing a task, and "domain" system partitions
>like the bits in your patch (I don't recall if they're meant to be
>logical or physical). e.g. usage elsewhere would say that there is an
>"interactive class", a "timesharing class", a "realtime class", and so
>on. Apart from that (and I suppose it's a minor concern), this appears
>relatively innocuous.
>

Yeah as you see from the name of the patch as well I got a bit muddled.
I think I'd better change it to sched_domain. Good point.


