Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261720AbUCKUi0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 15:38:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261712AbUCKUfi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 15:35:38 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:21963 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261673AbUCKUbT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 15:31:19 -0500
Date: Thu, 11 Mar 2004 21:31:09 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.4-mm1: unknown symbols cauased by remove-more-KERNEL_SYSCALLS.patch
Message-ID: <20040311203108.GE14833@fs.tum.de>
References: <20040310233140.3ce99610.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040310233140.3ce99610.akpm@osdl.org>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2004 at 11:31:40PM -0800, Andrew Morton wrote:
>...
> remove-more-KERNEL_SYSCALLS.patch
>   further __KERNEL_SYSCALLS__ removal
>...

This causes the following unknown symbols in modules on i386:

<--  snip  ->

WARNING: 
/lib/modules/2.6.4-mm1/kernel/sound/isa/wavefront/snd-wavefront.ko needs 
unknown symbol sys_read
WARNING: 
/lib/modules/2.6.4-mm1/kernel/sound/isa/wavefront/snd-wavefront.ko needs 
unknown symbol sys_open
WARNING: /lib/modules/2.6.4-mm1/kernel/sound/oss/wavefront.ko needs 
unknown symbol sys_read
WARNING: /lib/modules/2.6.4-mm1/kernel/sound/oss/wavefront.ko needs 
unknown symbol sys_open
WARNING: 
/lib/modules/2.6.4-mm1/kernel/drivers/media/dvb/frontends/tda1004x.ko 
needs unknown symbol sys_lseek
WARNING: 
/lib/modules/2.6.4-mm1/kernel/drivers/media/dvb/frontends/tda1004x.ko 
needs unknown symbol sys_read
WARNING: 
/lib/modules/2.6.4-mm1/kernel/drivers/media/dvb/frontends/tda1004x.ko 
needs unknown symbol sys_open
WARNING: 
/lib/modules/2.6.4-mm1/kernel/drivers/media/dvb/frontends/sp887x.ko 
needs unknown symbol sys_lseek
WARNING: 
/lib/modules/2.6.4-mm1/kernel/drivers/media/dvb/frontends/sp887x.ko 
needs unknown symbol sys_read
WARNING: 
/lib/modules/2.6.4-mm1/kernel/drivers/media/dvb/frontends/sp887x.ko 
needs unknown symbol sys_open
WARNING: 
/lib/modules/2.6.4-mm1/kernel/drivers/media/dvb/frontends/alps_tdlb7.ko 
needs unknown symbol sys_lseek
WARNING: 
/lib/modules/2.6.4-mm1/kernel/drivers/media/dvb/frontends/alps_tdlb7.ko 
needs unknown symbol sys_read
WARNING: 
/lib/modules/2.6.4-mm1/kernel/drivers/media/dvb/frontends/alps_tdlb7.ko 
needs unknown symbol sys_open

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

