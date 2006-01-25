Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932096AbWAYSZL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096AbWAYSZL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 13:25:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932097AbWAYSZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 13:25:10 -0500
Received: from smtp-103-wednesday.nerim.net ([62.4.16.103]:54284 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S932082AbWAYSZJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 13:25:09 -0500
Date: Wed, 25 Jan 2006 19:25:13 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Randy Dunlap <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org
Subject: Re: menuconfig elements unaligned
Message-Id: <20060125192513.73e06f60.khali@linux-fr.org>
In-Reply-To: <Pine.LNX.4.61.0601251453130.26305@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0601182118001.29502@yvahk01.tjqt.qr>
	<20060122210524.2f25d0e5.rdunlap@xenotime.net>
	<Pine.LNX.4.61.0601251453130.26305@yvahk01.tjqt.qr>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jan, all,

> Shrug. Ok, this time, a vanilla 2.6.15 pulled fresh from <mirror 
> of> kernel.org rather than a suse mod...
> 
>   +----------------------- Ethernet (10 or 100Mbit) ------------------------+
>   |  Arrow keys navigate the menu.  <Enter> selects submenus --->.          |
>   |  Highlighted letters are hotkeys.  Pressing <Y> includes, <N> excludes, |
>   |  <M> modularizes features.  Press <Esc><Esc> to exit, <?> for Help, </> |
>   |  for Search.  Legend: [*] built-in  [ ] excluded  <M> module  < >       |
>   | +^(-)-----------------------------------------------------------------+ |
>   | |[*] EISA, VLB, PCI and on board controllers                          | |
>   | |< >   AMD PCnet32 PCI support                                        | |
>   | |< >   AMD 8111 (new PCI lance) support                               | |
>   | |< >   Adaptec Starfire/DuraLAN support                               | |
>   | |< >   Ansel Communications EISA 3200 support (EXPERIMENTAL)          | |
>   | |< >   Apricot Xen-II on board Ethernet                               | |
>   | |< >   Broadcom 4400 ethernet support (EXPERIMENTAL)                  | |
>   | |< >   Reverse Engineered nForce Ethernet support (EXPERIMENTAL)      | |
>   | |< > CS89x0 support                                                   | |
>   | |< > Digi Intl. RightSwitch SE-X support                              | |
>   | |< > EtherExpressPro/100 support (eepro100, original Becker driver)   | |
>   | +v(+)-----------------------------------------------------------------+ |
>   +-------------------------------------------------------------------------+
>   |                    <Select>    < Exit >    < Help >                     |
>   +-------------------------------------------------------------------------+

I reported this problem already:
http://lkml.org/lkml/2005/12/27/119

And the fix was merged 13 days ago:
http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=fd85d765b75db608500c783e5bc41b63627957c8

So it's in 2.6.16-rc1 but not in 2.6.15 (nor 2.6.15.1).

Hope that helps,
-- 
Jean Delvare
