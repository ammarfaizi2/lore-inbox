Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261746AbUDSTal (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 15:30:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261766AbUDSTal
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 15:30:41 -0400
Received: from anor.ics.muni.cz ([147.251.4.35]:44231 "EHLO anor.ics.muni.cz")
	by vger.kernel.org with ESMTP id S261746AbUDSTak (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 15:30:40 -0400
Date: Mon, 19 Apr 2004 21:30:26 +0200
From: Jan Kasprzak <kas@informatics.muni.cz>
To: Fabian Fenaut <fabian.fenaut@free.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Sensors (W83627HF) in Tyan S2882
Message-ID: <20040419193025.GC26764@fi.muni.cz>
References: <20040419120132.GP23938@fi.muni.cz> <200404191338.i3JDcBna029336@anor.ics.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200404191338.i3JDcBna029336@anor.ics.muni.cz>
User-Agent: Mutt/1.4.2i
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fabian Fenaut wrote:
: Jan Kasprzak a écrit le 19.04.2004 14:01:
: >
: >I have two systems with Tyan S2882 boards (K8S Pro). The sensors chip is
: >Winbond w83627hf according to the mainboard documentation.  The w83627hf 
: >driver can read values from the sensors, but apparently not all values. The
: >board has six fan connectors (two labeled CPU1 fan and CPU2 fan, and four
: >chassis fans). BIOS displays the fan status correctly for all fans, so all
: >fans are connected to the sensors chip. However, there are only three fans
: >listed in /sys/devices/platform/i2c-1/1-0290.
: 
: 
: Probably unrelated to your problem, but isn't there a typo in 
: drivers/i2c/chips/Kconfig ? maybe patch below ?
: 
	Yes, I had CONFIG_SENSORS_W83781D=y. I have recompiled with
CONFIG_SENSORS_W83627HF=y and without CONFIG_SENSORS_W83781D, but the new
kernel still can see only three fans.

-Yenya

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
 Any compiler or language that likes to hide things like memory allocations
 behind your back just isn't a good choice for a kernel.   --Linus Torvalds
