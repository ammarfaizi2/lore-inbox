Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288028AbSAHNro>; Tue, 8 Jan 2002 08:47:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288029AbSAHNre>; Tue, 8 Jan 2002 08:47:34 -0500
Received: from jalon.able.es ([212.97.163.2]:29412 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S288028AbSAHNrX>;
	Tue, 8 Jan 2002 08:47:23 -0500
Date: Tue, 8 Jan 2002 14:51:40 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Dieter =?iso-8859-15?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Andrea Arcangeli <andrea@suse.de>,
        Rik van Riel <riel@conectiva.com.br>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@zip.com.au>, Robert Love <rml@tech9.net>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-ID: <20020108145140.A4250@werewolf.able.es>
In-Reply-To: <20020108030420Z287595-13997+1799@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
In-Reply-To: <20020108030420Z287595-13997+1799@vger.kernel.org>; from Dieter.Nuetzel@hamburg.de on Tue, Jan 08, 2002 at 04:02:44 +0100
X-Mailer: Balsa 1.3.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20020108 Dieter Nützel wrote:
>Is it possible to decide, now what should go into 2.4.18 (maybe -pre3) -aa or 
>-rmap?
>Andrew Morten`s read-latency.patch is a clear winner for me, too.
>What about 00_nanosleep-5 and bootmem?
>The O(1) scheduler?
>Maybe preemption? It is disengageable so nobody should be harmed but we get 
>the chance for wider testing.
>
>Any comments?
>

I would pefer the ton of small, usefull and safe bits in Andrea's kernel
(vm-21, cache-aligned-spinlocks, compiler, gcc3, rwsem, highmen fixes...)

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.2 (Cooker) for i586
Linux werewolf 2.4.18-pre2-beo #1 SMP Tue Jan 8 03:18:18 CET 2002 i686
