Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314058AbSD0NuN>; Sat, 27 Apr 2002 09:50:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314083AbSD0NuM>; Sat, 27 Apr 2002 09:50:12 -0400
Received: from pD9E23370.dip.t-dialin.net ([217.226.51.112]:14059 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S314058AbSD0NuL>; Sat, 27 Apr 2002 09:50:11 -0400
Date: Sat, 27 Apr 2002 07:50:09 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: linux-kernel@vger.kernel.org
Subject: BIOS-provided physical RAM map with double address
Message-ID: <Pine.LNX.4.44.0204270748050.3714-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000017ffc000 (usable)
 BIOS-e820: 0000000017ffc000 - 0000000017fff000 (ACPI data)
 BIOS-e820: 0000000017fff000 - 0000000018000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
hm, page 17ffc000 reserved twice.

Erm, can this be any bad? I mean, Linux seems to work very well on that 
PC, but Windows 2000 couldn't even boot the install. Could this be the 
reason? Is there further nastiness to expect?

Regards,
Thunder
-- 
                                                  Thunder from the hill.
Not a citizen of any town.                   Not a citizen of any state.
Not a citizen of any country.               Not a citizen of any planet.
                         Citizen of our universe.

