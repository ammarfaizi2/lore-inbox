Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261531AbUL0HDM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261531AbUL0HDM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 02:03:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261756AbUL0HDM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 02:03:12 -0500
Received: from pirx.hexapodia.org ([199.199.212.25]:28197 "EHLO
	pirx.hexapodia.org") by vger.kernel.org with ESMTP id S261531AbUL0HDK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 02:03:10 -0500
Date: Sun, 26 Dec 2004 23:03:09 -0800
From: Andy Isaacson <adi@hexapodia.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>,
       "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       tglx@linutronix.de, akpm@osdl.org
Subject: Re: VM fixes [->used_math to PF_USED_MATH] [6/4]
Message-ID: <20041227070309.GA28907@hexapodia.org>
References: <20041224174156.GE13747@dualathlon.random> <20041224100147.32ad4268.davem@davemloft.net> <20041224182219.GH13747@dualathlon.random> <Pine.LNX.4.58.0412241533170.2353@ppc970.osdl.org> <20041225022721.GR13747@dualathlon.random> <20041225032430.GT13747@dualathlon.random> <20041225145321.GU13747@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041225145321.GU13747@dualathlon.random>
User-Agent: Mutt/1.4.1i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 25, 2004 at 03:53:21PM +0100, Andrea Arcangeli wrote:
> only to the future ones based on 2.6.10+, since the ev4 race on
> SMP/PREEMPT is not relevant for the suse tree (those last two patches
> are a bit too big to take any risk for a _purerly_theoretical_ race on
> ev4 + SMP or ev4 + PREEMPT ;). The PF_MEMDIE was instead a more pratical
> race (Wli said he triggered it in practice too) and it was triggering on
> all archs, not just on ev4 + SMP or evr + PREEMPT, that's fixed with
> [1-4]/4.

FWIW, BWX showed up in ev56.  So ev5 is also missing atomic byte
instructions, and there definitely are (were?) SMP ev5 machines
supported by Linux.

I can't find any authoritative source for that assertion, but google
supports it:
http://sources.redhat.com/ml/libc-alpha/2002-09/msg00328.html

-andy
