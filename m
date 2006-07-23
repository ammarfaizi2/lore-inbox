Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751312AbWGWUzB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751312AbWGWUzB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jul 2006 16:55:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751313AbWGWUzB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jul 2006 16:55:01 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:449 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1751312AbWGWUzA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jul 2006 16:55:00 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Sun, 23 Jul 2006 22:53:26 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 2.6.18-rc1-mm2 0/6] ieee1394: sbp2: misc updates
To: linux1394-devel@lists.sourceforge.net
cc: Ben Collins <bcollins@ubuntu.com>, linux-kernel@vger.kernel.org
Message-ID: <tkrat.25e69df87688def6@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
X-Spam-Score: (0.908) AWL,BAYES_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patches include minor fixes and cleanups:

1/6 ieee1394: sbp2: safer last_orb and next_ORB handling
2/6 ieee1394: sbp2: discard return value of sbp2_link_orb_command
3/6 ieee1394: sbp2: optimize DMA direction of command ORBs
4/6 ieee1394: sbp2: safer initialization of status fifo
5/6 ieee1394: sbp2: more checks of status block
6/6 ieee1394: sbp2: convert sbp2util_down_timeout to waitqueue

 drivers/ieee1394/sbp2.c |  306 +++++++++++++++++-----------------------
 drivers/ieee1394/sbp2.h |   27 +--
 2 files changed, 143 insertions(+), 190 deletions(-)

I hope to follow up with further fixes that deal with command ORB
queueing during the next few weeks.
-- 
Stefan Richter
-=====-=-==- -=== =-===
http://arcgraph.de/sr/

