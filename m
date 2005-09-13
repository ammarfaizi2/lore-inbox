Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964971AbVIMSem@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964971AbVIMSem (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 14:34:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964973AbVIMSem
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 14:34:42 -0400
Received: from ams-iport-1.cisco.com ([144.254.224.140]:53576 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S964971AbVIMSel (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 14:34:41 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: "Read my lips: no more merges" - aka Linux 2.6.14-rc1
X-Message-Flag: Warning: May contain useful information
References: <Pine.LNX.4.58.0509122019560.3351@g5.osdl.org>
From: Roland Dreier <rolandd@cisco.com>
Date: Tue, 13 Sep 2005 11:34:34 -0700
In-Reply-To: <Pine.LNX.4.58.0509122019560.3351@g5.osdl.org> (Linus
 Torvalds's message of "Mon, 12 Sep 2005 20:34:17 -0700 (PDT)")
Message-ID: <52d5nc7r5x.fsf@cisco.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 13 Sep 2005 18:34:36.0076 (UTC) FILETIME=[CAB81EC0:01C5B891]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for being dense, but can you say what "no more merges" means?

At the kernel summit we talked about no more git merges after the
initial devel period, and I'm wondering if that really is the policy.

As a concrete example, suppose I have a git tree with something like

 drivers/infiniband/hw/mthca/mthca_qp.c    |    2 +-
 drivers/infiniband/ulp/ipoib/ipoib_main.c |    2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

ie a couple of really small, simple fixes.  Emailing those to Andrew
as patches is fine by me, but it seems like it creates extra work for
Andrew and you.  So is email via Andrew what you want, or are "bugfix
only" git pulls OK?

Thanks,
  Roland
