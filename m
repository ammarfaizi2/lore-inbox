Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261485AbRE2RFC>; Tue, 29 May 2001 13:05:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261490AbRE2RE4>; Tue, 29 May 2001 13:04:56 -0400
Received: from zeus.kernel.org ([209.10.41.242]:47020 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S261493AbRE2Q7H>;
	Tue, 29 May 2001 12:59:07 -0400
Subject: Re: VIA Samuel problem? 2.2.19,2.4.4
To: aaron@stasis.org (aaron)
Date: Tue, 29 May 2001 16:31:27 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel)
In-Reply-To: <Pine.LNX.4.33.0105291119040.2793-100000@mk2.stasis.org> from "aaron" at May 29, 2001 11:19:20 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E154lSx-0004X3-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I am experiencing an interesting problem with a VIA Samuel (Cyrix III) 667
> processor, on an M755LMR motherboard (GFXcel sis630e chipset) 64M ram.
> Unfortunately I don't have access to another socket370 mobo to test right

Im running a couple of CyrixIII boxes. One on an A/Open MX3S (early rev[1])
which works very nicely and the other a Gigabyte GAJR4. I've not observed any 
slowdowns over long periods but I haven't been looking for them either

> now.  Anyways, when left running over a 24 hour period, performance
> seriously degrades. This happens on both stock 2.2.19 (M586TSC) and 2.4.4
> (MCYRIXIII) kernels. We have tested AMD's, PIII's and Celeron's all on
> the same board, same setup without a problem.

Check the CPU isnt overheating. Most processors will drop their clock if
they get an overheat. Not that it should be easy to get a CyrixIII to overheat
The Cyrix howto won't help you. The VIA C3 is in fact an IDT winchip derivative.

Alan
[1] The later MX3S boards seem badly screwy with all cpus - or I got bad boards
but those went back.


