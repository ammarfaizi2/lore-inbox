Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261971AbTJDK5j (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 06:57:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261982AbTJDK5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 06:57:39 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:28816
	"EHLO velociraptor.random") by vger.kernel.org with ESMTP
	id S261971AbTJDK5h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 06:57:37 -0400
Date: Sat, 4 Oct 2003 12:57:31 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.23pre6aa2
Message-ID: <20031004105731.GA1343@velociraptor.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

URL:

	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.23pre6aa2.gz
	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.23pre6aa2/

Pending things for next releases:

	o libata for SATA
	o UML update

Changelog diff between 2.4.23pre6aa1 and 2.4.23pre6aa2:

Only in 2.4.23pre6aa2: 00_csum-trail-1

	Fixup overflow in p6 checksum routing that crashes sendfile, from
	Andi Kleen. IIRC I found and fixed (though fixed w/o fixmap) this same
	bug too in 1999, but at that time nobody listened about my claim that
	it would eventually crash machines due alignment issues.

Only in 2.4.23pre6aa1: 00_extraversion-30
Only in 2.4.23pre6aa2: 00_extraversion-31

	Rediffed.

Only in 2.4.23pre6aa2: 70_qsort-1
Only in 2.4.23pre6aa1: 71_qsort-1
Only in 2.4.23pre6aa2: 71_xfs-qsort-1

	Allow xfs to compile.

Only in 2.4.23pre6aa1: 91_zone_start_pfn-7
Only in 2.4.23pre6aa2: 91_zone_start_pfn-8

	Fix a NUMA bug introduced by this patch that was crashing my opteron
	desktop. From Andi Kleen.

Only in 2.4.23pre6aa1: 9999_zzz-dynamic-hz-1
Only in 2.4.23pre6aa2: 9999_zzz-dynamic-hz-2

	Fixup two miscompiles reported by Eyal Lebedinsky.

Andrea - If you prefer relying on open source software, check these links:
	    rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.[45]/
	    http://www.cobite.com/cvsps/
