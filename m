Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286895AbSABJ5x>; Wed, 2 Jan 2002 04:57:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286898AbSABJ5n>; Wed, 2 Jan 2002 04:57:43 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:13065 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S286895AbSABJ5a>; Wed, 2 Jan 2002 04:57:30 -0500
Subject: Re: Linux 2.4.17 vs 2.2.19 vs rml new VM
To: brian@worldcontrol.com
Date: Wed, 2 Jan 2002 10:07:59 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020102013305.A5272@top.worldcontrol.com> from "brian@worldcontrol.com" at Jan 02, 2002 01:33:05 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16LiJT-0003Yg-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I tried rmap-10 new VM and under my typical load my desktop machine
> froze repeatedly.  Seemed the memory pool was going down the drain
> before the freeze. Meaning apps were failing and getting stuck in
> various odd states.
> 
> No doubt, preempt and rmap-10 are incompatible, but I'm not going to
> give up the preempt patch any time soon.

I suspect its rmap-10 not the pre-empt patch. If you have the
time/inclination then testing just that load with rmap10a (the fixed rmap10)
would be interesting just to know which bit is the buggy half.

Similarly the low latency patch which on the whole seems to give better
results than the preempt patches is much less likely to cause problems as it
doesn't really change the system semantics in the same kind of way
