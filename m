Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965183AbWEOUFh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965183AbWEOUFh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 16:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965181AbWEOUFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 16:05:37 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:18322 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S965183AbWEOUFg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 16:05:36 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Mon, 15 May 2006 22:02:41 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 0/4 resend] sbp2: fixes for device bugs
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Jody McIntyre <scjody@modernduck.com>,
       Ben Collins <bcollins@ubuntu.com>
Message-ID: <tkrat.7fdbc058e06f117a@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
X-Spam-Score: (-0.74) AWL,BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patches contain workarounds for buggy FireWire storage
devices and a fix for an interoperability regression since Linux 2.6.16.
I plan to rediff and submit these patches for -stable once they are in
mainline.

 Documentation/feature-removal-schedule.txt |   10 +
 drivers/ieee1394/ohci1394.c                |    2
 drivers/ieee1394/sbp2.c                    |  245 +++++++++++++++++++----------
 drivers/ieee1394/sbp2.h                    |   18 --
 4 files changed, 182 insertions(+), 93 deletions(-)

-- 
Stefan Richter
-=====-=-==- -=-= -====
http://arcgraph.de/sr/

