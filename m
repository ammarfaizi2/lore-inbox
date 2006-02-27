Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751231AbWB0EL1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751231AbWB0EL1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 23:11:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751252AbWB0EL0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 23:11:26 -0500
Received: from cpe-70-112-167-32.austin.res.rr.com ([70.112.167.32]:53388 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1751231AbWB0EL0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 23:11:26 -0500
To: akpm@osdl.org
Subject: [PATCH 0/3] v9fs: rework fid management
Cc: linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
       ericvh@gmail.com
Message-Id: <20060227041139.A58695A8075@localhost.localdomain>
Date: Sun, 26 Feb 2006 22:11:39 -0600 (CST)
From: ericvh@gmail.com (Eric Van Hensbergen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This set of patches attempts to simplify the mapping of 9P fids to Linux VFS.
The resulting simplification fixes several bugzilla bug-reports with no loss in
functionality for current file systems.  Its a pretty major change, but it has
passed all of our regressions, so its up to you guys whether or not you want to 
accept this into 2.6.16 or wait for the 2.6.17 window to open up.  For what its 
worth, systems seem to be more stable with it than without it.

        -eric

