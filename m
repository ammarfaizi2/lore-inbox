Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265463AbUF2FUi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265463AbUF2FUi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 01:20:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265467AbUF2FUi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 01:20:38 -0400
Received: from out004pub.verizon.net ([206.46.170.142]:63137 "EHLO
	out004.verizon.net") by vger.kernel.org with ESMTP id S265463AbUF2FUg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 01:20:36 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Organization: not detectable
To: linux-kernel@vger.kernel.org
Subject: odd dmesg for bootup of 2.6.7-mm3
Date: Tue, 29 Jun 2004 01:20:35 -0400
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200406290120.35345.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out004.verizon.net from [151.205.59.165] at Tue, 29 Jun 2004 00:20:35 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings;

I may not be subbed to this list, mailbox overflow while I was gone 
for a week. So CC me at my return addy please until I get that 
squared away.

I just rebooted to 2.6.7-mm3, and noticed this bit of whatever in my 
dmesg file:
Serial: 8250/16550 driver $Revision: 1.90 $ 6 ports, IRQ sharing 
enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
serial: guess board returned false
serial: guess board returned false
serial: guess board returned false
serial: guess board returned false
serial: guess board returned false
serial: guess board returned false
serial: guess board returned false
serial: guess board returned false
serial: guess board returned false
serial: guess board returned false
serial: guess board returned false
serial: guess board returned false
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE,EPP]
lp0: using parport0 (interrupt-driven).
Using cfq io scheduler

First, the board only has 2 seriel ports, so why is it checking for 6?

Also, the mouse seems to be back to normal, whereas the dbl-click rate 
was maybe 200ms when booted to 2.6.7-mm1, so thats apparently fixed.

Finally, which scheduler is the prefered scheduler now?  I'm using cfq 
because it seems to be more stable for the keyboard autorepeat 
functions where the default can put me well below once per second and 
lag to beat all in kmail.

-- 
Cheers, Gene
There are 4 boxes to be used in defense of liberty. 
Soap, ballot, jury, and ammo.
Please use in that order, starting now.  -Ed Howdershelt, Author
Additions to this message made by Gene Heskett are Copyright 2004, 
Maurice E. Heskett, all rights reserved.
