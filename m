Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316893AbSE3VXF>; Thu, 30 May 2002 17:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316894AbSE3VXE>; Thu, 30 May 2002 17:23:04 -0400
Received: from [195.39.17.254] ([195.39.17.254]:1950 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S316893AbSE3VXC>;
	Thu, 30 May 2002 17:23:02 -0400
Date: Thu, 30 May 2002 21:59:16 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: linux-kernel@vger.kernel.org, seasons@fornox.hu
Subject: Re: Patch(?): linux-2.5.19 suspend.c compilation fixes, one iffy change
Message-ID: <20020530195914.GA1849@elf.ucw.cz>
In-Reply-To: <200205300318.UAA00301@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> 	kernel/suspend.c no longer compiles in linux-2.5.19, due to
> the elimination of tq_disk.  I infer from the comments on the
> new routine blk_run_queues() and from similar changes elsewhere in
> 2.5.19 that I should probably replace run_task_queue(&tq_disk) with
> blk_run_queues().  I also had to elimiante your sanity check which
> referenced tq_disk.  I will cc this to linux-kernel in case anyone
> else knows the answer and to prevent duplication of effort.
> 
> 	The rest of the changes just address compiler warnings,
> but you might want to look at them anyhow, especially my changing
> the types of suspend_pagedir and pagedir_save from unsigned long
> to suspend_pagedir_t*.
> 
> 	Please let me know if you see a problem with this patch, and
> if you are going to shepherd it to Linus or if you me to submit it
> directly or process it some other way.

Patch is nice, thanx a lot. I'll submit it to Linus.
								Pavel

-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
