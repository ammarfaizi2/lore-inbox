Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267288AbSLEKwA>; Thu, 5 Dec 2002 05:52:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267270AbSLEKvk>; Thu, 5 Dec 2002 05:51:40 -0500
Received: from ophelia.ess.nec.de ([193.141.139.8]:27285 "EHLO
	ophelia.ess.nec.de") by vger.kernel.org with ESMTP
	id <S267288AbSLEKuJ> convert rfc822-to-8bit; Thu, 5 Dec 2002 05:50:09 -0500
Content-Type: text/plain; charset=US-ASCII
From: Erich Focht <efocht@ess.nec.de>
To: Andrew Morton <akpm@digeo.com>
Subject: Re: per cpu time statistics
Date: Thu, 5 Dec 2002 11:57:29 +0100
User-Agent: KMail/1.4.3
Cc: William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>,
       LSE <lse-tech@lists.sourceforge.net>
References: <200212041343.39734.efocht@ess.nec.de> <3DEE3FAE.558649F5@digeo.com>
In-Reply-To: <3DEE3FAE.558649F5@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212051157.29775.efocht@ess.nec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 04 December 2002 18:47, Andrew Morton wrote:
> It's mainly the big ia32 boxes which a) have a lot of CPUs and
> b) have a lot of memory and c) run a lot of tasks.  They're
> gasping for normal-zone memory.

There's a world beyond 32 bits, with plenty of normal-zone memory ;-)

> I'm half-inclined to just revert the whole thing and put the stats
> back, rather than adding yet another obscure config option.  But
> your patch is certainly very tidy...

My patch is basically the reverting patch plus changed ifdefs and a
bunch of Kconfig entries. I'd be happy to get this feature back, no
matter how it is implemented. I think it is necessary for performance
analysis on HT, NUMA, SMT systems.

Regards,
Erich
 


