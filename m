Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314227AbSFGAeV>; Thu, 6 Jun 2002 20:34:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314707AbSFGAeV>; Thu, 6 Jun 2002 20:34:21 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:8037 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S314227AbSFGAeU>; Thu, 6 Jun 2002 20:34:20 -0400
Date: Fri, 7 Jun 2002 02:34:13 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.19pre10aa1
Message-ID: <20020607003413.GH1004@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

URL:

	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19pre10aa1.gz
	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19pre10aa1/

Diff:

Only in 2.4.19pre9aa2: 00_8253-1
Only in 2.4.19pre9aa2: 00_ipc-sem-set-pid-during-setval-1
Only in 2.4.19pre9aa2: 00_proc-sig-race-fix-1
Only in 2.4.19pre9aa2: 00_reaper-thread-race-1
Only in 2.4.19pre9aa2: 00_tty-poll-2
Only in 2.4.19pre9aa2: 00_wmem-default-lowmem-machines-1

	Merged in mainline.

Only in 2.4.19pre10aa1: 00_apm-idle_period-parse-1

	Bugfix from -ac.

Only in 2.4.19pre9aa2: 60_tux-kstat-4
Only in 2.4.19pre10aa1: 60_tux-kstat-5
Only in 2.4.19pre9aa2: 00_lowlatency-fixes-5
Only in 2.4.19pre10aa1: 00_lowlatency-fixes-6

	Rediffed.

Only in 2.4.19pre10aa1: 05_vm_19_nodev-cleanup-1

	Minor cleanup.

Only in 2.4.19pre9aa2: 10_o1-sched-fixes-1
Only in 2.4.19pre10aa1: 10_o1-sched-fixes-2

	Cleanup, dropped "flags" leftover.

Only in 2.4.19pre9aa2: 10_rawio-vary-io-8
Only in 2.4.19pre10aa1: 10_rawio-vary-io-9

	J.A. Magallon noticed the conditiona_schedule got dropped from
	submit_bh, this opens a small room for further dbench and the like
	improvements.

Only in 2.4.19pre10aa1: 20_keventd-rt-1

	Make keventd RT (use MAX_USER_RT_PRIO). this way keventd can
	be used for critical system activities. Still can be starved
	by SCHED_FIFO.

Only in 2.4.19pre10aa1: 50_uml-patch-2.4.18-31.gz

	Upgrade to uml-31 from Jeff.

Only in 2.4.19pre10aa1: 90_ext3-commit-interval-1

	Avoid laptops to waste energy despite kupdate interval is set
	to 2 hours with ext3. kjournald has no right to choose
	"how frequently" we should look for old transactions, that's
	an user problem. journaling doesn't enforce how much old data
	we can lose after a 'reboot -f', it only enforces that the
	metadata or even the data will be coherent after an hard reboot. 

Andrea
