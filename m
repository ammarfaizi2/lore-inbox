Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264804AbSJaIb4>; Thu, 31 Oct 2002 03:31:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264784AbSJaIbu>; Thu, 31 Oct 2002 03:31:50 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:13034 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S264807AbSJaIZ4>;
	Thu, 31 Oct 2002 03:25:56 -0500
Date: Thu, 31 Oct 2002 09:32:05 +0100
From: Jens Axboe <axboe@suse.de>
To: Rasmus Andersen <rasmus@jaquet.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CONFIG_TINY
Message-ID: <20021031083205.GC833@suse.de>
References: <20021030233605.A32411@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021030233605.A32411@jaquet.dk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30 2002, Rasmus Andersen wrote:
>  o noswap: Disabling swap by stubbing out all of swapfile.c,
>    swap_stat.c, page_io.c, highmem.c and some of memory.c. 
>    Patch at: www.jaquet.dk/kernel/config_tiny/2.5.44-noswap

You can't stub out all of highmem.c, it's also used for bounce io
(highmem as well as isa for > 16mb adresses)

-- 
Jens Axboe

