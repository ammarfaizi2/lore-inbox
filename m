Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270803AbTHOTij (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 15:38:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270804AbTHOTij
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 15:38:39 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:57099
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S270803AbTHOTih (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 15:38:37 -0400
Date: Fri, 15 Aug 2003 12:38:34 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Compile problem with CONFIG_X86_CYCLONE_TIMER Re: 2.6.0-test3-mm2
Message-ID: <20030815193834.GL1027@matchmail.com>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20030813013156.49200358.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030813013156.49200358.akpm@osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

arch/i386/kernel/timers/timer_cyclone.c: In function `init_cyclone':
arch/i386/kernel/timers/timer_cyclone.c:157: `FIX_CYCLONE_TIMER' undeclared (first use in this function)
arch/i386/kernel/timers/timer_cyclone.c:157: (Each undeclared identifier is reported only once
arch/i386/kernel/timers/timer_cyclone.c:157: for each function it appears in.)
make[3]: *** [arch/i386/kernel/timers/timer_cyclone.o] Error 1
make[2]: *** [arch/i386/kernel/timers] Error 2
make[1]: *** [arch/i386/kernel] Error 2
make[1]: Leaving directory `/src/linux-2.6.0-test3-mm2'
make: *** [stamp-build] Error 2
Command exited with non-zero status 2
	Command being timed: "fakeroot make-kpkg kernel_image"
	User time (seconds): 61.96
	System time (seconds): 13.53
	Percent of CPU this job got: 76%
	Elapsed (wall clock) time (h:mm:ss or m:ss): 1:38.10
	Average shared text size (kbytes): 0
	Average unshared data size (kbytes): 0
	Average stack size (kbytes): 0
	Average total size (kbytes): 0
	Maximum resident set size (kbytes): 0
	Average resident set size (kbytes): 0
	Major (requiring I/O) page faults: 293436
	Minor (reclaiming a frame) page faults: 143725
	Voluntary context switches: 0
	Involuntary context switches: 0
	Swaps: 0
	File system inputs: 0
	File system outputs: 0
	Socket messages sent: 0
	Socket messages received: 0
	Signals delivered: 0
	Page size (bytes): 4096
	Exit status: 2
