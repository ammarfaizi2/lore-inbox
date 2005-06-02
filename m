Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261384AbVFBMGw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261384AbVFBMGw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 08:06:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261386AbVFBMGw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 08:06:52 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:35340 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261384AbVFBMGu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 08:06:50 -0400
Date: Thu, 2 Jun 2005 14:06:47 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@tux.tmfweb.nl
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc5-mm1 Oops
Message-ID: <20050602120647.GD4992@stusta.de>
References: <20050601181231.GA4836@nospam.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050601181231.GA4836@nospam.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2005 at 08:12:31PM +0200, Rutger Nijlunsing wrote:
>...
> Call Trace:
>  [<c0103e3a>] show_stack+0x7a/0x90
>  [<c0103fc2>] show_registers+0x152/0x1c0
>  [<c01041d9>] die+0xf9/0x190
>  [<c0115f2f>] do_page_fault+0x32f/0x67a
>  [<c0103a83>] error_code+0x4f/0x54
>  [<c0152545>] remove_vm_struct+0x85/0x90
>  [<c0153c79>] unmap_vma+0x59/0x60
>  [<c0153c9a>] unmap_vma_list+0x1a/0x30
>  [<c0154047>] do_munmap+0xe7/0x120
>  [<c01540c9>] sys_munmap+0x49/0x70
>  [<c0102f49>] syscall_call+0x7/0xb
>...

Known bug, already reported at about a dozen times, already fixed
in -mm2.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

