Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266988AbTGOJjo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 05:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266997AbTGOJjo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 05:39:44 -0400
Received: from server102.xantronmail.de.187.86.80.in-addr.arpa ([80.86.187.130]:31956
	"EHLO kunden.xantronkunden1.de") by vger.kernel.org with ESMTP
	id S266988AbTGOJjm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 05:39:42 -0400
Message-ID: <3F13CF33.7040706@jstephan.org>
Date: Tue, 15 Jul 2003 11:53:55 +0200
From: Joerg Stephan <joerg@jstephan.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.0-test1 some Problems (modules & touchpad)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everybody,

i've tried to run 2.6.0-test1 today on my acer aspire 1601lc, i've got 
two Problems.

First of all, there is a problem with the modules (the same i had with 
some versions of 2.5.x), see output below.

The second is, the touchpad of my notebook doesnt work.

   INSTALL drivers/net/8139too.ko
   INSTALL arch/i386/kernel/cpu/cpufreq/acpi.ko
   INSTALL drivers/net/wireless/airo.ko
   INSTALL drivers/net/wireless/airo_cs.ko
   INSTALL drivers/video/cfbcopyarea.ko
   INSTALL drivers/video/cfbfillrect.ko
   INSTALL drivers/video/cfbimgblt.ko
   INSTALL drivers/net/dummy.ko
   INSTALL drivers/video/console/fbcon.ko
   INSTALL drivers/base/firmware_class.ko
   INSTALL drivers/video/console/font.ko
   INSTALL drivers/ieee1394/ieee1394.ko
   INSTALL drivers/net/mii.ko
   INSTALL fs/ntfs/ntfs.ko
   INSTALL arch/i386/kernel/cpu/cpufreq/p4-clockmod.ko
   INSTALL drivers/net/ppp_generic.ko
   INSTALL drivers/video/radeonfb.ko
   INSTALL drivers/net/slhc.ko
   INSTALL drivers/pcmcia/yenta_socket.ko
if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.6.0-test1; fi
depmod: *** Unresolved symbols in 
/lib/modules/2.6.0-test1/kernel/drivers/net/8139too.ko
depmod: 	mii_ethtool_sset
depmod: 	mii_link_ok
depmod: 	mii_ethtool_gset
depmod: 	generic_mii_ioctl
depmod: 	mii_nway_restart
depmod: *** Unresolved symbols in 
/lib/modules/2.6.0-test1/kernel/drivers/net/ppp_generic.ko
depmod: 	slhc_init
depmod: 	slhc_free
depmod: 	slhc_uncompress
depmod: 	slhc_toss
depmod: 	slhc_remember
depmod: 	slhc_compress
depmod: *** Unresolved symbols in 
/lib/modules/2.6.0-test1/kernel/drivers/net/wireless/airo_cs.ko
depmod: 	reset_airo_card
depmod: 	init_airo_card
depmod: 	stop_airo_card
depmod: *** Unresolved symbols in 
/lib/modules/2.6.0-test1/kernel/drivers/video/console/fbcon.ko
depmod: 	find_font
depmod: 	get_default_font
depmod: *** Unresolved symbols in 
/lib/modules/2.6.0-test1/kernel/drivers/video/radeonfb.ko
depmod: 	cfb_copyarea
depmod: 	cfb_imageblit
depmod: 	cfb_fillrect
make: *** [_modinst_post] Error 1

Greets Joerg

