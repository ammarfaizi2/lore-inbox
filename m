Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262169AbTIHJeu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 05:34:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262177AbTIHJeg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 05:34:36 -0400
Received: from mx0.gmx.net ([213.165.64.100]:50002 "HELO mx0.gmx.net")
	by vger.kernel.org with SMTP id S262169AbTIHJd7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 05:33:59 -0400
Date: Mon, 8 Sep 2003 11:33:58 +0200 (MEST)
From: Daniel Blueman <daniel.blueman@gmx.net>
To: alsa-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: [2.6.0-test4] [BUG, ALSA] no 44.1KHz sound for i8x0 ICH2...
X-Priority: 3 (Normal)
X-Authenticated-Sender: #0008973862@gmx.net
X-Authenticated-IP: [194.202.174.101]
Message-ID: <31962.1063013638@www28.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can't get any sound output with an Intel 815 chipset at 44.1KHz. ALSA
reports the sound chipset can clock to 41KHz.

What information do I need to post here?

Please CC me on any replies.

--- [ lspci -v ]

00:1f.5 Multimedia audio controller: Intel Corp. 82801BA/BAM AC'97 Audio
(rev 11)
        Subsystem: Dell Computer Corporation: Unknown device 00be
        Flags: bus master, medium devsel, latency 0, IRQ 10
        I/O ports at c800 [size=256]
        I/O ports at cc40 [size=64]

--- [ dmesg ]

Advanced Linux Sound Architecture Driver Version 0.9.6 (Wed Aug 20 20:27:13
2003 UTC).
PCI: Found IRQ 10 for device 0000:00:1f.5
PCI: Sharing IRQ 10 with 0000:00:1f.3
PCI: Setting latency timer of device 0000:00:1f.5 to 64
hub 1-0:0: debounce: port 1: delay 100ms stable 4 status 0x301
intel8x0: clocking to 41151          <----- should be 44100?
ALSA device list:
  #0: Intel 82801BA-ICH2 at 0xc800, irq 10

-- 
Daniel J Blueman

COMPUTERBILD 15/03: Premium-e-mail-Dienste im Test
--------------------------------------------------
1. GMX TopMail - Platz 1 und Testsieger!
2. GMX ProMail - Platz 2 und Preis-Qualitätssieger!
3. Arcor - 4. web.de - 5. T-Online - 6. freenet.de - 7. daybyday - 8. e-Post

