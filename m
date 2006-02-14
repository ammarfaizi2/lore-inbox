Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161081AbWBNP0X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161081AbWBNP0X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 10:26:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161085AbWBNP0X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 10:26:23 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:58644 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1161081AbWBNP0W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 10:26:22 -0500
Date: Tue, 14 Feb 2006 16:23:07 +0100
From: Jens Axboe <axboe@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [-mm patch] block/blktrace.c: make blk_trace_cleanup() static
Message-ID: <20060214152306.GX4203@suse.de>
References: <20060214014157.59af972f.akpm@osdl.org> <20060214152209.GG10701@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060214152209.GG10701@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14 2006, Adrian Bunk wrote:
> On Tue, Feb 14, 2006 at 01:41:57AM -0800, Andrew Morton wrote:
> >...
> > Changes since 2.6.16-rc2-mm1:
> >...
> >  git-blktrace.patch
> >...
> 
> 
> blk_trace_cleanup() is needlessly global.

Thanks applied, it was a leftover when the stop/start changes were
introduced.

-- 
Jens Axboe

