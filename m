Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750782AbWC3Wvn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbWC3Wvn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 17:51:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750789AbWC3Wvn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 17:51:43 -0500
Received: from sj-iport-5.cisco.com ([171.68.10.87]:28052 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S1750782AbWC3Wvm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 17:51:42 -0500
X-IronPort-AV: i="4.03,148,1141632000"; 
   d="scan'208"; a="265682214:sNHT29597286"
To: openib-general@openib.org
Cc: linux-kernel@vger.kernel.org
Subject: updated InfiniBand 2.6.17 merge plans
X-Message-Flag: Warning: May contain useful information
References: <ada7j6f8xwi.fsf@cisco.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 30 Mar 2006 14:51:36 -0800
In-Reply-To: <ada7j6f8xwi.fsf@cisco.com> (Roland Dreier's message of "Mon, 27 Mar 2006 11:56:13 -0800")
Message-ID: <ada1wwj1r7r.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 30 Mar 2006 22:51:39.0842 (UTC) FILETIME=[81CA8A20:01C6544C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, here's a quick update on 2.6.17 merge plans:

 * PathScale ipath driver.  In my git tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/roland/infiniband.git ipath

   The new version looks good to me.  I'll merge it unless I hear an
   objection to the latest code.

 * RDMA CM.  In my git tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/roland/infiniband.git rdma_cm

   None of the users of this code look are to merge, and it looks like
   there's some changes in the design happening now.  Seems like this
   can and should wait for 2.6.18.

 * IPoIB tunable ring sizes.  Still no patch yet.

 * SRP FMRs.  I have a patch that I like, but it's not totally stable.
   I may be hitting target bugs (ie in someone else's code).  On the
   other hand I don't have any numbers showing a benefit, so I'm not
   sure if it's worth merging this.

 * (new since last time) Improved static rate handling.  I will get
   this in.

As before, if you care about any of this, let me know what you think.
And if there's something not on this list and not in

    git://git.kernel.org/pub/scm/linux/kernel/git/roland/infiniband.git for-2.6.17

please make sure I know about it, or it won't get merged.

Thanks,
  Roland
