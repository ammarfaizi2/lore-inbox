Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270414AbTGSBRe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 21:17:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270439AbTGSBRe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 21:17:34 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:45698
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S270414AbTGSBRc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 21:17:32 -0400
Date: Sat, 19 Jul 2003 03:32:23 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.22pre7aa1
Message-ID: <20030719013223.GA31330@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

URL:

	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.22pre7aa1.bz2
	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.22pre7aa1/

changelog diff between 2.4.22pre6aa2 and 2.4.22pre7aa1:

Only in 2.4.22pre6aa2: 00_elevator-read-reservation-axboe-2l-1
Only in 2.4.22pre6aa2: 00_fdatasync-cleanup-1

	Merged in mainline.

Only in 2.4.22pre6aa2: 70_vmap-1

	Merged in mainline (with a different API).

Only in 2.4.22pre6aa2: 00_extraversion-27
Only in 2.4.22pre7aa1: 00_extraversion-28
Only in 2.4.22pre6aa2: 00_sched-O1-aa-2.4.19rc3-14.gz
Only in 2.4.22pre7aa1: 00_sched-O1-aa-2.4.19rc3-15.gz
Only in 2.4.22pre6aa2: 20_numa-mm-6
Only in 2.4.22pre7aa1: 20_numa-mm-7
Only in 2.4.22pre6aa2: 20_pte-highmem-30.gz
Only in 2.4.22pre7aa1: 20_pte-highmem-31.gz
Only in 2.4.22pre6aa2: 21_ppc64-aa-2
Only in 2.4.22pre7aa1: 21_ppc64-aa-3

	Rediffed.

Only in 2.4.22pre6aa2: 60_net-exports-2
Only in 2.4.22pre7aa1: 60_net-exports-3

	One of the exports is in mainline (sockfd_lookup).

Only in 2.4.22pre6aa2: 70_xfs-exports-2
Only in 2.4.22pre7aa1: 70_xfs-exports-3

	One of the exports is in mainline.

Only in 2.4.22pre7aa1: 72_22pre7-broke-the-vmap-api-1

	Adapt xfs to the slightly different vmap API in 22pre7.

Only in 2.4.22pre6aa2: 9999900_drm-4.3-1.gz

	No matter how I configure the kernel, I lose the direct
	rendering with this patch. Tried with DRM 4.1/4.3/4.0,
	it never works (and I don't have time for more tests for this right
	now as I'm leaving for the KS in around 5 hours). Not that I use 3d
	frequently but I postponed it for now, until I get more feedback. The
	patch is still in the 2.4.22pre6aa2 directory and it can be applied on
	top of 2.4.22pre7aa1 trivially to test. One detail is that I link
	everything into the kernel, especially on my test boxes I never use
	modules.  As soon as this mistery is solved I can add it back.

Only in 2.4.22pre6aa2: 9999900_ecc-20020904-2.gz
Only in 2.4.22pre7aa1: 9999900_ecc-20030225-1.gz

	Fixup some incorrect diffing (s/p0/p1) and renamed to the right date.

Andrea
