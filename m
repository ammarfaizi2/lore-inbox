Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271687AbRHUOA4>; Tue, 21 Aug 2001 10:00:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271683AbRHUOAq>; Tue, 21 Aug 2001 10:00:46 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:38673 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271677AbRHUOA0>; Tue, 21 Aug 2001 10:00:26 -0400
Subject: Re: sync hanging
To: cdhs@commerce.uk.net (Corin Hartland-Swann)
Date: Tue, 21 Aug 2001 15:03:05 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0108210353520.11035-100000@willow.commerce.uk.net> from "Corin Hartland-Swann" at Aug 21, 2001 03:58:47 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15ZC7V-0007uK-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Every now and again, running sync(1) (i.e. the program) seems to hang and
> end up in state D (uninterruptible sleep). There is no way to kill it
> (even with SIGKILL but I assume that this is typical for state D
> processes.

Can you replicate this in 2.4.8ac8, and if so where is it sleeping according
to ps wait queue data

I've had a couple of similar reports against 2.4.8 and early 8ac. I'm
curious if its still a problem as Im not aware of any reason it should have
been fixed by the vm fixups
