Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271034AbTG1VJP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 17:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271112AbTG1VIl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 17:08:41 -0400
Received: from adicia.telenet-ops.be ([195.130.132.56]:4005 "EHLO
	adicia.telenet-ops.be") by vger.kernel.org with ESMTP
	id S271034AbTG1VGX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 17:06:23 -0400
Date: Mon, 28 Jul 2003 23:05:37 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.0-test2 - Watchdog patches (Kconfig + wdt_pci.c)
Message-ID: <20030728230537.A23648@infomag.infomag.iguana.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please do a

	bk pull http://linux-watchdog.bkbits.net/linux-2.5-watchdog

This will update the following files:

 drivers/char/watchdog/Kconfig   |   59 ++++++++++++++++++++++------------------
 drivers/char/watchdog/wdt_pci.c |    6 ++--
 2 files changed, 36 insertions(+), 29 deletions(-)

through these ChangeSets:

<wim@iguana.be> (03/07/28 1.1598)
   [WATCHDOG] make wdt_pci.c independant of wdt.c

<wim@iguana.be> (03/07/28 1.1597)
   [WATCHDOG] Cleanup of Kconfig file for the watchdog drivers.
   
   Cleanup of Kconfig file for the watchdog drivers.
   This clean-up exists of:
   * change the general comment so that it mentions watchdog device and not character device
   * correct some module-names
   * remove double-entry for W83877F_WDT
   * change Documentation/modules.txt to <file:Documentation/modules.txt> for consistency

<wim@iguana.be> (03/07/28 1.1596)
   [WATCHDOG] I810_TCO info in Kconfig
   
   Change Kconfig info about I810_TCO so that it is clear that this watchdog works for the i8xx series of chipsets and not only the i810 and i815 chipsets.

