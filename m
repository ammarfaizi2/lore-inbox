Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271829AbTHHUFZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 16:05:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271831AbTHHUFY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 16:05:24 -0400
Received: from [217.186.31.86] ([217.186.31.86]:4107 "EHLO
	gate.geos.net.eu.org") by vger.kernel.org with ESMTP
	id S271829AbTHHUFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 16:05:09 -0400
To: linux-kernel@vger.kernel.org, andre@linux-ide.org
Subject: 2.4.21/2.4.22-rc1: IDE error message on startup
From: geos@epost.de (Georg Schwarz)
Date: Fri, 8 Aug 2003 22:05:08 +0200
Message-ID: <1fze7ly.1v3ap5q173m695M@geos.net.eu.org>
Organization: private
User-Agent: MacSOUP/D-2.5b3 (Mac OS 8.1)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linux kernel maintainers,

the following problem (aka bug?) appeared in 2.4.21 and still exists in
2.4.22-rc1 (kernels prior to 2.4.21 work fine):

SETUP:
various mostly older PCs (486, Pentium I) and various smaller IDE drives
(can would be happy to more details if needed)

PROBLEM:
With Linux 2.4.21 or 2.4.22-rc1 (not with prior versions using the same
.config however) on startup I get the following error messages for any
connected IDE disk (but not ATAPI CR-ROM):

hda: attached ide-disk driver.
hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
hda: task_no_data_intr: error=0x04 { DriveStatusError }

Whether I compile with CONFIG_IDEDISK_MULTI_MODE set or not does not
make a difference, by the way.

If there's any more info I can provide (kernel configs maybe?) or things
I could test please do not hesitste to let me know.
I'd appreciate your feedback.

Georg


-- 
Georg Schwarz    http://home.pages.de/~schwarz/
 geos@epost.de     +49 177 8811442
