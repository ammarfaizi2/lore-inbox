Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261706AbVDEMOs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261706AbVDEMOs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 08:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261707AbVDEMOr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 08:14:47 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:25103 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261706AbVDEMOp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 08:14:45 -0400
Date: Tue, 5 Apr 2005 14:14:44 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Reuben Farrelly <reuben-lkml@reub.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc2-mm1
Message-ID: <20050405121444.GB6885@stusta.de>
References: <fa.gcqu6i7.1o6qrhn@ifi.uio.no> <42524D83.1080104@reub.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42524D83.1080104@reub.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2005 at 08:34:11PM +1200, Reuben Farrelly wrote:

> Hi,

Hi Reuben,

>...
> Hrm. Something changed between the last -mm release which compiled 
> through, and this one..
>...
>   LD      .tmp_vmlinux1
> arch/i386/kernel/built-in.o(.init.text+0x1823): In function `setup_arch':
> : undefined reference to `acpi_boot_table_init'
> arch/i386/kernel/built-in.o(.init.text+0x1828): In function `setup_arch':
> : undefined reference to `acpi_boot_init'
> make: *** [.tmp_vmlinux1] Error 1
> [root@tornado linux-2.6]#
> 
> Backing out bk-acpi.patch works around it..

Please send your .config .

> reuben

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

