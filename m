Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266555AbSKUL7Z>; Thu, 21 Nov 2002 06:59:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266585AbSKUL7Z>; Thu, 21 Nov 2002 06:59:25 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:16012 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S266555AbSKUL7Y>;
	Thu, 21 Nov 2002 06:59:24 -0500
Date: Thu, 21 Nov 2002 12:07:45 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Ulrich Drepper <drepper@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] threading enhancements, tid-2.5.47-C0
Message-ID: <20021121120745.GA14108@bjl1.asuk.net>
References: <20021121001819.GA12650@bjl1.asuk.net> <Pine.LNX.4.44.0211211007100.1782-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211211007100.1782-100000@localhost.localdomain>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

I'm just being anal and disagreeing with Ulrich over a technical
point, i.e. that the _only_ cost is a few syscalls, nothing
fundamental here :)

Ingo Molnar wrote:
> If all this userspace cost can be dealt with by doing some simple
> things in kernel-space, why not do it?

Agreed - separate child/parent tid pointers is fine.

Btw, what do you think of the CLONE_CHILD_BLOCKSIGS flag idea?

-- Jamie
