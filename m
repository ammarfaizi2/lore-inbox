Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964920AbWART1X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964920AbWART1X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 14:27:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964916AbWART1X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 14:27:23 -0500
Received: from smtp.osdl.org ([65.172.181.4]:4992 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964912AbWART1W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 14:27:22 -0500
Date: Wed, 18 Jan 2006 11:27:13 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Nick Piggin <npiggin@suse.de>
cc: Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Andrea Arcangeli <andrea@suse.de>, David Miller <davem@davemloft.net>
Subject: Re: [patch 0/4] mm: de-skew page refcount
In-Reply-To: <20060118170558.GE28418@wotan.suse.de>
Message-ID: <Pine.LNX.4.64.0601181122120.3240@g5.osdl.org>
References: <20060118024106.10241.69438.sendpatchset@linux.site>
 <Pine.LNX.4.64.0601180830520.3240@g5.osdl.org> <20060118170558.GE28418@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 18 Jan 2006, Nick Piggin wrote:
> 
> > So I disagree with this patch series. It has real downsides. There's a 
> > reason we have the offset.
> 
> Yes, there is a reason, I detailed it in the changelog and got rid of it.

And I'm not applying it. I'd be crazy to replace good code by code that is 
objectively _worse_.

The fact that you _document_ that it's worse doesn't make it any better.

The places that you improve (in the other patches) seem to have nothing at 
all to do with the counter skew issue, so I don't see the point.

So let me repeat: WHY DID YOU MAKE THE CODE WORSE?

		Linus
