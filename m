Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129464AbQLRWEn>; Mon, 18 Dec 2000 17:04:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129524AbQLRWEd>; Mon, 18 Dec 2000 17:04:33 -0500
Received: from [158.111.6.62] ([158.111.6.62]:3599 "EHLO mcdc-us-smtp3.cdc.gov")
	by vger.kernel.org with ESMTP id <S129464AbQLRWEH>;
	Mon, 18 Dec 2000 17:04:07 -0500
Message-ID: <B7F9A3E3FDDDD11185510000F8BDBBF2019C79D3@mcdc-atl-5.cdc.gov>
X-Sybari-Space: 00000000 00000000 00000000
From: Heitzso <xxh1@cdc.gov>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: usb broken in 2.4.0 test 12 versus 2.2.18
Date: Mon, 18 Dec 2000 16:33:26 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a Canon usb camera that I access via a
recent copy of the s10sh program (with -u option).

Getting to the camera via s10sh -u worked through 
large sections of 2.4.0 test X but broke recently.  
I cannot say for certain which test/patch the 
break occurred in.

Running 2.4.0 test12 malloc errors appear.
Everything is fine with 2.2.18.  I haven't tried
the test13 series of patches.  

key .config options:
 CONFIG_USB on
 DEVICEFS on
 HOTPLUG on
 UHCI on
everything else off (i.e. printers, keyboards,
mice, etc.). 

Baseline system is RH6.2 with most patches applied
(so avoiding RH7 compiler problems).  Basic dev
environment is same (i.e. compiling the two kernels
on the same box).

If someone wants to email me a debug sequence or
ask more specific questions feel free.

xxh1@cdc.gov
Heitzso
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
