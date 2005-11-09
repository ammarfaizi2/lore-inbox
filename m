Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751529AbVKIURe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751529AbVKIURe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 15:17:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161221AbVKIURe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 15:17:34 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:63213 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751529AbVKIURd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 15:17:33 -0500
Date: Wed, 9 Nov 2005 12:17:20 -0800
From: Mike Kravetz <kravetz@us.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Christoph Hellwig <hch@lst.de>, Andrew Morton <akpm@osdl.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ppc64: 64K pages support
Message-ID: <20051109201720.GB5443@w-mikek2.ibm.com>
References: <1130915220.20136.14.camel@gaston> <1130916198.20136.17.camel@gaston> <20051109172125.GA12861@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051109172125.GA12861@lst.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2005 at 06:21:25PM +0100, Christoph Hellwig wrote:
> Booting current mainline with 64K pagesize enabled gives me a purple (!)
> screen early during boot.

I seem to also be having problems with this patch.  My OpenPOWER 720
stopped booting with 2.6.14-git10(and later).  Just using defconfig.
64k page size NOT enabled.  If I back out the 64k page size patch,
2.6.14-git10 boots.  I'm trying to get more info but it is painful.
It dies before xmon is initialized.

I could have sworn that I booted 2.6.14-git7 with the 64k page size
patch applied.  But, I can't do that now either.

Some co-workers have successfully booted other POWER systems with these
kernels.  So, it must be specific to my hardware/LPAR configuration.

-- 
Mike
