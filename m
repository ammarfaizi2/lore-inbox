Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265928AbUBPWZA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 17:25:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265965AbUBPWZA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 17:25:00 -0500
Received: from inet-mail1.oracle.com ([148.87.2.201]:18063 "EHLO
	inet-mail1.oracle.com") by vger.kernel.org with ESMTP
	id S265944AbUBPWYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 17:24:54 -0500
Message-ID: <40314311.20708@oracle.com>
Date: Mon, 16 Feb 2004 23:24:17 +0100
From: Alessandro Suardi <alessandro.suardi@oracle.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20040107
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.3-rc3: radeon blanks screen
References: <402F83D4.3080605@oracle.com> <1076883902.6959.100.camel@gaston>
In-Reply-To: <1076883902.6959.100.camel@gaston>
Content-Type: multipart/mixed;
 boundary="------------090804050705050601090308"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090804050705050601090308
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Benjamin Herrenschmidt wrote:
> On Mon, 2004-02-16 at 01:36, Alessandro Suardi wrote:
> 
>>On my Dell Latitude C640 as on Peter Osterlund's laptop - blind-typing
>>  login/password and startx gets me a visible X desktop.
>>
>>Old driver with Peter's patch works as before.
>>
>>Note - this is the same laptop you tried I gave up using framebuffer on
>>  in the 2.4 series because after 2.4.22-pre4 it would send my screen in
>>  a crazed-up state (X didn't work either) [that was July 2003].
> 
> 
> Please enable the #define DEBUG 1 in radeonfb.h  and send me the
> output  again.

OK, here's the debug output part. I'm also attaching gzipped dmesg
  in case you need more context.

ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Battery Slot [BAT1] (battery absent)
ACPI: Processor [CPU0] (supports C1 C2, 8 throttling states)
ACPI: Thermal Zone [THM] (62 C)
hStart = 1040, hEnd = 1176, hTotal = 1344
vStart = 770, vEnd = 776, vTotal = 806
h_total_disp = 0x7f00a7    hsync_strt_wid = 0x11040a
v_total_disp = 0x2ff0325           vsync_strt_wid = 0x60301
pixclock = 15384
freq = 6500
lvds_gen_cntl: 080dffa1
Console: switching to colour frame buffer device 128x48
pty: 256 Unix98 ptys configured


Thanks !

--alessandro

  "Two rivers run too deep
   The seasons change and so do I"
       (U2, "Indian Summer Sky")

--------------090804050705050601090308
Content-Type: application/x-gzip;
 name="dmesg-263rc3debug.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="dmesg-263rc3debug.gz"

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
/wFsLR8RNCgAAA==
--------------090804050705050601090308--

