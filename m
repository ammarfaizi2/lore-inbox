Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964780AbWEaGK1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964780AbWEaGK1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 02:10:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964793AbWEaGK1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 02:10:27 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:20077 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S964780AbWEaGK0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 02:10:26 -0400
Date: Wed, 31 May 2006 08:12:35 +0200
From: Jens Axboe <axboe@suse.de>
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Cc: linux-kernel@vger.kernel.org, mason@suse.com
Subject: Re: [PATCH] fcache: a remapping boot cache
Message-ID: <20060531061234.GC29535@suse.de>
References: <20060515091806.GA4110@suse.de> <20060515101019.GA4068@suse.de> <20060516074628.GA16317@suse.de> <4d8e3fd30605301438k457f6242x1df64df9bab7f8f1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d8e3fd30605301438k457f6242x1df64df9bab7f8f1@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30 2006, Paolo Ciarrocchi wrote:
> On 5/16/06, Jens Axboe <axboe@suse.de> wrote:
> >On Mon, May 15 2006, Jens Axboe wrote:
> >> On Mon, May 15 2006, Jens Axboe wrote:
> >> > o Trying it on my notebook brought the time from the kernel starts
> >> >   loading to kde has fully auto-logged in down from 50 seconds to 38
> >> >   seconds. The primed boot took 61 seconds. The notebook is about 4
> >> >   months old and the file system is very fresh, so better results 
> >should
> >> >   be seen on more fragmented installs.
> >>
> [...]
> >git://brick.kernel.dk/data/git/linux-2.6-block.git fcache
> 
> Just cloned.
> 
> Any progress on this project Jens?
> 
> I'll try to apply the patch to mainline and post here some numbers.

Well it's a git repo, get it and see :-)
But yes, it's had various fixes and optimizations, it should apply to
latest Linus kernel. There's also a consistency checker here:

git://brick.kernel.dk/data/git/fcache.git

that can check both fcache data and metadata.

-- 
Jens Axboe

