Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261473AbULFJfy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261473AbULFJfy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 04:35:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261475AbULFJfy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 04:35:54 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:36565 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261473AbULFJft (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 04:35:49 -0500
Date: Mon, 6 Dec 2004 10:35:18 +0100
From: Jens Axboe <axboe@suse.de>
To: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Time sliced CFQ #2
Message-ID: <20041206093517.GJ10498@suse.de>
References: <20041204104921.GC10449@suse.de> <41B426D4.6080506@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41B426D4.6080506@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06 2004, Prakash K. Cheemplavam wrote:
> Hi,
> 
> this one crapped out on me, while having heavy disk activity. (updating 
>  gentoo portage tree - rebuilding metadata of it). Unfortunately I 
> couldn't save the oops, as I had no hd access anymore and X would freeze 
> a little later...(and I don't want to risk my data a second time...)

Did you save anything at all? Just the function of the EIP would be
better than nothing.
> 
> I think it had to do with preempt, or even preempt big kernel lock, as I 
> could read something about it. I applied your patch to 2.6.10_rc3-ck1. I 
> attached my config, if you want to try yourself with that kernel. cfq2 
> runs w/o probs.

Well hard to say anything qualified without an oops :/

I'll try with PREEMPT here.

-- 
Jens Axboe

