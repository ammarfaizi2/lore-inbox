Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932564AbVL2Ah6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932564AbVL2Ah6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 19:37:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932565AbVL2Ah6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 19:37:58 -0500
Received: from smtpout8.uol.com.br ([200.221.4.199]:29097 "EHLO
	smtp.uol.com.br") by vger.kernel.org with ESMTP id S932564AbVL2Ah5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 19:37:57 -0500
Date: Wed, 28 Dec 2005 22:37:50 -0200
From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Matt Mackall <mpm@selenic.com>
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
Message-ID: <20051229003750.GA8465@ime.usp.br>
Mail-Followup-To: Ingo Molnar <mingo@elte.hu>,
	Linus Torvalds <torvalds@osdl.org>,
	Arjan van de Ven <arjan@infradead.org>,
	lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
	Matt Mackall <mpm@selenic.com>
References: <20051228114637.GA3003@elte.hu> <Pine.LNX.4.64.0512281111080.14098@g5.osdl.org> <1135798495.2935.29.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0512281300220.14098@g5.osdl.org> <20051228212313.GA4388@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20051228212313.GA4388@elte.hu>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 28 2005, Ingo Molnar wrote:
> how about giving the inlining stuff some more exposure in -mm (if it's 
> fine with Andrew), to check for any regressions? I'd suggest the same 
> for the unit-at-a-time thing too, in any case.

I am willing to give a try to the patches on both ia32 and ppc (which is
what I have at hand). I'm using Debian testing, but I can, perhaps, give
GCC 4.1 a shot (if I happen to grab my hands on such patched tree soon
enough).

I am interested in anything that could bring me memory reduction.
Actually, I am even considering using the -tiny patches here on my
father's computer---an old Pentium MMX 200MHz with 64MB of RAM.

Also, the PowerMac 9500 that I have here was inherited from my uncle and
it has a slow SCSI disk (only 2MB/s of transfer rates) and 192MB of RAM.
Anything that makes it avoid hitting swap is a plus, as you can imagine.


Thanks, Rogério.

-- 
Rogério Brito : rbrito@ime.usp.br : http://www.ime.usp.br/~rbrito
Homepage of the algorithms package : http://algorithms.berlios.de
Homepage on freshmeat:  http://freshmeat.net/projects/algorithms/
