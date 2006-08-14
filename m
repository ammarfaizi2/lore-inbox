Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752061AbWHNUxK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752061AbWHNUxK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 16:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752057AbWHNUxK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 16:53:10 -0400
Received: from ra.tuxdriver.com ([70.61.120.52]:29188 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1751855AbWHNUxI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 16:53:08 -0400
Date: Mon, 14 Aug 2006 16:52:36 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org
Subject: Patches queued in wireless-2.6 for 2.6.19
Message-ID: <20060814205231.GB26502@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Below is the shortlog of patches currently queued in wireless-2.6 for the
2.6.19 merge window.  This message is a heads-up for those interested in
taking a closer look.

There aren't any big items at the moment.  These are mostly improvements
to the bcm43xx and zd1211rw drivers, along with some other miscellaneous
improvements to the softmac infrastructure and other drivers.

FYI!

John

---

Dan Williams:
      prism54: update to WE-19 for WPA support

Daniel Drake:
      zd1211rw: Add Sagem device ID's
      zd1211rw: Implement SIOCGIWNICKN
      Add zd1211rw MAINTAINERS entry
      ieee80211: small ERP handling additions
      softmac: ERP handling and driver-level notifications
      softmac: export highest_supported_rate function
      ieee80211: Make ieee80211_rx_any usable
      softmac: Add MAINTAINERS entry
      zd1211rw: ZD1211B ASIC/FWT, not jointly decoder
      zd1211rw: Match vendor driver IFS values
      zd1211rw: AL2230 ZD1211B vendor sync
      zd1211rw: Support AL7230B RF
      zd1211rw: Add ID for Senao NUB-8301
      zd1211rw: Add ID for Allnet ALLSPOT Hotspot finder
      zd1211rw: Firmware version vs bootcode version mismatch handling
      zd1211rw: Add ID for ZyXEL G220F
      zd1211rw: Convert installer CDROM device into WLAN device

John W. Linville:
      bcm43xx: fix-up build breakage from merging patches out of order
      bcm43xx: reduce mac_suspend delay loop count

Larry Finger:
      bcm43xx: improved statistics
      bcm43xx: improved statistics
      bcm43xx: add missing mac_suspended initialization

Michael Buesch:
      bcm43xx: opencoded locking
      bcm43xx: voluntary preemtion in the calibration loops
      bcm43xx: suspend MAC while executing long pwork
      bcm43xx: lower mac_suspend udelay
      bcm43xx: fix mac_suspend refcount
      bcm43xx: init routine rewrite

Michael Wu:
      ray_cs: Remove dependency on ieee80211

Pavel Machek:
      cleanup // comments from ipw2200

Robert Schulze:
      airo: collapse debugging-messages in issuecommand to one line

Ulrich Kunitz:
      zd1211rw: USB id 1582:6003 for Longshine 8131G3 added
      zd1211rw: cleanups

-- 
John W. Linville
linville@tuxdriver.com
