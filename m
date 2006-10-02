Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965437AbWJBVuG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965437AbWJBVuG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 17:50:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965436AbWJBVuG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 17:50:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:37829 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965437AbWJBVt7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 17:49:59 -0400
Date: Mon, 2 Oct 2006 14:49:54 -0700
From: Judith Lebzelter <judith@osdl.org>
To: linux-kernel@vger.kernel.org
Cc: linuxppc-dev@ozlabs.org
Subject: Undefined '.bus_to_virt', '.virt_to_bus' causes compile error on Powerpc 64-bit
Message-ID: <20061002214954.GD665@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

For the automated cross-compile builds at OSDL, powerpc 64-bit 
'allmodconfig' is failing.  The warnings/errors below appear in 
the 'modpost' stage of kernel compiles for 2.6.18 and -mm2 kernels.

Thanks;
Judith Lebzelter
OSDL

-----------

  Building modules, stage 2.
  MODPOST 1658 modules
WARNING: Can't handle masks in drivers/ata/ahci:FFFF05
WARNING: ".virt_to_bus" [sound/oss/sscape.ko] undefined!
WARNING: ".virt_to_bus" [sound/oss/sound.ko] undefined!
WARNING: ".bus_to_virt" [sound/oss/cs46xx.ko] undefined!
WARNING: ".virt_to_bus" [sound/oss/cs46xx.ko] undefined!
WARNING: ".bus_to_virt" [drivers/scsi/tmscsim.ko] undefined!
WARNING: ".bus_to_virt" [drivers/scsi/BusLogic.ko] undefined!
WARNING: ".virt_to_bus" [drivers/net/wan/lmc/lmc.ko] undefined!
WARNING: ".virt_to_bus" [drivers/message/i2o/i2o_config.ko] undefined!
WARNING: ".bus_to_virt" [drivers/block/cpqarray.ko] undefined!
WARNING: ".bus_to_virt" [drivers/atm/zatm.ko] undefined!
WARNING: ".virt_to_bus" [drivers/atm/zatm.ko] undefined!
WARNING: ".bus_to_virt" [drivers/atm/horizon.ko] undefined!
WARNING: ".virt_to_bus" [drivers/atm/firestream.ko] undefined!
WARNING: ".bus_to_virt" [drivers/atm/firestream.ko] undefined!
WARNING: ".bus_to_virt" [drivers/atm/ambassador.ko] undefined!
WARNING: ".virt_to_bus" [drivers/atm/ambassador.ko] undefined!
make[1]: *** [__modpost] Error 1
make: *** [modules] Error 2

