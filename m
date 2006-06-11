Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750797AbWFKS7B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750797AbWFKS7B (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 14:59:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbWFKS7B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 14:59:01 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:18798 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750797AbWFKS7A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 14:59:00 -0400
Date: Sun, 11 Jun 2006 20:58:55 +0200
From: Jens Axboe <axboe@suse.de>
To: Vishal Patil <vishpat@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: CSCAN vs CFQ I/O scheduler benchmark results
Message-ID: <20060611185854.GF13556@suse.de>
References: <4745278c0606091230g1cff8514vc6ad154acb62e341@mail.gmail.com> <4745278c0606091915n3ed7563do505664c4f8070f81@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4745278c0606091915n3ed7563do505664c4f8070f81@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09 2006, Vishal Patil wrote:
> The machine configuation is as follows
> CPU: Intel(R) Pentium(R) 4 CPU 2.80GHz
> Memory: 1027500 KB (1 GB)
> Filesystem: ext3
> Kernel:   2.6.16.2

You don't mention the storage used, which is quite relevant.

If you have the time, please rerun with 2.6.17-rc6-gitX latest. Although
I'm not sure why you think CSCAN is a good scheduling algorithm, in
general it may be fine but there are trivial non-root 'dos' attacks. Any
of the non-noop Linux io schedulers is a better choice imo.

-- 
Jens Axboe

