Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261961AbVDCX5c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261961AbVDCX5c (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 19:57:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261817AbVDCX5b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 19:57:31 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:50441 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261961AbVDCX52 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 19:57:28 -0400
Date: Mon, 4 Apr 2005 01:57:26 +0200
From: Adrian Bunk <bunk@stusta.de>
To: techno@punkt.pl
Cc: linux-kernel@vger.kernel.org
Subject: Re: [SCSI] Driver broken in 2.6.x?
Message-ID: <20050403235726.GE3953@stusta.de>
References: <424EB65A.8010600@punkt.pl> <Pine.LNX.4.62.0504022301430.2525@dragon.hyggekrogen.localhost> <424F0BFF.6020402@punkt.pl> <Pine.LNX.4.62.0504022322150.2525@dragon.hyggekrogen.localhost> <42502EB2.3080802@punkt.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42502EB2.3080802@punkt.pl>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 03, 2005 at 07:58:10PM +0200, |TEcHNO| wrote:
> Hi,
> 
> As told, I tested it w/o nvidia module loaded, here's what I found:
> 1. It now doesn't hang on scanning for devices.
> 2. It now hangs on acquiring preview, logs will follow.
>...
> Apr  3 15:54:27 techno kernel: Unable to handle kernel NULL pointer
> dereference at virtual address 0000014c
> Apr  3 15:54:27 techno kernel:  printing eip:
> Apr  3 15:54:27 techno kernel: c03d8143
> Apr  3 15:54:27 techno kernel: *pde = 00000000
> Apr  3 15:54:27 techno kernel: Oops: 0000 [#1]
> Apr  3 15:54:27 techno kernel: PREEMPT
> Apr  3 15:54:27 techno kernel: Modules linked in: nvidia
>...

Still with nvidia.

An Oops with the nvidia module loaded since the last boot is simply not 
debuggable for anyone except nvidia.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

