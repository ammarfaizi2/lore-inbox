Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161184AbWASDL7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161184AbWASDL7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 22:11:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161187AbWASDL6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 22:11:58 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:41226 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1161185AbWASDL4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 22:11:56 -0500
Date: Thu, 19 Jan 2006 04:11:55 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Mark Maule <maule@sgi.com>,
       Greg Kroah-Hartman <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, tony.luck@intel.com,
       linux-ia64@vger.kernel.org
Subject: 2.6.16-rc1-mm1: ia64 compile error
Message-ID: <20060119031155.GH19398@stusta.de>
References: <20060118005053.118f1abc.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060118005053.118f1abc.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2006 at 12:50:53AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.15-mm4:
>...
> +gregkh-pci-pci-msi-vector-targeting-abstractions.patch
>...
>  PCI tree updates
>...

This patch breaks the ia64 defconfig:

<--  snip  -->

...
  CC      arch/ia64/dig/machvec.o
In file included from arch/ia64/dig/machvec.c:3:
include/asm/machvec_init.h:32: error: 'ia64_msi_init' undeclared here (not in a function)
make[1]: *** [arch/ia64/dig/machvec.o] Error 1

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

