Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964836AbWF3SQk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964836AbWF3SQk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 14:16:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964825AbWF3SQk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 14:16:40 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:1665 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S964836AbWF3SQj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 14:16:39 -0400
Date: Fri, 30 Jun 2006 11:15:53 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: torvalds@osdl.org
Subject: Linux 2.6.17.3
Message-ID: <20060630181553.GN11588@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We (the -stable team) are announcing the release of the 2.6.17.3 kernel.
Another SCTP remote crash fix, CVE-2006-2934.

I'll also be replying to this message with a copy of the patch between
2.6.17.2 and 2.6.17.3, as it is small enough to do so.

The updated 2.6.17.y git tree can be found at:
 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.17.y.git
and can be browsed at the normal kernel.org git web browser:
	www.kernel.org/git/

thanks,
-chris

--------

 Makefile                                     |    2 +-
 net/ipv4/netfilter/ip_conntrack_proto_sctp.c |    2 +-
 net/netfilter/nf_conntrack_proto_sctp.c      |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

Summary of changes from v2.6.17.2 to v2.6.17.3
================================================

Chris Wright:
      Linux 2.6.17.3

Patrick McHardy:
      NETFILTER: SCTP conntrack: fix crash triggered by packet without chunks [CVE-2006-2934]

