Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131772AbRCXT21>; Sat, 24 Mar 2001 14:28:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131773AbRCXT2Q>; Sat, 24 Mar 2001 14:28:16 -0500
Received: from mozart.stat.wisc.edu ([128.105.5.24]:46089 "EHLO
	mozart.stat.wisc.edu") by vger.kernel.org with ESMTP
	id <S131772AbRCXT2O>; Sat, 24 Mar 2001 14:28:14 -0500
To: Mike Galbraith <mikeg@wen-online.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.2-ac20 patch for process time double-counting (was: Linux 2.4.2 fails to merge mmap areas, 700% slowdown.)
In-Reply-To: <Pine.LNX.4.33.0103240841280.2032-100000@mikeg.weiden.de>
From: buhr@stat.wisc.edu (Kevin Buhr)
In-Reply-To: Mike Galbraith's message of "Sat, 24 Mar 2001 08:49:57 +0100 (CET)"
Date: 24 Mar 2001 13:27:15 -0600
Message-ID: <vbaitkzvugc.fsf@mozart.stat.wisc.edu>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith <mikeg@wen-online.de> writes:
> 
> Times are fine.  Local APIC timer interrupts are used.

Okay, thanks.  That's good.

> Testing's easy, thanks for the fix.

This is where I'd submit the patch, but Alan evidently works 80 hours
a day.  ;)  The new patch is already in ac24.

Alan, FYI, I tested the patch on my SMP motherboard with CONFIG_SMP
(and maxcpus=0,1,unspecified) and with all combinations of
CONFIG_X86_UP_{,IO}APIC) and Michael tested CONFIG_SMP and
CONFIG_X86_UP_APIC on his non-SMP motherboard, so I don't think this
will come back to bite anyone.

Thanks!

Kevin <buhr@stat.wisc.edu>
