Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932068AbWE1H2s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbWE1H2s (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 03:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932084AbWE1H2s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 03:28:48 -0400
Received: from mx3.mail.ru ([194.67.23.149]:15662 "EHLO mx3.mail.ru")
	by vger.kernel.org with ESMTP id S932068AbWE1H2r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 03:28:47 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: alsa-devel@alsa-project.org
Subject: 2.6.16.x - relatively low volume and high noice using snd-ali15451
Date: Sun, 28 May 2006 11:28:33 +0400
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605281128.33841.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I have a notebook with built in sound card:

{pts/0}% lspci
00:00.0 Host bridge: ALi Corporation M1644/M1644T Northbridge+Trident (rev 01)
00:01.0 PCI bridge: ALi Corporation PCI to AGP Controller
00:02.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)
00:04.0 IDE interface: ALi Corporation M5229 IDE (rev c3)
00:06.0 Multimedia audio controller: ALi Corporation M5451 PCI AC-Link 
Controller Audio Device (rev 01)
00:07.0 ISA bridge: ALi Corporation M1533 PCI to ISA Bridge [Aladdin IV]
00:08.0 Bridge: ALi Corporation M7101 Power Management Controller [PMU]
00:0a.0 Ethernet controller: Intel Corporation 82557/8/9 [Ethernet Pro 100] 
(rev 08)
00:10.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus Controller 
(rev 01)
00:11.0 CardBus bridge: Toshiba America Info Systems ToPIC100 PCI to Cardbus 
Bridge with ZV Support (rev 32)
00:11.1 CardBus bridge: Toshiba America Info Systems ToPIC100 PCI to Cardbus 
Bridge with ZV Support (rev 32)
00:12.0 System peripheral: Toshiba America Info Systems SD TypA Controller 
(rev 03)
01:00.0 VGA compatible controller: Trident Microsystems CyberBlade XPAi1 (rev 
82)

A some point I noticed that volume became quite low; attempting to turn it up 
using volume control on notebook results in very audible noise that makes it 
impossible to actually use sound.

I am very casual sound user so I unfortunately cannot tell when exactly the 
problem appeared first; but I am pretty sure that in 2.6.14 I could normally 
watch video or listen CD without much strain.

I appreciate any pointers how to debug it further; if required I am ready to 
try to recompile older kernel (as time permits).

TIA

- -andrey
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEeVEhR6LMutpd94wRAr4sAJ9XajOR7+fnA1ndK6qEJdfG0POVBwCgu/3Z
lBIo9yqV145Sb6havhHLmBc=
=YPM/
-----END PGP SIGNATURE-----
