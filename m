Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268316AbUHKXJo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268316AbUHKXJo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 19:09:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268296AbUHKXIX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 19:08:23 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:2773 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S268321AbUHKXCi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 19:02:38 -0400
Date: Thu, 12 Aug 2004 01:02:28 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc4-mm1: legacy_va_layout compile error with SYSCTL=n
Message-ID: <20040811230228.GS26174@fs.tum.de>
References: <20040810002110.4fd8de07.akpm@osdl.org> <20040811221825.GM26174@fs.tum.de> <20040811223353.GT11200@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040811223353.GT11200@holomorphy.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2004 at 03:33:53PM -0700, William Lee Irwin III wrote:
> On Tue, Aug 10, 2004 at 12:21:10AM -0700, Andrew Morton wrote:
> >> sysctl-tunable-for-flexmmap.patch
> >>   sysctl tunable for flexmmap
> 
> On Thu, Aug 12, 2004 at 12:18:25AM +0200, Adrian Bunk wrote:
> > This patch breaks compilation with CONFIG_SYSCTL=n:
> > <--  snip  -->
> > ...
> >   LD      .tmp_vmlinux1
> > arch/i386/mm/built-in.o(.text+0x1cd6): In function `arch_pick_mmap_layout':
> > : undefined reference to `sysctl_legacy_va_layout'
> > make: *** [.tmp_vmlinux1] Error 1
> > <--  snip  -->
> 
> Does this help?
>...

Yes, thanks, it does.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

