Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317140AbSFFTtQ>; Thu, 6 Jun 2002 15:49:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317142AbSFFTtP>; Thu, 6 Jun 2002 15:49:15 -0400
Received: from ns.suse.de ([213.95.15.193]:785 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S317140AbSFFTtO>;
	Thu, 6 Jun 2002 15:49:14 -0400
To: "Ulrich Weigand" <Ulrich.Weigand@de.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] 4KB stack + irq stack for x86
In-Reply-To: <OF70FD985F.A9C66B00-ONC1256BD0.0069C993@de.ibm.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 06 Jun 2002 21:49:15 +0200
Message-ID: <p73lm9schms.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Ulrich Weigand" <Ulrich.Weigand@de.ibm.com> writes:

> (*Really* ugly is s390x, because we need about twice as much stack on
> average than on s390, but page size is still only 4K -- most other 64-bit
> platforms have 8K page size ...)

<minor detail, but perhaps still interesting>

Seems to be an old myth. Actually the 4K paged 64bit platforms are in the majority.

64bit linux platforms:

4K page: x86-64, ppc64, s390x, mips64, parisc64(?)
8K:	 alpha, sparc64
8-64K:   ia64

-Andi
