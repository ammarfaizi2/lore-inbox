Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132658AbRDUOhf>; Sat, 21 Apr 2001 10:37:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132668AbRDUOhZ>; Sat, 21 Apr 2001 10:37:25 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:15372 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S132658AbRDUOhO>;
	Sat, 21 Apr 2001 10:37:14 -0400
From: rmk@arm.linux.org.uk
Message-Id: <200104211437.PAA01945@raistlin.arm.linux.org.uk>
Subject: Re: x86 rwsem in 2.4.4pre[234] are still buggy [was Re: rwsem benchmarks [Re: generic rwsem [Re: Alpha "process table hang"]]]
To: andrea@suse.de (Andrea Arcangeli)
Date: Sat, 21 Apr 2001 15:37:05 +0100 (BST)
Cc: torvalds@transmeta.com (Linus Torvalds),
        dhowells@astarte.free-online.co.uk (D . W . Howells),
        dhowells@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <20010421162926.D17757@athlon.random> from "Andrea Arcangeli" at Apr 21, 2001 04:29:26 PM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli writes:
> That it is allowed by my generic code that does spin_lock_irq in down_* and
> spin_lock_irqsave in up_* but it's disallowed by the weaker semantics of the
> generic and x86 semaphores 2.4.4pre[2345] (or + David's last patch).

Hang on, who's code is in 2.4.4-pre5?  It claims to be Davids, which does
suffer from the problem I described.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

