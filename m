Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965105AbWGKEYE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965105AbWGKEYE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 00:24:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965123AbWGKEYD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 00:24:03 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:57021 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965105AbWGKEYC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 00:24:02 -0400
Subject: [Patch 0/6] delay accounting & taskstats fixes
From: Shailabh Nagar <nagar@watson.ibm.com>
Reply-To: nagar@watson.ibm.com
To: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Cc: Jay Lan <jlan@sgi.com>, Chris Sturtivant <csturtiv@sgi.com>,
       Paul Jackson <pj@sgi.com>, Balbir Singh <balbir@in.ibm.com>,
       Chandra Seetharaman <sekharan@us.ibm.com>
Content-Type: text/plain
Organization: IBM
Message-Id: <1152591838.14142.114.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 11 Jul 2006 00:23:58 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Chandra, Balbir & I have been putting taskstats and delay accounting
patches through some extensive testing on multiple platforms.

Following are a set of patches that fix some bugs found as well as
some cleanups of the code. Some results showing the cpumask feature 
works as expected will follow separately.

--Shailabh


Patches against 2.6.18-rc1, apply over the per-task delay accounting
patches already in 2.6.18-rc1-mm1

Series

per-task-delay-accounting-taskstats-interface-exit-data-through-cpumasks-fix2.patch
per-task-delay-accounting-documentation-fix.patch
per-task-delay-accounting-taskstats-fix-early-sem-init.patch
per-task-delay-accounting-taskstats-fix-drop-listener-only-on-socket-close.patch
list_islast.patch
per-task-delay-accounting-taskstats-fix-clone-skbs-for-each-listener.patch


