Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261355AbVE3ANO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261355AbVE3ANO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 20:13:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261478AbVE3ANO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 20:13:14 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:5392 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261355AbVE3ANK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 20:13:10 -0400
Date: Mon, 30 May 2005 02:13:08 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Bernhard Rosenkraenzer <bero@arklinux.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ALSA Oops in 2.6.12-rc5-mm1
Message-ID: <20050530001308.GH10441@stusta.de>
References: <200505281425.08171.bero@arklinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505281425.08171.bero@arklinux.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 28, 2005 at 02:25:08PM +0200, Bernhard Rosenkraenzer wrote:

> Unable to handle kernel NULL pointer dereference at virtual address 000000a4
>  printing eip:
> e0ead873
> *pde = 00000000
> Oops: 0002 [#1]
>...
> Call Trace:
>  [<c0148c21>] remove_vm_struct+0x63/0x65
>  [<c0149ed6>] do_munmap+0x1cf/0x22c
>  [<c014a759>] sys_munmap+0x49/0x69
>  [<c0102d7f>] sysenter_past_esp+0x54/0x75
>...

Known issue (already reported a dozen times on linux-kernel).

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

