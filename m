Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751650AbWJTDZ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751650AbWJTDZ7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 23:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946149AbWJTDZ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 23:25:58 -0400
Received: from ns.suse.de ([195.135.220.2]:61858 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751650AbWJTDZl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 23:25:41 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 20 Oct 2006 13:25:35 +1000
Message-Id: <1061020032535.1682@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 002 of 4] md: Add another COMPAT_IOCTL for md.
References: <20061020120612.29297.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


.. so that you can use bitmaps with 32bit userspace on a 
64 bit kernel.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./include/linux/compat_ioctl.h |    1 +
 1 file changed, 1 insertion(+)

diff .prev/include/linux/compat_ioctl.h ./include/linux/compat_ioctl.h
--- .prev/include/linux/compat_ioctl.h	2006-10-20 11:49:14.000000000 +1000
+++ ./include/linux/compat_ioctl.h	2006-10-20 12:00:56.000000000 +1000
@@ -131,6 +131,7 @@ COMPATIBLE_IOCTL(RUN_ARRAY)
 COMPATIBLE_IOCTL(STOP_ARRAY)
 COMPATIBLE_IOCTL(STOP_ARRAY_RO)
 COMPATIBLE_IOCTL(RESTART_ARRAY_RW)
+COMPATIBLE_IOCTL(GET_BITMAP_FILE)
 ULONG_IOCTL(SET_BITMAP_FILE)
 /* DM */
 COMPATIBLE_IOCTL(DM_VERSION_32)
