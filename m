Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318001AbSGWJAv>; Tue, 23 Jul 2002 05:00:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318002AbSGWJAv>; Tue, 23 Jul 2002 05:00:51 -0400
Received: from moutvdom.kundenserver.de ([195.20.224.200]:58585 "EHLO
	moutvdomng3.kundenserver.de") by vger.kernel.org with ESMTP
	id <S318001AbSGWJAu>; Tue, 23 Jul 2002 05:00:50 -0400
Date: Tue, 23 Jul 2002 03:03:58 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Andre Hedrick <andre@linux-ide.org>
Subject: Uncleanness in 2.4 IDE
Message-ID: <Pine.LNX.4.44.0207230302580.3384-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

IDE in late 2.4 kernels always gives me things like this:

hdd: timeout waiting for DMA
hdd: ide_dma_timeout: Lets do it again!stat = 0xd0, dma_stat = 0x60
hdd: DMA disabled
hdd: ide_set_handler: handler not null; old=c021f610, new=c022db60
bug: kernel timer added twice at c021f552.

>From that moment the IDE cdrom becomes unuseable.

							Regards,
							Thunder
-- 
(Use http://www.ebb.org/ungeek if you can't decode)
------BEGIN GEEK CODE BLOCK------
Version: 3.12
GCS/E/G/S/AT d- s++:-- a? C++$ ULAVHI++++$ P++$ L++++(+++++)$ E W-$
N--- o?  K? w-- O- M V$ PS+ PE- Y- PGP+ t+ 5+ X+ R- !tv b++ DI? !D G
e++++ h* r--- y- 
------END GEEK CODE BLOCK------

