Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267759AbUIKI2p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267759AbUIKI2p (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 04:28:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267760AbUIKI2p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 04:28:45 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:37613 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S267759AbUIKI2o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 04:28:44 -0400
Date: Sat, 11 Sep 2004 01:28:08 -0700 (PDT)
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Simon Derr <Simon.Derr@bull.net>, Paul Jackson <pj@sgi.com>,
       linux-kernel@vger.kernel.org
Message-Id: <20040911082810.10372.86008.84920@sam.engr.sgi.com>
Subject: [Patch 0/4] four small cpuset patches ...
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are four small patches that I would like included in the
cpuset patches in *-mm.  Simon Derr has reviewed them and found
them reasonable.  I have built, booted and unit tested them.

They are:
 1) Add cpus_allowed, mems_allowed to /proc/<pid>/status
 2) Simplify recalculation of new cpus_allowed when task changes cpuset
 3) Remove a bit of slightly broken, completely useless, code
 4) Tweak top cpuset to have just online, not all possible, cpus and nodes.


-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
