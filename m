Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261513AbVGMRMP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261513AbVGMRMP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 13:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261584AbVGMRJ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 13:09:29 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:39810 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261513AbVGMRHx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 13:07:53 -0400
Date: Wed, 13 Jul 2005 03:47:08 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: linux-kernel@vger.kernel.org, randy_dunlap <rdunlap@xenotime.net>
Subject: CP-Miner: A Tool for Finding Copy-paste and Related Bugs in Operating System Code
Message-ID: <20050713064708.GA5988@dmt.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


FYI, CP-Miner has binary-only version has been released
for academic use.

http://opera.cs.uiuc.edu/Projects/ARTS/CP-Miner.htm

By Zhenmin Li, Shan Lu, Suvda Myagmar and Yuanyuan Zhou

Published in Proceedings of the Sixth Symposium on Operating System Design
and Implementation (OSDI'04), Dec. 2004

Copy-pasted code is very common in large software because programmers
prefer reusing code via copy-paste in order to reduce programming effort.
Copy-paste is prone to introducing bugs. Recent studies show that a
significant portion of operating system bugs concentrate in copy-pasted
code. Unfortunately, it is very challenging to efficiently identify
copy-pasted code in large software. Existing copy-paste detection tools are
either not scalable to large software, or cannot handle small modifications
in copy-paste. Furthermore, few tools are available to detect copy-paste
related bugs.

In this paper, we propose a tool, called CP-Miner, that uses data mining
techniques to efficiently identify copy-pasted code in large software
including operating systems, and detect copy-paste related bugs.
Specifically, it takes less than 20 minutes for CP-Miner to identify
190,000 and 150,000 copy-pasted segments in Linux and FreeBSD,
respectively. The copy-pasted code accounts for 20-22% of code in Linux and
FreeBSD. Similarly, CP-Miner also identifies many copy-pasted segments in
the Apache Web Server and PostgresSQL, which account for 17.7-22% of code
in these software.

Moreover, CP-Miner has detected 49 and 31 copy-paste related bugs in the
latest versions of Linux and FreeBSD, respectively. Some of these bugs have
been reported by us to the open source community and are then  fixed by the
developers.


