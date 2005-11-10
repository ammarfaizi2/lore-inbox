Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750919AbVKJOBp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750919AbVKJOBp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 09:01:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750916AbVKJOBo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 09:01:44 -0500
Received: from ns2.suse.de ([195.135.220.15]:32450 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750903AbVKJOBc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 09:01:32 -0500
From: Andi Kleen <ak@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Subject: Re: [PATCH 09/15] mm: fill arch atomic64 gaps
Date: Thu, 10 Nov 2005 14:38:39 +0100
User-Agent: KMail/1.8
Cc: Andrew Morton <akpm@osdl.org>, Richard Henderson <rth@twiddle.net>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.61.0511100139550.5814@goblin.wat.veritas.com> <Pine.LNX.4.61.0511100153350.5814@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0511100153350.5814@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511101438.39768.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 10 November 2005 02:56, Hugh Dickins wrote:
> alpha, s390, sparc64, x86_64 are each missing some primitives from their
> atomic64 support: fill in the gaps I've noticed by extrapolating asm,
> follow the groupings in each file, and say "int" for the booleans rather
> than long or long long.  But powerpc and parisc still have no atomic64.

x86-64 part looks ok thanks. I assume you will take care of the merge
or do you want me to take that hunk?

-Andi
