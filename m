Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751167AbWAYNyY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbWAYNyY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 08:54:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbWAYNyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 08:54:24 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:2490 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751167AbWAYNyY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 08:54:24 -0500
Date: Wed, 25 Jan 2006 14:54:22 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: menuconfig elements unaligned
In-Reply-To: <20060122210524.2f25d0e5.rdunlap@xenotime.net>
Message-ID: <Pine.LNX.4.61.0601251453130.26305@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0601182118001.29502@yvahk01.tjqt.qr>
 <20060122210524.2f25d0e5.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> in Drivers > Network > 10 or 100Mbit, this shows up:
>> 
>>  [*] EISA, VLB, PCI and on board controllers
>>  < >   AMD PCnet32 PCI support
>>  < >   AMD 8111 (new PCI lance) support
>>  < >   Adaptec Starfire/DuraLAN support
>>  < >   Broadcom 4400 ethernet support (EXPERIMENTAL)
>>  < >   Reverse Engineered nForce Ethernet support (EXPERIMENTAL)
>>  < > Digi Intl. RightSwitch SE-X support
>>  < > EtherExpressPro/100 support (eepro100, original Becker driver)
>>  < > Intel(R) PRO/100+ support
>> 
>> Deactivating EISA would suggest that Digi Intl. and everything below would
>> remain visible, but they do not. If someone got the time to, please fix it.
>> Thanks.
>
>Like Sam replied, I don't see a problem.  But the indentation shown
>above isn't how I see it on-screen.  The Digi, EtherExpressPro/100,
>and Intel(R) PRO/100+ are all indented under EISA/VLB/PCI for me.

Shrug. Ok, this time, a vanilla 2.6.15 pulled fresh from <mirror 
of> kernel.org rather than a suse mod...

  +----------------------- Ethernet (10 or 100Mbit) ------------------------+
  |  Arrow keys navigate the menu.  <Enter> selects submenus --->.          |
  |  Highlighted letters are hotkeys.  Pressing <Y> includes, <N> excludes, |
  |  <M> modularizes features.  Press <Esc><Esc> to exit, <?> for Help, </> |
  |  for Search.  Legend: [*] built-in  [ ] excluded  <M> module  < >       |
  | +^(-)-----------------------------------------------------------------+ |
  | |[*] EISA, VLB, PCI and on board controllers                          | |
  | |< >   AMD PCnet32 PCI support                                        | |
  | |< >   AMD 8111 (new PCI lance) support                               | |
  | |< >   Adaptec Starfire/DuraLAN support                               | |
  | |< >   Ansel Communications EISA 3200 support (EXPERIMENTAL)          | |
  | |< >   Apricot Xen-II on board Ethernet                               | |
  | |< >   Broadcom 4400 ethernet support (EXPERIMENTAL)                  | |
  | |< >   Reverse Engineered nForce Ethernet support (EXPERIMENTAL)      | |
  | |< > CS89x0 support                                                   | |
  | |< > Digi Intl. RightSwitch SE-X support                              | |
  | |< > EtherExpressPro/100 support (eepro100, original Becker driver)   | |
  | +v(+)-----------------------------------------------------------------+ |
  +-------------------------------------------------------------------------+
  |                    <Select>    < Exit >    < Help >                     |
  +-------------------------------------------------------------------------+


Jan Engelhardt
-- 
| Alphagate Systems, http://alphagate.hopto.org/
| jengelh's site, http://jengelh.hopto.org/
