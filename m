Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264984AbUH3Wr7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264984AbUH3Wr7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 18:47:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265086AbUH3Wr7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 18:47:59 -0400
Received: from zero.aec.at ([193.170.194.10]:17668 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S264984AbUH3Wr6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 18:47:58 -0400
To: Chris Lalancette <clalancette@illuminari.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] identifier string for P4 Prescott
References: <2z2vJ-7ND-13@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Tue, 31 Aug 2004 00:47:54 +0200
In-Reply-To: <2z2vJ-7ND-13@gated-at.bofh.it> (Chris Lalancette's message of
 "Tue, 31 Aug 2004 00:10:07 +0200")
Message-ID: <m3k6vgi6p1.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Lalancette <clalancette@illuminari.org> writes:

> A trivial patch to change the identifier in the kernel from "Unknown
> CPU [15:3]" to "Pentium 4(tm) Prescott".  Although Prescott is not the
> official name of the chip (I think Intel just decided to go with the
> P4 name), I do think it is useful to be able to identify this chip
> separately (given that it has a different core).  This is a patch
> against 2.4.27

2.6 dropped this decoding because it was useless (doesn't offer
any additional information). Maybe that should be just done on 2.4
too.

It doesn't offer any additional information because we get
the CPU name from CPUID anyways and it is a long term
mainteance burden.

-Andi

P.S.: The official Intel name for Prescott would be Pentium 4E 
(I don't know where to place the (tm) though) 

