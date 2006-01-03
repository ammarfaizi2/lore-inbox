Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932378AbWACOdg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932378AbWACOdg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 09:33:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932373AbWACOdg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 09:33:36 -0500
Received: from mail.gmx.net ([213.165.64.21]:9874 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932351AbWACOdT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 09:33:19 -0500
X-Authenticated: #4399952
Date: Tue, 3 Jan 2006 15:33:17 +0100
From: Florian Schmidt <mista.tapas@gmx.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rt1
Message-ID: <20060103153317.26a512fa@mango.fruits.de>
In-Reply-To: <20060103094720.GA16497@elte.hu>
References: <20060103094720.GA16497@elte.hu>
X-Mailer: Sylpheed-Claws 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Jan 2006 10:47:20 +0100
Ingo Molnar <mingo@elte.hu> wrote:

> i have released the 2.6.15-rt1 tree, which can be downloaded from the 
> usual place:
> 
>    http://redhat.com/~mingo/realtime-preempt/
> 
> no big changes, this release is mainly a merge to v2.6.15, and should 
> fix some of the RTC driver problems reported for 2.6.15-rc7-rt3.

And indeed it does so for me. Thanks. The swapper BUG is still there,
but i suppose that was expected?

BUG: swapper:0 task might have lost a preemption check!
 [<c0100b3b>] cpu_idle+0x6b/0xb0 (8)
 [<c010026b>] _stext+0x4b/0x60 (4)
 [<c0364831>] start_kernel+0x191/0x210 (16)
 [<c0364350>] unknown_bootoption+0x0/0x200 (20)
---------------------------
| preempt count: 00000000 ]
| 0-level deep critical section nesting:
----------------------------------------

------------------------------
| showing all locks held by: |  (swapper/0 [c0319d20, 140]):
------------------------------

Flo

-- 
Palimm Palimm!
http://tapas.affenbande.org
