Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265923AbUBPW3J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 17:29:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265922AbUBPW3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 17:29:09 -0500
Received: from gate.crashing.org ([63.228.1.57]:34209 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S265921AbUBPW1d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 17:27:33 -0500
Subject: Re: 2.6.3-rc3: radeon blanks screen
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alessandro Suardi <alessandro.suardi@oracle.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <40314311.20708@oracle.com>
References: <402F83D4.3080605@oracle.com> <1076883902.6959.100.camel@gaston>
	 <40314311.20708@oracle.com>
Content-Type: text/plain
Message-Id: <1076970420.1053.68.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 17 Feb 2004 09:27:01 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> OK, here's the debug output part. I'm also attaching gzipped dmesg
>   in case you need more context.
> 
> ACPI: AC Adapter [AC] (on-line)
> ACPI: Battery Slot [BAT0] (battery present)
> ACPI: Battery Slot [BAT1] (battery absent)
> ACPI: Processor [CPU0] (supports C1 C2, 8 throttling states)
> ACPI: Thermal Zone [THM] (62 C)
> hStart = 1040, hEnd = 1176, hTotal = 1344
> vStart = 770, vEnd = 776, vTotal = 806
> h_total_disp = 0x7f00a7    hsync_strt_wid = 0x11040a
> v_total_disp = 0x2ff0325           vsync_strt_wid = 0x60301
> pixclock = 15384
> freq = 6500
> lvds_gen_cntl: 080dffa1
> Console: switching to colour frame buffer device 128x48
> pty: 256 Unix98 ptys configured

Make sure you try with Linus latest bk snapshot as some fixes went
in (along with more debug output) yesterday

Ben.


