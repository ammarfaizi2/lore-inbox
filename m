Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314496AbSD3SbI>; Tue, 30 Apr 2002 14:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314601AbSD3SbH>; Tue, 30 Apr 2002 14:31:07 -0400
Received: from [195.223.140.120] ([195.223.140.120]:43385 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S314496AbSD3SbG>; Tue, 30 Apr 2002 14:31:06 -0400
Date: Tue, 30 Apr 2002 20:31:54 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.19pre7aa3
Message-ID: <20020430203154.B11414@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

URL:

	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19pre7aa3.gz
	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19pre7aa3/

Diff between 2.4.19pre7aa2 and 2.4.19pre7aa3:

Only in 2.4.19pre7aa3: 00_alpha-numa-VALID_PAGE-1

	Fix VALID_PAGE for virt_to_page outside the ram space.
	Bug found by Russell King. Alternate cleaner (but
	more invasive) fix for 2.5 is availabe from Roman Zippel.
	Doesn't worth to change the VALID_PAGE logic in 2.4 IMHO.

Only in 2.4.19pre7aa2: 00_get_pid-no-deadlock-and-boosted-2
Only in 2.4.19pre7aa3: 00_get_pid-no-deadlock-and-boosted-3

	s/set_pid/__set_pid/ noticed by Russell King.

Only in 2.4.19pre7aa3: 00_initrd-free-1

	/dev/root.old is been moved under /old after / is been
	moved to /old. Found and fixed by Michael Schroeder.

Only in 2.4.19pre7aa2: 00_max_bytes-3
Only in 2.4.19pre7aa3: 00_max_bytes-4

	Export symbol so intermezzo can compile.

Only in 2.4.19pre7aa3: 00_pre7ac3-p4-xeon-1

	Recognize p4-xeon. Extracted from the diff between
	2.4.19pre7ac2 and 2.4.19pre7ac3.

Only in 2.4.19pre7aa2: 00_rcu-poll-4
Only in 2.4.19pre7aa3: 00_rcu-poll-5

	Drop a buggy optimization that could lead not to reach the quiescent
	state in the cpu runing rcu_prepare_polling(). From Paul McKenney.
	Harmless bug inside -aa because it's used only in the rmmod path.

Only in 2.4.19pre7aa3: 00_timer_bh-deadlock-1

	Forward port to 2.4 this old longstanding anti deadlock timer fix
	that is been merged in 2.2 ages ago.

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.2/2.2.14/timer_bh-deadlock-3.gz

Only in 2.4.19pre7aa2: 00_vm86-2
Only in 2.4.19pre7aa3: 00_vm86-3

	vm86 updates from 2.4.19pre7ac3.

Only in 2.4.19pre7aa3: 00_wake_up_page-1

	Reintroduced wake_up_page (not deadlock prone anymore), for modules
	that were waking up pages.

Only in 2.4.19pre7aa2: 50_uml-patch-2.4.18-18.gz
Only in 2.4.19pre7aa3: 50_uml-patch-2.4.18-21.gz
Only in 2.4.19pre7aa3: 53_uml-page-struct-updates-1
Only in 2.4.19pre7aa2: 55_uml-page_address-2
Only in 2.4.19pre7aa3: 55_uml-page_address-3

	New version from Jeff at user-mode-linux.sourceforge.net.

Only in 2.4.19pre7aa2: 81_x86_64-arch-4.gz
Only in 2.4.19pre7aa3: 81_x86_64-arch-5.gz
Only in 2.4.19pre7aa2: 85_x86_64-mmx-xmm-init-2
Only in 2.4.19pre7aa3: 85_x86_64-mmx-xmm-init-3
Only in 2.4.19pre7aa2: 87_x86_64-dec_and_lock-2

	Merged latest cvs.x86-64.org CVS updates.

Only in 2.4.19pre7aa2: 91_zone_start_pfn-1
Only in 2.4.19pre7aa3: 91_zone_start_pfn-2

	Avoid some gcc warning while compiling with alpha target.

Andrea
