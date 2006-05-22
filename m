Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750952AbWEVTL2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750952AbWEVTL2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 15:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751085AbWEVTL2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 15:11:28 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:898 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1750952AbWEVTL1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 15:11:27 -0400
Date: Mon, 22 May 2006 12:13:46 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: torvalds@osdl.org
Subject: Linux 2.6.16.18
Message-ID: <20060522191346.GR23243@moss.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We (the -stable team) are announcing the release of the 2.6.16.18
kernel.  Fix for possible Netfilter SNMP NAT remote DoS (CVE-2006-2444).

The diffstat and short summary of the fixes are below.

I'll also be replying to this message with a copy of the patch between
2.6.16.17 and 2.6.16.18, as it is small enough to do so.

The updated 2.6.16.y git tree can be found at:
 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.16.y.git
and can be browsed at the normal kernel.org git web browser:
	www.kernel.org/git/

thanks,
-chris

--------

 Makefile                               |    2 +-
 net/ipv4/netfilter/ip_nat_snmp_basic.c |   15 +++++++--------
 2 files changed, 8 insertions(+), 9 deletions(-)

Summary of changes from v2.6.16.17 to v2.6.16.18
================================================

Chris Wright:
      Linux 2.6.16.18

Patrick McHardy:
      NETFILTER: SNMP NAT: fix memory corruption (CVE-2006-2444)

