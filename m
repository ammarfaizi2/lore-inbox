Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271741AbTGYIQq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 04:16:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271939AbTGYIQq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 04:16:46 -0400
Received: from icemserv.folkwang-hochschule.de ([193.175.156.129]:31749 "EHLO
	icemserv.folkwang-hochschule.de") by vger.kernel.org with ESMTP
	id S271741AbTGYIQo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 04:16:44 -0400
Date: Fri, 25 Jul 2003 10:31:52 +0200
From: Orm Finnendahl <finnendahl@folkwang-hochschule.de>
To: linux-kernel@vger.kernel.org
Subject: Partition check issue (againandagain??)
Message-ID: <20030725083152.GA1408@finnendahl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
X-Operating-System: Linux
Organization: Folkwang-Hochschule, Essen, Germany
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm trying to run a new (self-compiled) 2.4.21 kernel on my Acer
Notebook with Ali15x3 Chipset, revision 195 (C3) and experience a
freeze upon bootup at the partition check.

Kernel version <= 2.4.18 works fine on my laptop (including dma), all
kernels > 2.4.18 lock up at boot.

The partition check line shows: 

Partition check:
hda1 hda2 hda3 hda4 <

before it freezes. 

With the working 2.4.18 kernel the line shows:

Partition check:
hda1 hda2 hda3 hda4 <hda5 hda6>

hda5 and hda6 are swap and the main partition
respectively, running a reiserfs. 

I checked the mailing list and found some hints for 2.4.19 kernels,
but that bug doesn't seem to apply as my chipset revision is < C4,
apart from that it seems to be fixed in /drivers/ide/pci/alim15x3.c

Any ideas?

Please cc the mail to me. I tried to subscribe to the list an hour ago
but didn't get any reply yet.

Thanx,
Orm

