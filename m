Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263093AbUDEEsv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 00:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263098AbUDEEsv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 00:48:51 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:38276
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263093AbUDEEss (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 00:48:48 -0400
Date: Mon, 5 Apr 2004 06:48:51 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.6.5-aa3
Message-ID: <20040405044851.GC2234@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

this got high prio to release due the prio-tree fixes from Rajesh, not
that I ever triggered those bugs but they could hurt in theory. I feel
things will settle down on the VM side from now on (at least in the
objrmap/prio-tree/anon-vma area ;).

I tried giving a spin to the 2.6.5-mc1.bz2 patch from Andrew but it
apparently rejects heavily against 2.6.5.

URL:

	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.6/2.6.5-aa3.gz
	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.6/2.6.5-aa3/

Changelog diff between 2.6.5-aa2 and 2.6.5-aa3:

Files 2.6.5-aa2/extraversion and 2.6.5-aa3/extraversion differ

	Rediffed.

Only in 2.6.5-aa3: kthread-stop-smp-race

	Fix smp race.

Files 2.6.5-aa2/prio-tree.gz and 2.6.5-aa3/prio-tree.gz differ

	Merge Rajesh Venkatasubramanian's prio-tree internal data structure
	updates to fix some bug in very rare corner case. He posted the
	userspace simulator for the data structure too.

	http://www-personal.engin.umich.edu/~vrajesh/linux/prio_tree/user_space/
