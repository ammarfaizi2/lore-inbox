Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264361AbUDSMBf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 08:01:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264372AbUDSMBf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 08:01:35 -0400
Received: from anor.ics.muni.cz ([147.251.4.35]:35530 "EHLO anor.ics.muni.cz")
	by vger.kernel.org with ESMTP id S264361AbUDSMBe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 08:01:34 -0400
Date: Mon, 19 Apr 2004 14:01:32 +0200
From: Jan Kasprzak <kas@informatics.muni.cz>
To: linux-kernel@vger.kernel.org
Subject: Sensors (W83627HF) in Tyan S2882
Message-ID: <20040419120132.GP23938@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2i
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello, world!\n

	I have two systems with Tyan S2882 boards (K8S Pro). The sensors chip
is Winbond w83627hf according to the mainboard documentation.  The w83627hf
driver can read values from the sensors, but apparently not all values.
The board has six fan connectors (two labeled CPU1 fan and CPU2 fan,
and four chassis fans). BIOS displays the fan status correctly for all fans,
so all fans are connected to the sensors chip. However, there are only three
fans listed in /sys/devices/platform/i2c-1/1-0290.

	Is it possible to read status of other three fans from Linux?

	Thanks,

-Yenya

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
 Any compiler or language that likes to hide things like memory allocations
 behind your back just isn't a good choice for a kernel.   --Linus Torvalds
