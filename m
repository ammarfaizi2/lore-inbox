Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131460AbREBLIf>; Wed, 2 May 2001 07:08:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131643AbREBLIZ>; Wed, 2 May 2001 07:08:25 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:11279 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131460AbREBLIJ>; Wed, 2 May 2001 07:08:09 -0400
Subject: Re: reason for VIA performance drop since 2.4.2-ac21
To: jp@ulgo.koti.com.pl (Jacek =?iso-8859-2?Q?Pop=B3awski?=)
Date: Wed, 2 May 2001 12:11:10 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010502014216.A604@localhost.localdomain> from "Jacek =?iso-8859-2?Q?Pop=B3awski?=" at May 02, 2001 01:42:16 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14uuXJ-0003PY-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It has nothing to do with mtrr or K6.  In file arch/i386/kernel/pci-pc.c there
> is a pci_fixup_via691_2 function.  It appeared in 2.4.2-ac21. And it works for
> my chipset - VIA_82C598. When I put "return" in body of this function,
> recompile and start kernel 2.4.4 - "x11perf -putimage100" shows that video
> works fast again.

My log says that this was a change pulled in from Linus tree. I don't know who
put it there or why

> 1) this is just a debug code, and kernels >2.4.2-ac20 shouldn't be used by VIA
> MVP3 owners
> 2) this code fix crash possibility, and all kernels without it (including
> 2.2.19) are buggy with VIA MVP3

Im not aware of any write posting bugs on the MVP3 but I dont follow the
chipset in detail.


