Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265830AbRGPR0W>; Mon, 16 Jul 2001 13:26:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265467AbRGPR0M>; Mon, 16 Jul 2001 13:26:12 -0400
Received: from mta02-svc.ntlworld.com ([62.253.162.42]:54242 "EHLO
	mta02-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S265848AbRGPR0E>; Mon, 16 Jul 2001 13:26:04 -0400
Content-Type: text/plain; charset=US-ASCII
From: Gav <gavbaker@ntlworld.com>
To: linux-kernel@vger.kernel.org
Subject: Linux-2.4.6-ac5 + via/ES1371
Date: Mon, 16 Jul 2001 18:13:11 +0000
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01071618131100.01207@box.penguin.power>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

*        So far so good, but still treat this one with care. We now use the
*        official VIA workaround for the southbridge bugs. That should fix
*        the ES137x/SB PCI problems on VIA and some other stuff without
*        breaking the IDE corruption fix. 

I have an abit KT7-a-raid motherboard that uses the VIA KT133A/686B and 
HPT370 chipset, this new VIA workaround still doesn't help my Ensoniq 5880 
AudioPCI (es1371) produce clear sound, just crackle and pop still, like its 
been since the via fixes were introduced around 2.4.3.

I'm using abit's latest bios which added some more options.

from the readme...
"-Delay Transaction
-PCI master read
-PCI master time-out
Sets above options to Disabled/0 and may help SB Live 5.1 sound issue."

Which also didn't help.

Did this new fix resolve anyones via+es1371 problems? I've spent weeks 
playing with bios/kernel options and searching for fixes, I would appreciate 
any tips on sorting this, or any test patches.

This box currently has just an nvidia geforce2MX and the audioPCI (Creative 
soundblaster) on the PCI bus.

-- Gav

System going down at 5 this afternoon to install scheduler bug.
