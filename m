Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264312AbUEaNXb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264312AbUEaNXb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 09:23:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264386AbUEaNXb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 09:23:31 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:65526 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264312AbUEaNX3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 09:23:29 -0400
Date: Mon, 31 May 2004 15:23:23 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Art <art@artstower.com>
Cc: linux-kernel@vger.kernel.org, dg1kjd@afthd.tu-darmstadt.de
Subject: Re: PROBLEM: kernel module "via-ircc" problem in 2.4.26 but not in 2.6.5
Message-ID: <20040531132323.GP13111@fs.tum.de>
References: <200405240137.58055.art@artstower.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405240137.58055.art@artstower.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2004 at 01:37:58AM +0200, Art wrote:
> 
> [1.] One line summary of the problem:
> The module via-ircc prints error message on 2.4.25 and 2.4.26 kernels but not on 2.6.6-mm4 and vanilla 2.6.5.
> 
> [2.] Full description of the problem/report:
> When I do "insmod via-ircc" I get:
> --start--
> Using /lib/modules/2.4.25-gentoo-r2/kernel/drivers/net/irda/via-ircc.o
> /lib/modules/2.4.25-gentoo-r2/kernel/drivers/net/irda/via-ircc.o: /lib/modules/2.4.25-gentoo-r2/kernel/drivers/net/irda/via-ircc.o: unresolved symbol irlap_open_R1698cb30
>...
> [4.] Kernel version (from /proc/version):
> Linux version 2.4.25-gentoo-r2 (root@xmobile) (gcc version 3.3.3 20040412 (Gentoo Linux 3.3.3-r5, ssp-3.3-7, pie-8.7.5.3)) #1 Sun May 23 21:37:29 CEST 2004
>...

Does it work in a ftp.kernel.org 2.4.26 kernel?

If yes, please send your .config .

If no, please report it to your distribution (Gentoo) instead.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

