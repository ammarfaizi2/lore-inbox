Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262625AbUCRNcw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 08:32:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262626AbUCRNcw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 08:32:52 -0500
Received: from main.gmane.org ([80.91.224.249]:29075 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262625AbUCRNbt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 08:31:49 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jens Benecke <jens@spamfreemail.de>
Subject: 2.6.5rc1bk2: vesafb produces blank screen, 2.4.22 works
Date: Thu, 18 Mar 2004 14:31:43 +0100
Organization: University of the Armed Forces, Hamburg, Germany
Message-ID: <c3c8c0$a1c$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: get1431p4.unibw-hamburg.de
User-Agent: KNode/0.7.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

upgraded to 2.6.5rc1bk2 on my work machine. Everything is fine so far,
except for the boot process, which I simply do not see (until X11 comes
up). I have a "ATI Technologies Inc Radeon RV100 QY [Radeon 7000/VE]"
graphics adapter, according to lspci.

This is the relevant portion of my .config ... is there anything I need to
add to get 1280x1024 with a small VGA font at bootup?


Thank you!


#
# Graphics support
#
CONFIG_FB=y
CONFIG_FB_PM2=m
# CONFIG_FB_PM2_FIFO_DISCONNECT is not set
CONFIG_FB_CYBER2000=m
# CONFIG_FB_IMSTT is not set
CONFIG_FB_VGA16=m
CONFIG_FB_VESA=y
CONFIG_VIDEO_SELECT=y
CONFIG_FB_HGA=m
CONFIG_FB_RIVA=m
CONFIG_FB_I810=m
# CONFIG_FB_I810_GTF is not set
CONFIG_FB_MATROX=m
CONFIG_FB_MATROX_MILLENIUM=y
CONFIG_FB_MATROX_MYSTIQUE=y
CONFIG_FB_MATROX_G450=y
CONFIG_FB_MATROX_G100=y
CONFIG_FB_MATROX_I2C=m
CONFIG_FB_MATROX_MAVEN=m
CONFIG_FB_MATROX_MULTIHEAD=y
CONFIG_FB_RADEON_OLD=m
CONFIG_FB_RADEON=m
CONFIG_FB_RADEON_I2C=y
# CONFIG_FB_RADEON_DEBUG is not set
CONFIG_FB_ATY128=m
CONFIG_FB_ATY=m
CONFIG_FB_ATY_CT=y
CONFIG_FB_ATY_GX=y
CONFIG_FB_ATY_XL_INIT=y
CONFIG_FB_SIS=m
CONFIG_FB_SIS_300=y
CONFIG_FB_SIS_315=y
CONFIG_FB_NEOMAGIC=m
CONFIG_FB_KYRO=m
CONFIG_FB_3DFX=m
CONFIG_FB_VOODOO1=m
CONFIG_FB_TRIDENT=m
CONFIG_FB_VIRTUAL=m




-- 
Jens Benecke (jens at spamfreemail.de)
http://www.hitchhikers.de - Europaweite kostenlose Mitfahrzentrale
http://www.spamfreemail.de - 100% saubere Postfächer - garantiert!
http://www.rb-hosting.de - PHP ab 9? - SSH ab 19? - günstiger Traffic
.
Please DO NOT CC: me, I read the lists and newsgroups I post in!

