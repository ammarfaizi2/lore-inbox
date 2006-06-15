Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932444AbWFOGVZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932444AbWFOGVZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 02:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932446AbWFOGVZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 02:21:25 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:35499 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932444AbWFOGVY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 02:21:24 -0400
Date: Thu, 15 Jun 2006 16:21:07 +1000
From: Nathan Scott <nathans@sgi.com>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cfq_update_io_seektime oops
Message-ID: <20060615162107.B898607@wobbly.melbourne.sgi.com>
References: <20060615152131.A898607@wobbly.melbourne.sgi.com> <20060615060152.GK1522@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20060615060152.GK1522@suse.de>; from axboe@suse.de on Thu, Jun 15, 2006 at 08:01:53AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2006 at 08:01:53AM +0200, Jens Axboe wrote:
> The patch for this was just merged in 2.6.17-rc6-git last night, so it

Ah, great - thanks.

> should be fine now. Just curious - did you have any slab debugging
> features enabled?

Hmm, lemme see - no, not slab for this particular build - here's
my CONFIG_DEBUG_* list:

CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_SLAB is not set
CONFIG_DEBUG_MUTEXES=y
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
# CONFIG_DEBUG_INFO is not set
CONFIG_DEBUG_FS=y
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_DEBUG_RODATA is not set

cheers.

-- 
Nathan
