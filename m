Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271728AbTGRGiT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 02:38:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271729AbTGRGiT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 02:38:19 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:41386 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S271728AbTGRGiS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 02:38:18 -0400
Date: Fri, 18 Jul 2003 08:53:05 +0200
From: Jens Axboe <axboe@suse.de>
To: "Miller, Mike (OS Dev)" <mike.miller@hp.com>
Cc: marcelo@conectiva.com.br, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org, "Harris, Fred" <fred.harris@hp.com>
Subject: Re: cciss updates for 2.4.22-pre6
Message-ID: <20030718065305.GU833@suse.de>
References: <D4CFB69C345C394284E4B78B876C1CF104052A8B@cceexc23.americas.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D4CFB69C345C394284E4B78B876C1CF104052A8B@cceexc23.americas.cpqcorp.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 17 2003, Miller, Mike (OS Dev) wrote:
> Here's another round of patches for the HP cciss driver in the attached tarball. These patches are intended for inclusion in the 2.4.22 kernel. This tarball contains 3 patches that should be applied in this order:
> 	1. cciss_2447_author_change.patch
> 	2. cciss_2447_shirq_fix2.patch
> 	3. cciss_2447_lock_fix.patch
> The first patch is a requirement from our legal types & management, the other 2 are bug fixes.
> Full comments & desciptions are in the patch files.
> 
> There will be more patches in the next few days. They will include:
> 	1. Failover support for multipath environments.
> 	2. devfs support.
> 	3. Support for more than 8 controllers.
> 
> Any feedback is greatly appreciated.

The shirq patch looks a bit suspect, don't you need at least a barrier
there? Also I'm curious what the problems are wrt the lock_fix?

-- 
Jens Axboe

