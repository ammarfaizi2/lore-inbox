Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284584AbRLIWu1>; Sun, 9 Dec 2001 17:50:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284580AbRLIWuR>; Sun, 9 Dec 2001 17:50:17 -0500
Received: from eos.telenet-ops.be ([195.130.132.40]:33675 "EHLO
	eos.telenet-ops.be") by vger.kernel.org with ESMTP
	id <S284584AbRLIWuL>; Sun, 9 Dec 2001 17:50:11 -0500
Subject: 2.4.16 / 2.4.17pre6 hang when loading agpgart
From: Roel Teuwen <Roel.Teuwen@advalvas.be>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 10 Dec 2001 01:00:24 +0100
Message-Id: <1007942424.342.0.camel@tux3>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On my HP Omnibook 4150, 2.4.16 and 2.4.17-pre6 hang on boot right after
the messages below.
I need to press the reset button and load a kernel without agpgart
compiled in to boot. When compiled as a module, the machine hangs after
printing these lines when loading the module.

"
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory : 96M
agpgart: Detected Intel 440BX chipset
"

I selected the agpgart "440BX" option in menuconfig.
AGP information :

00:01.0 PCI bridge: Intel Corp. 440BX/ZX - 82443BX/ZX AGP bridge (rev
02) (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, medium devsel, latency 128
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	Memory behind bridge: fe700000-fecfffff
	Prefetchable memory behind bridge: fd000000-fe3fffff

Please tell me if more information is needed.

Best regards,

Roel


