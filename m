Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272322AbRIWSwX>; Sun, 23 Sep 2001 14:52:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272717AbRIWSwE>; Sun, 23 Sep 2001 14:52:04 -0400
Received: from shell.cyberus.ca ([209.195.95.7]:38566 "EHLO shell.cyberus.ca")
	by vger.kernel.org with ESMTP id <S272322AbRIWSv4>;
	Sun, 23 Sep 2001 14:51:56 -0400
Date: Sun, 23 Sep 2001 14:49:41 -0400 (EDT)
From: jamal <hadi@cyberus.ca>
To: <linux-kernel@vger.kernel.org>
Subject: Any patches for 2.4.9: Cirrus Logic Crystal CS4281 PCI Audio?  
Message-ID: <Pine.GSO.4.30.0109231435210.22108-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ive asked google and some knowledgeable people. Ive hacked the driver code
to increase the timeouts. Alas, no luck. Does anyone have a cure for this?
My spanky new Dell laptop is not looking complete without sound.

Please CC me -- i am not on lk

cheers,
jamal

Details
-----------

00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge
(rev 03)
00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge
(rev 03)
00:07.0 Bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 03)
00:08.0 Multimedia audio controller: Cirrus Logic Crystal CS4281 PCI Audio
(rev 01)
00:0a.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus
Controller (rev 01)
00:0d.0 Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink]
(rev 78)
00:10.0 Communication controller: Lucent Microelectronics WinModem 56k
(rev 01)
01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage P/M
Mobility AGP 2x (rev 64)

--------------
CONFIG_SOUND=y
# CONFIG_SOUND_BT878 is not set
# CONFIG_SOUND_CMPCI is not set
# CONFIG_SOUND_EMU10K1 is not set
# CONFIG_MIDI_EMU10K1 is not set
# CONFIG_SOUND_FUSION is not set
CONFIG_SOUND_CS4281=y
# CONFIG_SOUND_ES1370 is not set
# CONFIG_SOUND_ES1371 is not set
# CONFIG_SOUND_ESSSOLO1 is not set
# CONFIG_SOUND_MAESTRO is not set
# CONFIG_SOUND_MAESTRO3 is not set
# CONFIG_SOUND_ICH is not set
# CONFIG_SOUND_RME96XX is not set
# CONFIG_SOUND_SONICVIBES is not set
# CONFIG_SOUND_TRIDENT is not set
# CONFIG_SOUND_MSNDCLAS is not set
# CONFIG_SOUND_MSNDPIN is not set
# CONFIG_SOUND_VIA82CXXX is not set
# CONFIG_MIDI_VIA82CXXX is not set
# CONFIG_SOUND_OSS is not set
# CONFIG_SOUND_TVMIXER is not set


