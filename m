Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286292AbRLTREc>; Thu, 20 Dec 2001 12:04:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286293AbRLTREW>; Thu, 20 Dec 2001 12:04:22 -0500
Received: from mailout04.sul.t-online.com ([194.25.134.18]:28600 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S286292AbRLTREO>; Thu, 20 Dec 2001 12:04:14 -0500
To: mingo@elte.hu (Ingo Molnar)
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com, jamesclv@us.ibm.com
Subject: Re: [PATCH] MAX_MP_BUSSES increase
In-Reply-To: <Pine.LNX.4.33.0112192154190.19321-100000@penguin.transmeta.com> <Pine.LNX.4.33.0112201405550.6212-100000@localhost.localdomain>
From: Andi Kleen <ak@muc.de>
Date: 20 Dec 2001 18:03:36 +0100
In-Reply-To: mingo@elte.hu's message of "Thu, 20 Dec 2001 11:13:10 +0000 (UTC)"
Message-ID: <m3y9jxesd3.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.070095 (Pterodactyl Gnus v0.95) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mingo@elte.hu (Ingo Molnar) writes:

> On Wed, 19 Dec 2001, Linus Torvalds wrote:
> 
> > > Marcello and Linus, please apply.
> >
> > Can you give a rough description of what kinds of arrays this will
> > impact, just out of curiosity. Ie do we talk about "5kB more memory in
> > order to avoid problems", or are we talking about something
> > noticeable..
> >
> > 		Linus "too lazy to grep" Torvalds
> 
> the change is OK, it's about +3K RAM used, on SMP kernels.

hmm, I come more to 11K (most of it in mp_irqs) 
... which could be easily allocated with the bootmem allocator at parse time.

-Andi
