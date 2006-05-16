Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932248AbWEPWkr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932248AbWEPWkr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 18:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932247AbWEPWkq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 18:40:46 -0400
Received: from gra-lx1.iram.es ([150.214.224.41]:47297 "EHLO gra-lx1.iram.es")
	by vger.kernel.org with ESMTP id S932248AbWEPWko (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 18:40:44 -0400
From: Gabriel Paubert <paubert@iram.es>
Date: Wed, 17 May 2006 00:40:22 +0200
To: Junichi Uekawa <dancer@netfort.gr.jp>
Cc: linux-kernel@vger.kernel.org, debian-powerpc@lists.debian.org
Subject: Re: ppc: bogomips at 73 when CPU is at 1GHz
Message-ID: <20060516224022.GA27945@iram.es>
References: <87ac9hzn1g.dancerj%dancer@netfort.gr.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ac9hzn1g.dancerj%dancer@netfort.gr.jp>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2006 at 06:18:19AM +0900, Junichi Uekawa wrote:
> Hi,
> 
> I've noticed the very log value on bogomips on self-compiled 2.6.16.16
> on iBook G4.
> 
> [06:12:59]ibookg4:~> cat /proc/cpuinfo
> processor       : 0
> cpu             : 7447A, altivec supported
> clock           : 1066.666000MHz
> revision        : 0.1 (pvr 8003 0101)
> bogomips        : 73.47
> timebase        : 18432000
> machine         : PowerBook6,5
> motherboard     : PowerBook6,5 MacRISC3 Power Macintosh
> detected as     : 287 (iBook G4)
> pmac flags      : 0000001b
> L2 cache        : 512K unified
> pmac-generation : NewWorld
> 
> 
> It was somewhat higher on 2.6.14.
> 
> 
> Apparently I'm not the only person who noticed something similar; 
> but I can't really read spanish:

Well I can (I'm not a from Spain, but been living here
since 1986).

> 
> https://listas.hispalinux.es/pipermail/linux-ppc-es/2006-May/000820.html
> 
> 
> Am I missing something or is everyone seeing this?

Don't worry, bogomips are bogus. Now on PPC they are related to
the processor timebase frequency, which on G3 and G4 processor
is the bus frequency divided by 4.

	Regards,
	Gabriel
