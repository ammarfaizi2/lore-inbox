Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262049AbTH3TQP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 15:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262046AbTH3TQP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 15:16:15 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:17873 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S262049AbTH3TQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 15:16:08 -0400
Date: Sat, 30 Aug 2003 16:11:49 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Andrea Arcangeli <andrea@suse.de>, Mike Fedyk <mfedyk@matchmail.com>,
       Antonio Vargas <wind@cocodriloo.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>
Subject: Re: Andrea VM changes
In-Reply-To: <Pine.LNX.4.55L.0308301248380.31588@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.55L.0308301607540.31588@freak.distro.conectiva>
References: <Pine.LNX.4.55L.0308301248380.31588@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 30 Aug 2003, Marcelo Tosatti wrote:

>
> > that's true for only one patch, the others are pretty orthogonal after
> > Andrew helped splitting them:
> > 05_vm_03_vm_tunables-4
> > 05_vm_05_zone_accounting-2
> > 05_vm_06_swap_out-3
> > 05_vm_07_local_pages-4
> > 05_vm_08_try_to_free_pages_nozone-4
> > 05_vm_09_misc_junk-3
> > 05_vm_10_read_write_tweaks-3
> > 05_vm_13_activate_page_cleanup-1
> > 05_vm_15_active_page_swapout-1
> > 05_vm_16_active_free_zone_bhs-1
> > 05_vm_17_rest-10
> > 05_vm_18_buffer-page-uptodate-1
> > 05_vm_20_cleanups-3
> > 05_vm_21_rt-alloc-1
> > 05_vm_22_vm-anon-lru-1
> > 05_vm_23_per-cpu-pages-3
> > 05_vm_24_accessed-ipi-only-smp-1
> > 05_vm_25_try_to_free_buffers-invariant-1
>
> Indeed, you are right.
>
> I'll start looking at them Monday. I'll keep you in touch. Thanks.

Andrea,

Would you mind to explain me 05_vm_06_swap_out-3 ?

I see you change shrink_cache, try_to_free_pages_zone, etc.

Can you please give me a detailed explanation of the changes there?

I appreciate very much.

I'll keep looking at other patches for now.

Thanks
