Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269489AbUIZDTs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269489AbUIZDTs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 23:19:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269492AbUIZDTs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 23:19:48 -0400
Received: from smtp.sys.beep.pl ([195.245.198.13]:58632 "EHLO smtp.sys.beep.pl")
	by vger.kernel.org with ESMTP id S269489AbUIZDTp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 23:19:45 -0400
From: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Organization: SelfOrganizing
To: linux-kernel@vger.kernel.org
Subject: kernel 2.6.9rc2+bk hangs at: ACPI: IRQ9 SCI: Level Trigger.
Date: Sun, 26 Sep 2004 05:18:26 +0200
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200409260518.26590.arekm@pld-linux.org>
X-Authenticated-Id: arekm 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


My kernel (2.6.9rc2+cset-20040926_0006) hangs at:
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ACPI: IRQ9 SCI: Level Trigger.

Previous working kernel running here was 2.6.9rc2+20040914_1622.

I've tried options:
acpi=off
noapic
nolapic
acpi=off noapic nolapic
but no change - hangs with each these options, sysrq is not working.

Ideas welcome.

It's MaxData Mbook 1000T notebook with athlon mobile cpu.

00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 03)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 
40)
00:07.1 IDE interface: VIA Technologies, Inc. 
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
00:07.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (rev 1a)
00:07.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (rev 1a)
00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 
40)
00:08.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus Controller 
(rev 01)
00:09.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 07)
00:09.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 
07)
00:0a.0 Unknown mass storage controller: Promise Technology, Inc. PDC20268 
(Ultra100 TX2) (rev 01)
00:0c.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture 
(rev 11)
00:0c.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 
11)
00:0d.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev 
6c)
01:00.0 VGA compatible controller: ATI Technologies Inc Radeon RV250 If 
[Radeon 9000] (rev 01)
01:00.1 Display controller: ATI Technologies Inc Radeon RV250 [Radeon 9000] 
(Secondary) (rev 01)

Something else needed?
-- 
Arkadiusz Mi¶kiewicz                    PLD/Linux Team
http://www.t17.ds.pwr.wroc.pl/~misiek/  http://ftp.pld-linux.org/
