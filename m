Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265803AbUBBSjy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 13:39:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265832AbUBBSjy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 13:39:54 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:49111 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265803AbUBBSjw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 13:39:52 -0500
Date: Mon, 2 Feb 2004 19:39:44 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.2-rc3-tiny1 for small systems
Message-ID: <20040202183944.GB3177@fs.tum.de>
References: <20040201052348.GW21888@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040201052348.GW21888@waste.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 31, 2004 at 11:23:48PM -0600, Matt Mackall wrote:
>...

The patch contains 3 .orig files that could be removed:
linux-2.6.2-rc3/arch/i386/boot/compressed/misc.c.orig
linux-2.6.2-rc3/arch/i386/mm/init.c.orig
linux-2.6.2-rc3/fs/proc/proc_misc.c.orig

> Latest release includes:
>...
>  - enhanced CPU feature selection (Adrian Bunk)
>...

You could kill all the CPU_SUP_* options with my CPU selection scheme.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

