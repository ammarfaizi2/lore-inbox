Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422671AbVLOJsb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422671AbVLOJsb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 04:48:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422669AbVLOJsb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 04:48:31 -0500
Received: from cantor.suse.de ([195.135.220.2]:54924 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1422671AbVLOJsa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 04:48:30 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rc5-mm3
References: <20051214234016.0112a86e.akpm@osdl.org>
From: Andi Kleen <ak@suse.de>
Date: 15 Dec 2005 10:48:29 +0100
In-Reply-To: <20051214234016.0112a86e.akpm@osdl.org>
Message-ID: <p733bku8zde.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-rc5/2.6.15-rc5-mm3/
> 
> 
> - This kernel requires gcc-3.2.x or later for all architectures.
> 
> - I'll be non-functional from December 16 until January 2.  Will be on email
>   a bit.  Have fun.
> 
> - When reporting any bugs please be extra careful to Cc the appropriate
>   developer and mailing list.
> 
> - I'm not aware of any of the more serious bugs in rc5-mm1 and rc5-mm2
>   being fixed.  If anyone finds that there's a previously-reported problem
>   in here then please just re-report it and don't be afraid to spread the
>   Cc's around.

I have some bad problems on one of my machines (NForce4) with iommu=force and
SLAB_DEBUG - forcedeth seems to corrupt memory badly then.
Also now I managed to get the machine into a state where it would
hang in the SATA driver after boot. Still investigating.

Problem is in rc5 and rc5-git4

-Andi
