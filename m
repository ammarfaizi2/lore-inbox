Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131071AbRCGUDH>; Wed, 7 Mar 2001 15:03:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131172AbRCGUCz>; Wed, 7 Mar 2001 15:02:55 -0500
Received: from smtp1.cern.ch ([137.138.128.38]:65039 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S131171AbRCGUCo>;
	Wed, 7 Mar 2001 15:02:44 -0500
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Mark Hemment <markhe@veritas.com>, linux-kernel@vger.kernel.org
Subject: Re: Q: explicit alignment control for the slab allocator
In-Reply-To: <Pine.LNX.4.21.0103011800460.11260-100000@alloc> <3A9EA940.CB82665C@colorfullife.com>
From: Jes Sorensen <jes@linuxcare.com>
Date: 07 Mar 2001 21:02:03 +0100
In-Reply-To: Manfred Spraul's message of "Thu, 01 Mar 2001 20:55:44 +0100"
Message-ID: <d3lmqhny9w.fsf@lxplus015.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Manfred" == Manfred Spraul <manfred@colorfullife.com> writes:

Manfred> Mark Hemment wrote:
>> As no one uses the feature it could well be broken, but is that a
>> reason to change its meaning?

Manfred> Some hardware drivers use HW_CACHEALIGN and assume certain
Manfred> byte alignments, and arm needs 1024 byte aligned blocks.

Isn't that just a reinvention of SMP_CACHE_BYTES? Or are there
actually machines out there where the inbetween CPU cache line size
differs from the between CPU and DMA controller cache line size?

Jes
