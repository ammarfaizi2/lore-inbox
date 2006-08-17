Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030243AbWHQUKA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030243AbWHQUKA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 16:10:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030245AbWHQUJh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 16:09:37 -0400
Received: from sj-iport-1-in.cisco.com ([171.71.176.70]:7266 "EHLO
	sj-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1030243AbWHQUJc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 16:09:32 -0400
Cc: schihei@de.ibm.com, RAISCH@de.ibm.com, HNGUYEN@de.ibm.com,
       MEDER@de.ibm.com
Subject: [PATCH 00/16] IB/ehca: introduction
In-Reply-To: 
X-Mailer: Roland's Patchbomber
Date: Thu, 17 Aug 2006 13:09:27 -0700
Message-Id: <2006817139.43eVtRoa2IK8yOPl@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: openib-general@openib.org, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <rolandd@cisco.com>
X-OriginalArrivalTime: 17 Aug 2006 20:09:29.0783 (UTC) FILETIME=[0C0E5C70:01C6C239]
Authentication-Results: sj-dkim-2.cisco.com; header.From=rolandd@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a series of patches (split up rather arbitrarily to avoid
too-big emails) which adds a driver for the IBM eHCA InfiniBand
adapter.  The driver has been around for a while, and my feeling is
that it is good enough to merge, even though it could certainly use
some cleaning up.  However, my feeling is that we don't need to wait
for this driver to be perfect before merging it, and that it would be
better for everyone if it gets into mainline (eg coordination with
Anton's hcall cleanup becomes simpler).

Please review and comment, and do let me know if you disagree with my
decision to merge this for 2.6.19.  (BTW, just to be clear -- I'll
collapse this driver into a single git commit with full changelog and
Signed-off-by: lines before actually merging it -- the bare patches
are just for review)

The driver is also available in git for your reviewing pleasure at

    git://git.kernel.org/pub/scm/linux/kernel/git/roland/infiniband.git ehca

The developers of the driver are cc'ed on this thread and should
respond to any comments.

Thanks,
  Roland
