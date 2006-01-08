Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161160AbWAHDBE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161160AbWAHDBE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 22:01:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161157AbWAHDBE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 22:01:04 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:63104 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1161156AbWAHDBD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 22:01:03 -0500
Date: Sat, 7 Jan 2006 19:04:12 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: torvalds@osdl.org
Subject: Linux 2.6.14.6
Message-ID: <20060108030412.GA3335@sorel.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We (the -stable team) are announcing the release of the 2.6.14.6 kernel.
This flushes the outstanding 2.6.14-stable queue.

The diffstat and short summary of the fixes are below.

I'll also be replying to this message with a copy of the patch between
2.6.14.5 and 2.6.14.6, as it is small enough to do so.

The updated 2.6.14.y git tree can be found at:
 	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/chrisw/linux-2.6.14.y.git
and can be browsed at the normal kernel.org git web browser:
	www.kernel.org/git/

thanks,
-chris

--------


 Makefile                       |    2 -
 drivers/net/sungem.c           |    4 +--
 drivers/video/aty/atyfb_base.c |    2 -
 fs/proc/generic.c              |   47 ++++++++++++++++++++---------------------
 fs/ufs/super.c                 |    4 ++-
 kernel/sysctl.c                |   29 +++++++++++++------------
 net/ieee80211/Kconfig          |    2 -
 7 files changed, 47 insertions(+), 43 deletions(-)

Summary of changes from v2.6.14.5 to v2.6.14.6
==============================================

Adrian Bunk:
      drivers/net/sungem.c: gem_remove_one mustn't be __devexit

Chris Wright:
      Linux 2.6.14.6

Evgeniy Polyakov:
      UFS: inode->i_sem is not released in error path

Linus Torvalds:
      Insanity avoidance in /proc (CVE-2005-4605)
      sysctl: make sure to terminate strings with a NUL

Luis F. Ortiz:
      Fix onboard video on SPARC Blade 100 for 2.6.{13,14,15}

Olaf Hering:
      ieee80211_crypt_tkip depends on NET_RADIO

