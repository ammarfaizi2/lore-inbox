Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129831AbRABBaY>; Mon, 1 Jan 2001 20:30:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130012AbRABBaP>; Mon, 1 Jan 2001 20:30:15 -0500
Received: from 209.102.21.2 ([209.102.21.2]:61445 "EHLO dragnet.seagull.net")
	by vger.kernel.org with ESMTP id <S129831AbRABBaB>;
	Mon, 1 Jan 2001 20:30:01 -0500
Message-ID: <3A50F77B.2EA2FF12@goingware.com>
Date: Mon, 01 Jan 2001 21:32:43 +0000
From: "Michael D. Crawford" <crawford@goingware.com>
Organization: GoingWare Inc. - Expert Software Development and Consulting
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.4.0-test13-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: VM thrashing in test13-pre4 with Netscape
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't know if this is a Netscape problem, or an XFree86 4.0.1 problem, or a
kernel problem.  I hadn't noticed it with previous kernels so I thought I should
mention it.

I'll download the latest kernel source tonight and try it out.

I'm using 2.4.0-test13-pre4 with XFree86 4.0.1 and Netscape Communicator 4.73. 
The distro is slackware 7.1 on a Pentium III 667 MHz machine with an ASUS
motherboard with a Via chipset and an Adaptec 29160 SCSI host bus adapter.  It
has 128 MB of 133 MHz ram.

If I browse with Netscape for a while, after a while I start hearing a lot of
disk activity and the response of the machine slows way down. "top" often shows
kswapd as having the top CPU time.  In one instance of this, Netscape was using
60% of the memory and XFree86 was using 40%.  (I'm not sure if this is the
memory in use or percentage of all available memory).

If I quit netscape the thrashing stops, and I can start it up again and run OK
for a while, but it seems to start up again much sooner.  After a while I have
to reboot.

When it happens, the onset seems pretty sudden.  It doesn't appear like
something's slowly leaking memory.  It feels more like something suddenly goes
haywire.

Mike
-- 
Michael D. Crawford
GoingWare Inc. - Expert Software Development and Consulting
http://www.goingware.com/
crawford@goingware.com

   Tilting at Windmills for a Better Tomorrow.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
