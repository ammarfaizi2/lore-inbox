Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992538AbWKAOu6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992538AbWKAOu6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 09:50:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992539AbWKAOu6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 09:50:58 -0500
Received: from smtp.osdl.org ([65.172.181.4]:14465 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S2992538AbWKAOu6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 09:50:58 -0500
Date: Wed, 1 Nov 2006 06:50:46 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Paul Mackerras <paulus@samba.org>
cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] powerpc: Eliminate "exceeds stub group size" linker
 warning
In-Reply-To: <17735.61916.194247.973705@cargo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.64.0611010647040.25218@g5.osdl.org>
References: <17735.61916.194247.973705@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 1 Nov 2006, Paul Mackerras wrote:
> 
> If you think this is 2.6.19 material, feel free to put it in your
> tree.  Otherwise I'll put it in the powerpc.git tree to go in for
> 2.6.20.

Hmm. I'd love to get rid of the warnings, because they obviously mean that 
I don't look at warnings much at all ("they're all bogus"), but this patch 
must be against some version of arch/powerpc/kernel/head_64.S that I've 
never seen.

That "do_stab_bolted_pSeries" function is in a totally different place for 
me, and the index that git diff mentiones of 47fcff1 doesn't exist in my 
tree (so I've literally never had it).

		Linus
