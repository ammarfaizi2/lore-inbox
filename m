Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932159AbVHMMk6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159AbVHMMk6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Aug 2005 08:40:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932161AbVHMMk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Aug 2005 08:40:57 -0400
Received: from ns1.suse.de ([195.135.220.2]:19633 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932159AbVHMMk5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Aug 2005 08:40:57 -0400
Date: Sat, 13 Aug 2005 14:40:52 +0200
From: Andi Kleen <ak@suse.de>
To: Ingo Oeser <ioe-lkml@rameria.de>
Cc: Andi Kleen <ak@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, hugh@veritas.com
Subject: Re: [PATCH] Fix mmap_kmem (was: [question] What's the difference  between /dev/kmem and /dev/mem)
Message-ID: <20050813124052.GO22901@wotan.suse.de>
References: <1123796188.17269.127.camel@localhost.localdomain.suse.lists.linux.kernel> <Pine.LNX.4.58.0508120930150.3295@g5.osdl.org.suse.lists.linux.kernel> <p73br432izq.fsf@verdi.suse.de> <200508131156.28553.ioe-lkml@rameria.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508131156.28553.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Perfect! So it should be under CONFIG_DEBUG_KERNEL and default to off.
> 
> So you can still debug and we raise the bar higher for rootkits, 
> if they are the only other user.
> 
> Too simple?

If you wanted to recompile your kernel to debug you could as well
add printks. But the whole point of kmem hacks is to avoid that
slow cycle.

-Andi
