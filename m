Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261921AbTH3PmQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 11:42:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261946AbTH3PmP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 11:42:15 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:37526
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261921AbTH3Pl1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 11:41:27 -0400
Date: Sat, 30 Aug 2003 17:41:37 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Mike Fedyk <mfedyk@matchmail.com>, Antonio Vargas <wind@cocodriloo.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>
Subject: Re: Andrea VM changes
Message-ID: <20030830154137.GK24409@dualathlon.random>
References: <Pine.LNX.4.55L.0308301209500.31588@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55L.0308301209500.31588@freak.distro.conectiva>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 30, 2003 at 12:13:57PM -0300, Marcelo Tosatti wrote:
> 
> > You need to integrate with -aa on the VM.  It has been hard enough for
> > Andrea to get his stuff in, I doubt you will fair any better.
> 
> Thats because I never received separate patches which make sense one by
> one.  Most of Andreas changes are all grouped into few big patches that
> only he knows the mess. That is not the way to merge things.
> 
> I want to work out with him after I merge other stuff to address that.

that's true for only one patch, the others are pretty orthogonal after
Andrew helped splitting them:


05_vm_03_vm_tunables-4
05_vm_05_zone_accounting-2
05_vm_06_swap_out-3
05_vm_07_local_pages-4
05_vm_08_try_to_free_pages_nozone-4
05_vm_09_misc_junk-3
05_vm_10_read_write_tweaks-3
05_vm_13_activate_page_cleanup-1
05_vm_15_active_page_swapout-1
05_vm_16_active_free_zone_bhs-1
05_vm_17_rest-10
05_vm_18_buffer-page-uptodate-1
05_vm_20_cleanups-3
05_vm_21_rt-alloc-1
05_vm_22_vm-anon-lru-1
05_vm_23_per-cpu-pages-3
05_vm_24_accessed-ipi-only-smp-1
05_vm_25_try_to_free_buffers-invariant-1

The "mess" one is only 05_vm_17_rest-10 as far as I can tell.

Andrea
