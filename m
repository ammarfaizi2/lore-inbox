Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422670AbWAMOBb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422670AbWAMOBb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 09:01:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422675AbWAMOBa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 09:01:30 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:64010 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1422670AbWAMOBa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 09:01:30 -0500
Date: Fri, 13 Jan 2006 15:01:30 +0100
From: Adrian Bunk <bunk@stusta.de>
To: David Relson <relson@osagesoftware.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem with kernel 2.6.15's build target .tmp_vmlinux1
Message-ID: <20060113140130.GK29663@stusta.de>
References: <20060110193534.09a6031c@osage.osagesoftware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060110193534.09a6031c@osage.osagesoftware.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2006 at 07:35:34PM -0500, David Relson wrote:
> 
> Greetings,

Hi David,

> I've run into a problem building 2.6.15.  Starting with my 2.6.14
> .config file, I ran oldconfig to generate a .config for 2.6.15.
> Running "make" results in:
> 
>       LD      .tmp_vmlinux1
>     kernel/built-in.o: In function `do_exit':
>     : undefined reference to `exit_io_context'
>     mm/built-in.o: In function `generic_write_checks':
>     : undefined reference to `bdev_read_only'
>     mm/built-in.o: In function `__generic_file_aio_write_nolock':
>     : undefined reference to `bdev_read_only'
>     mm/built-in.o: In function `__alloc_pages':
>     : undefined reference to `blk_congestion_wait'
>     mm/built-in.o: In function `__alloc_pages':
>     : undefined reference to `blk_congestion_wait'
>...

please send your .config .

> Regards,
> 
> David
>...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

