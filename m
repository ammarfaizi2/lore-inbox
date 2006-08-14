Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932309AbWHNRlz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932309AbWHNRlz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 13:41:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932321AbWHNRlz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 13:41:55 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:54709 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S932309AbWHNRlz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 13:41:55 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Mon, 14 Aug 2006 19:40:23 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 2.6.18-rc4-mm1 0/8] ieee1394: fixes and touch-ups for sbp2
To: linux1394-devel@lists.sourceforge.net
cc: Ben Collins <bcollins@ubuntu.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Message-ID: <tkrat.9b22090d7dd50b12@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are 5 bug fixes for sbp2, 2 code updates, 1 Kconfig improvement.
If nothing gets in the way I will probably resend some of these fixes
and one or two which are already in -mm for proposed inclusion into
2.6.18-rcX circa next Monday.

Adrian Bunk:
 [resend] the scheduled removal of drivers/ieee1394/sbp2.c:force_inquiry_hack

Stefan Richter:
 [update] ieee1394: sbp2: handle "sbp2util_node_write_no_wait failed"
 [new   ] ieee1394: sbp2: safer agent reset in error handlers
 [new   ] ieee1394: sbp2: recheck node generation in sbp2_update
 [new   ] ieee1394: sbp2: better handling of transport errors
 [new   ] ieee1394: sbp2: select SCSI in Kconfig
 [new   ] ieee1394: sbp2: update includes
 [new   ] ieee1394: sbp2: prevent rare deadlock in shutdown

 Documentation/feature-removal-schedule.txt |    9 -
 drivers/ieee1394/Kconfig                   |   12 +
 drivers/ieee1394/sbp2.c                    |  166 ++++++++++++++-------
 drivers/ieee1394/sbp2.h                    |   16 +-
 4 files changed, 137 insertions(+), 66 deletions(-)

-- 
Stefan Richter
-=====-=-==- =--- -===-
http://arcgraph.de/sr/

