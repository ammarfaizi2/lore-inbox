Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261589AbVEYWwd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261589AbVEYWwd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 18:52:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261590AbVEYWwd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 18:52:33 -0400
Received: from mail.dif.dk ([193.138.115.101]:61119 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261589AbVEYWw2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 18:52:28 -0400
Date: Thu, 26 May 2005 00:57:01 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc5-mm1
In-Reply-To: <20050525134933.5c22234a.akpm@osdl.org>
Message-ID: <Pine.LNX.4.62.0505260046350.3382@dragon.hyggekrogen.localhost>
References: <20050525134933.5c22234a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 May 2005, Andrew Morton wrote:

> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc5/2.6.12-rc5-mm1/
> 
[...]
> 
> - Again, if there are patches in here which you think should be merged in
>   2.6.12, please point them out to me.
> 

I'd say the following patches of mine might are candidates : 

atm-nicstar-remove-a-bunch-of-pointless-casts-of-null.patch
cosmetic-fixes-for-example-programs-in-documentation-cdrom-sbpcd.patch
dont-do-pointless-null-checks-and-casts-before-kfree.patch
get-rid-of-redundant-null-checks-before-kfree-in-arch-i386.patch
kfree-cleanups-for-drivers-firmware.patch
kfree-cleanups-in-ixjc.patch
remove-pointless-null-check-before-kfree-in-sony535c.patch
remove-redundant-null-check-before-before-kfree-in.patch
remove-redundant-null-checks-before-kfree-in-sound-and.patch
streamline-preempt_count-type-across-archs.patch
preempt_count-is-int-remove-cast-and-dont-assign-to.patch

They are all quite simple and have not been the cause of any trouble in 
-mm, so we might as well get them merged.


-- 
Jesper Juhl


