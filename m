Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265841AbTGXNe2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 09:34:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265976AbTGXNe2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 09:34:28 -0400
Received: from us01smtp1.synopsys.com ([198.182.44.79]:18822 "EHLO
	boden.synopsys.com") by vger.kernel.org with ESMTP id S265841AbTGXNe1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 09:34:27 -0400
Date: Thu, 24 Jul 2003 15:49:29 +0200
From: Alex Riesen <alexander.riesen@synopsys.COM>
To: linux-kernel@vger.kernel.org
Subject: using defaults from older kernels
Message-ID: <20030724134929.GJ13611@Synopsys.COM>
Reply-To: alexander.riesen@synopsys.COM
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Synopsys, Inc.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Probably not very good idea.
(I decided to retreat to "make defconfig" after it).


$ make xconfig
...
#
# using defaults found in /boot/config-2.4.20-ck3
#
/boot/config-2.4.20-ck3:23: trying to assign nonexistent symbol LOLAT
/boot/config-2.4.20-ck3:24: trying to assign nonexistent symbol LOLAT_SYSCTL
/boot/config-2.4.20-ck3:50: trying to assign nonexistent symbol X86_HAS_TSC
/boot/config-2.4.20-ck3:52: trying to assign nonexistent symbol X86_PGE
/boot/config-2.4.20-ck3:54: trying to assign nonexistent symbol X86_F00F_WORKS_OK
/boot/config-2.4.20-ck3:158: trying to assign nonexistent symbol BLK_STATS
/boot/config-2.4.20-ck3:180: trying to assign nonexistent symbol FILTER
/boot/config-2.4.20-ck3:318: trying to assign nonexistent symbol BLK_DEV_IDETAPE
/boot/config-2.4.20-ck3:356: trying to assign nonexistent symbol PIIX_TUNING
/boot/config-2.4.20-ck3:385: trying to assign nonexistent symbol SD_EXTRA_DEVS
/boot/config-2.4.20-ck3:390: trying to assign nonexistent symbol SR_EXTRA_DEVS
/boot/config-2.4.20-ck3:624: trying to assign nonexistent symbol INPUT_KEYBDEV
/boot/config-2.4.20-ck3:636: trying to assign nonexistent symbol SERIAL
/boot/config-2.4.20-ck3:637: trying to assign nonexistent symbol SERIAL_CONSOLE
/boot/config-2.4.20-ck3:638: trying to assign nonexistent symbol SERIAL_EXTENDED
/boot/config-2.4.20-ck3:640: trying to assign nonexistent symbol SERIAL_SHARE_IRQ
/boot/config-2.4.20-ck3:660: trying to assign nonexistent symbol MOUSE
/boot/config-2.4.20-ck3:661: trying to assign nonexistent symbol PSMOUSE
/boot/config-2.4.20-ck3:726: trying to assign nonexistent symbol INTEL_RNG
/boot/config-2.4.20-ck3:741: trying to assign nonexistent symbol AGP_I810
/boot/config-2.4.20-ck3:960: trying to assign nonexistent symbol USB_UHCI
/boot/config-2.4.20-ck3:961: trying to assign nonexistent symbol USB_UHCI_ALT

$ head Makefile
VERSION = 2
PATCHLEVEL = 6
SUBLEVEL = 0
EXTRAVERSION = -test1


P.S.
boolean symbol BINFMT_ZFLAT tested for 'm'? test forced to 'n'

