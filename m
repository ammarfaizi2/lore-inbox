Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964930AbWBGBe6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964930AbWBGBe6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 20:34:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964928AbWBGBe6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 20:34:58 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:27522 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S964925AbWBGBe5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 20:34:57 -0500
Date: Mon, 6 Feb 2006 17:41:22 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: torvalds@osdl.org
Subject: Linux 2.6.15.3
Message-ID: <20060207014122.GC4483@sorel.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We (the -stable team) are announcing the release of the 2.6.15.3 kernel.
This contains a single security fix (CVE-2006-0454) which can potentially
be used as remote DoS exploit.

The diffstat and short summary of the fixes are below.

I'll also be replying to this message with a copy of the patch between
2.6.15.2 and 2.6.15.3, as it is small enough to do so.

The updated 2.6.15.y git tree can be found at:
 	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/chrisw/linux-2.6.15.y.git
and can be browsed at the normal kernel.org git web browser:
	www.kernel.org/git/

thanks,
-chris

--------

 Makefile        |    2 +-
 net/ipv4/icmp.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Summary of changes from v2.6.15.2 to v2.6.15.3
==============================================

Chris Wright:
      Linux 2.6.15.3

Herbert Xu:
      Fix extra dst release when ip_options_echo fails

