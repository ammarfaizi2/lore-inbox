Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932699AbVHSUe1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932699AbVHSUe1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 16:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932704AbVHSUe1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 16:34:27 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:51985 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932699AbVHSUe1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 16:34:27 -0400
Date: Fri, 19 Aug 2005 22:34:24 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.13-rc6-mm1: remove-asm-hdregh.patch problems
Message-ID: <20050819203424.GJ3682@stusta.de>
References: <20050819043331.7bc1f9a9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050819043331.7bc1f9a9.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2005 at 04:33:31AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.13-rc5-mm1:
>...
> +remove-asm-hdregh.patch
> 
>  cleanup
>...

This patch could be improved in two respects:
- it doesn't remove the xtensa hdreg.h
- the "removed" files are only empty since the original files are
  not diffed against /dev/null (or an epoch date)

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

