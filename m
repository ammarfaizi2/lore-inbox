Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750940AbWEaBSQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750940AbWEaBSQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 21:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751237AbWEaBSQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 21:18:16 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:5250 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1750940AbWEaBSP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 21:18:15 -0400
Date: Tue, 30 May 2006 18:20:36 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: torvalds@osdl.org
Subject: Linux 2.6.16.19
Message-ID: <20060531012035.GM18769@moss.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We (the -stable team) are announcing the release of the 2.6.16.19 kernel.
Small fix for information leak with netfilter (CVE-2006-1343).

The diffstat and short summary of the fixes are below.

I'll also be replying to this message with a copy of the patch between
2.6.16.18 and 2.6.16.19, as it is small enough to do so.

The updated 2.6.16.y git tree can be found at:
 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.16.y.git
and can be browsed at the normal kernel.org git web browser:
	www.kernel.org/git/

thanks,
-chris

--------

 Makefile                                       |    2 +-
 net/ipv4/netfilter/ip_conntrack_core.c         |    1 +
 net/ipv4/netfilter/nf_conntrack_l3proto_ipv4.c |    1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

Summary of changes from v2.6.16.18 to v2.6.16.19
================================================

Chris Wright:
      Linux 2.6.16.19

Marcel Holtmann:
      NETFILTER: Fix small information leak in SO_ORIGINAL_DST (CVE-2006-1343)

