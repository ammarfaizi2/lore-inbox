Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130151AbRADOe6>; Thu, 4 Jan 2001 09:34:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133116AbRADOes>; Thu, 4 Jan 2001 09:34:48 -0500
Received: from mailhost.mipsys.com ([62.161.177.33]:32708 "EHLO
	mailhost.mipsys.com") by vger.kernel.org with ESMTP
	id <S130151AbRADOeh>; Thu, 4 Jan 2001 09:34:37 -0500
From: Benjamin Herrenschmidt <bh40@calva.net>
To: Linux Kernel <linux-kernel@vger.kernel.org>, <dledford@redhat.com>
Subject: aic7xxx.c vs. Adaptec 29160N
Date: Thu, 4 Jan 2001 15:34:00 +0100
Message-Id: <19341129080544.842@mailhost.mipsys.com>
X-Mailer: CTM PowerMail 3.0.6 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a 29160N card in a PowerMac G4. It used to work fine with an old
UW SCSI disk I had there. Today, I flipped this drive with a real
Ultra160 one , and now, the kernel won't boot. It's giving me an endless
stream of SCSI reset timeouts on bus 0.

Any clue ? I don't really need this disk in Linux (at least not yet), but
I don't neither want to plug/unplug the disk each time I boot linux or
MacOS...

The disk is a Quantum ATLAS_V__9_WLS rev. 0230

Anything I can do to help tracking the problem ? It's difficult to get
the actual output of the driver in verbose mode as it is scrolling quite
fast and I have nothing like a serial console on this box. The kernel
won't boot without noprobe so I can't dump dmesg output.

Ben.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
