Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751248AbWFER6a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248AbWFER6a (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 13:58:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751249AbWFER6a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 13:58:30 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:18305 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1751248AbWFER63
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 13:58:29 -0400
Date: Mon, 5 Jun 2006 11:00:44 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: torvalds@osdl.org
Subject: Linux 2.6.16.20
Message-ID: <20060605180044.GA29676@moss.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We (the -stable team) are announcing the release of the 2.6.16.20 kernel.

The diffstat and short summary of the fixes are below.

I'll also be replying to this message with a copy of the patch between
2.6.16.19 and 2.6.16.20, as it is small enough to do so.

The updated 2.6.16.y git tree can be found at:
 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.16.y.git
and can be browsed at the normal kernel.org git web browser:
	www.kernel.org/git/

thanks,
-chris

--------

 Makefile                                |    2 +-
 arch/powerpc/platforms/powermac/setup.c |   12 ++++++++++++
 arch/x86_64/kernel/entry.S              |    7 +------
 arch/x86_64/kernel/traps.c              |    5 +++++
 drivers/ieee1394/ohci1394.c             |    2 +-
 drivers/ieee1394/sbp2.c                 |   22 +++++++++++++++++++---
 drivers/input/mouse/psmouse-base.c      |    4 +++-
 drivers/net/wireless/ipw2200.c          |   16 ++++++++++++----
 drivers/scsi/libata-core.c              |    1 +
 drivers/sn/ioc3.c                       |    2 +-
 drivers/sn/ioc4.c                       |    2 +-
 mm/page_alloc.c                         |    3 ++-
 12 files changed, 59 insertions(+), 19 deletions(-)

Summary of changes from v2.6.16.19 to v2.6.16.20
================================================

Andi Kleen:
      x86_64: Don't do syscall exit tracing twice

Brent Casavant:
      Altix: correct ioc4 port order

Chris Wright:
      Linux 2.6.16.20

Dmitry Torokhov:
      Input: psmouse - fix new device detection logic

Johannes Berg:
      PowerMac: force only suspend-to-disk to be valid

Mark Lord:
      the latest consensus libata resume fix

Pat Gefre:
      Altix: correct ioc3 port order

Paul Jackson:
      Cpuset: might sleep checking zones allowed fix

Stefan Richter:
      ohci1394, sbp2: fix "scsi_add_device failed" with PL-3507 based devices
      sbp2: backport read_capacity workaround for iPod
      sbp2: fix check of return value of hpsb_allocate_and_register_addrspace

Vivek Goyal:
      x86_64: x86_64 add crashdump trigger points

Zhu Yi:
      ipw2200: Filter unsupported channels out in ad-hoc mode

