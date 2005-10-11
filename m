Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751153AbVJKWLy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbVJKWLy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 18:11:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbVJKWLy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 18:11:54 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:34947 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S1751153AbVJKWLy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 18:11:54 -0400
Date: Tue, 11 Oct 2005 15:12:25 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] [ARM] Fix ixp2x00 defconfig NR_UARTS options
Message-ID: <20051011221225.GA26053@plexity.net>
Reply-To: dsaxena@plexity.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Plexity Networks
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


IXDP2[48]00 have only 1 UART on the board.

Signed-off-by: Deepak Saxena <dsaxena@plexity.net>

diff --git a/arch/arm/configs/ixdp2400_defconfig b/arch/arm/configs/ixdp2400_defconfig
--- a/arch/arm/configs/ixdp2400_defconfig
+++ b/arch/arm/configs/ixdp2400_defconfig
@@ -559,7 +559,7 @@ CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
 #
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
-CONFIG_SERIAL_8250_NR_UARTS=2
+CONFIG_SERIAL_8250_NR_UARTS=1
 # CONFIG_SERIAL_8250_EXTENDED is not set
 
 #
diff --git a/arch/arm/configs/ixdp2800_defconfig b/arch/arm/configs/ixdp2800_defconfig
--- a/arch/arm/configs/ixdp2800_defconfig
+++ b/arch/arm/configs/ixdp2800_defconfig
@@ -559,7 +559,7 @@ CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
 #
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
-CONFIG_SERIAL_8250_NR_UARTS=2
+CONFIG_SERIAL_8250_NR_UARTS=1
 # CONFIG_SERIAL_8250_EXTENDED is not set
 
 #

-- 
Deepak Saxena - dsaxena@plexity.net - http://www.plexity.net

Even a stopped clock gives the right time twice a day.
