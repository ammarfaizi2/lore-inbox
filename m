Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964803AbVIKPPt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964803AbVIKPPt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 11:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964806AbVIKPPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 11:15:49 -0400
Received: from ams-iport-1.cisco.com ([144.254.224.140]:55970 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S964803AbVIKPPt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 11:15:49 -0400
To: Chris Wedgwood <cw@f00f.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [git pull] InfiniBand updates
X-Message-Flag: Warning: May contain useful information
References: <523bocedcb.fsf@cisco.com>
	<20050911030345.GA14593@taniwha.stupidest.org>
From: Roland Dreier <rolandd@cisco.com>
Date: Sun, 11 Sep 2005 08:15:42 -0700
In-Reply-To: <20050911030345.GA14593@taniwha.stupidest.org> (Chris
 Wedgwood's message of "Sat, 10 Sep 2005 20:03:45 -0700")
Message-ID: <52u0grd49t.fsf@cisco.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 11 Sep 2005 15:15:43.0653 (UTC) FILETIME=[AD9D5D50:01C5B6E3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >  include/rdma/ib_cm.h                      |    1
> >  include/rdma/ib_mad.h                     |   21 ++
> >  include/rdma/ib_sa.h                      |   31 +++
> >  include/rdma/ib_user_cm.h                 |   72 +++++++
> >  include/rdma/ib_user_verbs.h              |   21 ++

> Do these really need to be here?  if we really must merge RDMA can we
> not hide these headers in drivers/inifiniband for now?

The includes were moved from drivers/infiniband a few weeks ago for
various good reasons.

I really wish you had replied to the initial RFC
(http://lkml.org/lkml/2005/8/4/191) or the merge where the headers
were actually moved (http://lkml.org/lkml/2005/8/29/105).  I don't
think there's much point in moving the files back now.

 - R.
