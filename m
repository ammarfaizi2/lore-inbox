Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262811AbUCJURs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 15:17:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262815AbUCJURs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 15:17:48 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:18395 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262811AbUCJURn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 15:17:43 -0500
Date: Wed, 10 Mar 2004 21:17:37 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, kenneth.w.chen@intel.com,
       thornber@redhat.com
Subject: Re: [PATCH] backing dev unplugging
Message-ID: <20040310201737.GF15087@suse.de>
References: <20040310124507.GU4949@suse.de> <20040310115545.16cb387f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040310115545.16cb387f.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10 2004, Andrew Morton wrote:
> Jens Axboe <axboe@suse.de> wrote:
> >
> > Here's a first cut at killing global plugging of block devices to reduce
> > the nasty contention blk_plug_lock caused. This introduceds per-queue
> > plugging, controlled by the backing_dev_info.
> 
> This is such an improvement over what we have now it isn't funny.

It is pretty scary, once I dove into it...

-- 
Jens Axboe

