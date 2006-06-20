Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932583AbWFTKOw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932583AbWFTKOw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 06:14:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932584AbWFTKOw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 06:14:52 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:53635 "EHLO
	sequoia.sous-sol.org") by vger.kernel.org with ESMTP
	id S932583AbWFTKOv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 06:14:51 -0400
Date: Tue, 20 Jun 2006 03:13:50 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: torvalds@osdl.org
Subject: Linux 2.6.17.1
Message-ID: <20060620101350.GE23467@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We (the -stable team) are announcing the release of the 2.6.17.1 kernel.

The diffstat and short summary of the fixes are below.

I'll also be replying to this message with a copy of the patch between
2.6.17 and 2.6.17.1, as it is small enough to do so.

The updated 2.6.17.y git tree can be found at:
 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.17.y.git
and can be browsed at the normal kernel.org git web browser:
	www.kernel.org/git/
(note: the main -stable git tree update will lag a half-day or so for this one,
use git://git.kernel.org/pub/scm/linux/kernel/git/chrisw/linux-2.6.17.y.git for
now)

thanks,
-chris

--------

 Makefile                |    2 +-
 net/netfilter/xt_sctp.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Summary of changes from v2.6.17 to v2.6.17.1
================================================

Chris Wright:
      Linux 2.6.17.1

Patrick McHardy:
      xt_sctp: fix endless loop caused by 0 chunk length (CVE-2006-3085)

