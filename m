Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130239AbRBZOek>; Mon, 26 Feb 2001 09:34:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130288AbRBZOby>; Mon, 26 Feb 2001 09:31:54 -0500
Received: from zeus.kernel.org ([209.10.41.242]:53191 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S130300AbRBZOaI>;
	Mon, 26 Feb 2001 09:30:08 -0500
Message-ID: <3A9A1F5B.AF529C8F@bigfoot.com>
Date: Mon, 26 Feb 2001 01:18:19 -0800
From: Tim Moore <timothymoore@bigfoot.com>
Organization: Yoyodyne Propulsion Systems, Inc.
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.19pre8+IDE i686)
X-Accept-Language: en
MIME-Version: 1.0
To: kernel <linux-kernel@vger.kernel.org>
Subject: "clock timer configuration lost" error?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For no apparent reason:

...
Feb 26 00:15:50 abit xntpd[886]: synchronized to 192.6.38.127, stratum=1
Feb 26 00:19:52 abit kernel: probable hardware bug: clock timer
configuration lost - probably a VIA686a. 
Feb 26 00:19:52 abit kernel: probable hardware bug: restoring chip
configuration. 
Feb 26 00:26:53 abit xntpd[886]: synchronized to 132.239.254.5,
stratum=2
...

Anyone have a clue about the 'probable hdw bug' messages?  No disk
activity to speak of, no other symptoms and/or messages.

rgds,
tim.

# cat proc/version; lspci
Linux version 2.2.19pre8+IDE (root@abit) (gcc version egcs-2.91.66
19990314/Linux (egcs-1.1.2 release)) #8 Thu Feb 22 18:12:29 PST 2001

00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 0391 (rev
02)
00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device 8391
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev
22)
00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev
10)
00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
(rev 30)
00:08.0 FireWire (IEEE 1394): Texas Instruments TSB12LV23 OHCI Compliant
IEEE-1394 Controller
00:09.0 Multimedia audio controller: Ensoniq ES1370 [AudioPCI]
00:0b.0 Ethernet controller: Lite-On Communications Inc LNE100TX (rev
20)
01:00.0 VGA compatible controller: nVidia Corporation Riva TNT2 Model 64
(rev 11)

--
