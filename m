Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318166AbSG3AXW>; Mon, 29 Jul 2002 20:23:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318168AbSG3AXW>; Mon, 29 Jul 2002 20:23:22 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:8202 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318166AbSG3AXW>; Mon, 29 Jul 2002 20:23:22 -0400
Date: Mon, 29 Jul 2002 17:26:41 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Robert Love <rml@tech9.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] spinlock.h cleanup
In-Reply-To: <1027987291.1016.221.camel@sinai>
Message-ID: <Pine.LNX.4.33.0207291725580.1722-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 29 Jul 2002, Robert Love wrote:
> 
> Tested on UP, SMP, and preempt.  Object code is unchanged.  Patch is
> against 2.5-bk but should apply to 2.5.29.  Please, apply.

Hmm.. Why did you remove the gcc workaround? Are all gcc's > 2.95 known to 
be ok wrt empty initializers?

		Linus

