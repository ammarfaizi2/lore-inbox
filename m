Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318935AbSH1TSh>; Wed, 28 Aug 2002 15:18:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318936AbSH1TSh>; Wed, 28 Aug 2002 15:18:37 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:65527 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318935AbSH1TSg>; Wed, 28 Aug 2002 15:18:36 -0400
Subject: Re: [PATCH][2.5.32] CPU frequency and voltage scaling (0/4)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Cort Dougan <cort@fsmlabs.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Dominik Brodowski <devel@brodo.de>, cpufreq@www.linux.org.uk,
       linux-kernel@vger.kernel.org
In-Reply-To: <20020828124839.F5492@host110.fsmlabs.com>
References: <20020828134600.A19189@brodo.de>
	<Pine.LNX.4.33.0208281140030.4507-100000@penguin.transmeta.com> 
	<20020828124839.F5492@host110.fsmlabs.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 28 Aug 2002 20:25:08 +0100
Message-Id: <1030562708.7190.59.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-08-28 at 19:48, Cort Dougan wrote:
> It's even worse for some of the very new P4's that don't have their
> heatsink seated properly.  They heat up every few minutes and then throttle
> themselves due to thermal overload.  I think this situation is going to
> become more and more common, now.  We're at the mercy of every BIOS and

Systems designers are designing on the basis of thermal slowdowns being
the optimal way to build some systems. Its actually quite reasonable for
many workloads.

> micro-code programmer now-a-days.  That situation needs to be improved
> upon, as well.

Cpufreq doesn't handle this case yet in the 2.4 code but it already
includes the needed udelay correction. Not everything CPUfreq has to
deal with need be user initiated


