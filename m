Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261158AbRERQt6>; Fri, 18 May 2001 12:49:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261159AbRERQts>; Fri, 18 May 2001 12:49:48 -0400
Received: from www.topmail.de ([212.255.16.226]:14573 "HELO www.topmail.de")
	by vger.kernel.org with SMTP id <S261158AbRERQtg>;
	Fri, 18 May 2001 12:49:36 -0400
From: mirabilos <eccesys@topmail.de>
To: <linux-kernel@vger.kernel.org>
SUbject: 2.4.4-ac9 freezes (2x)
Message-Id: <20010518164454.06C54A5AF47@www.topmail.de>
Date: Fri, 18 May 2001 18:44:54 +0200 (MET DST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Repost because I got no answer :(
But I have added new information.

2.4.4-ac9 did compile for me with CONFIG_RWSEM_GENERIC_* on.
But it freezes when accessing the floppy.
And it freezes during sound playback.
My laptop (Scenic Mobile 510 from Siemens) has an onboard ESS1869
which works fine with 2.4.3-ac7 and Andres's generic-rwsem patch
(retested).
I thought it only would freeze on keypress during these ops but yesterday
it did so even during playback without any keypress.
I have no logs or similar, because it froze, but e2fsck annoys me :)
If any of you has a clue why this could be, thanks. I'll try -ac11 later
(need a rwsem solution for gcc-3 first). May I really use RWSEM_GENERIC?
Or shall I do CONFIG_M386 then?
Actually it is a P][ Deschutes with upgrade to stepping 45 on /dev/microcode,
APM is on (no ACPI support) and the UP-APIC cannot be enabled so I dont compile
it on any longer.
On request I can give more information.

TIA
-mirabilos
-- 
by telnet
