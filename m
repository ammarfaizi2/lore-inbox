Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266174AbUFYCtT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266174AbUFYCtT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 22:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266175AbUFYCtT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 22:49:19 -0400
Received: from fw.osdl.org ([65.172.181.6]:53468 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266174AbUFYCtH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 22:49:07 -0400
Date: Thu, 24 Jun 2004 19:47:50 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: wli@holomorphy.com, nickpiggin@yahoo.com.au, tiwai@suse.de, ak@suse.de,
       ak@muc.de, tripperda@nvidia.com, discuss@x86-64.org,
       linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: 32-bit dma allocations on 64-bit platforms
Message-Id: <20040624194750.167a452d.akpm@osdl.org>
In-Reply-To: <20040625023936.GG30687@dualathlon.random>
References: <s5hy8mdgfzj.wl@alsa2.suse.de>
	<20040624152946.GK30687@dualathlon.random>
	<40DAF7DF.9020501@yahoo.com.au>
	<20040624165200.GM30687@dualathlon.random>
	<20040624165629.GG21066@holomorphy.com>
	<20040624145441.181425c8.akpm@osdl.org>
	<20040624220823.GO21066@holomorphy.com>
	<20040624224529.GA30687@dualathlon.random>
	<20040624225121.GS21066@holomorphy.com>
	<20040624160945.69185c46.akpm@osdl.org>
	<20040625023936.GG30687@dualathlon.random>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> On Thu, Jun 24, 2004 at 04:09:45PM -0700, Andrew Morton wrote:
> > this sort of thing, simply because nobody seems to be hitting the problems.
> 
> nobody is hitting the problems because if this problem triggers the
> machine starts slowly swapping and shrinking the vfs and it eventually
> relocate the highmem. the crpilling down of the vfs caches as well isn't
> a good thing and it will not be noticeable by anybody.

Good point, that.


