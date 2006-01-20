Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750749AbWATOrS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750749AbWATOrS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 09:47:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750837AbWATOrS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 09:47:18 -0500
Received: from [205.233.219.253] ([205.233.219.253]:13212 "EHLO
	conifer.conscoop.ottawa.on.ca") by vger.kernel.org with ESMTP
	id S1750749AbWATOrS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 09:47:18 -0500
Date: Fri, 20 Jan 2006 09:41:24 -0500
From: Jody McIntyre <scjody@modernduck.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Adrian Bunk <bunk@stusta.de>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] update the i386 defconfig
Message-ID: <20060120144124.GH13178@conscoop.ottawa.on.ca>
References: <20060119201046.GY19398@stusta.de> <20060120040326.GF13178@conscoop.ottawa.on.ca> <Pine.LNX.4.61.0601201535160.22940@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0601201535160.22940@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2006 at 03:35:29PM +0100, Jan Engelhardt wrote:

> And I suggest CONFIG_IEEE1394=m.

That's fine.  Then CONFIG_IEEE1394_SBP2=m CONFIG_IEEE1394_RAWIO=m too,
and we might as well put in ETH1394, VIDEO1394, and DV1394.  So:

#
# IEEE 1394 (FireWire) support
#
CONFIG_IEEE1394=m

#
# Subsystem Options
#
# CONFIG_IEEE1394_VERBOSEDEBUG is not set
# CONFIG_IEEE1394_OUI_DB is not set
CONFIG_IEEE1394_EXTRA_CONFIG_ROMS=y
CONFIG_IEEE1394_CONFIG_ROM_IP1394=y
# CONFIG_IEEE1394_EXPORT_FULL_API is not set

#
# Device Drivers
#
# CONFIG_IEEE1394_PCILYNX is not set
CONFIG_IEEE1394_OHCI1394=m

#
# Protocol Drivers
#
CONFIG_IEEE1394_VIDEO1394=m
CONFIG_IEEE1394_SBP2=m
# CONFIG_IEEE1394_SBP2_PHYS_DMA is not set
CONFIG_IEEE1394_ETH1394=m
CONFIG_IEEE1394_DV1394=m
CONFIG_IEEE1394_RAWIO=m


Cheers,
Jody
