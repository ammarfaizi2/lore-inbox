Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318045AbSGRAhG>; Wed, 17 Jul 2002 20:37:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318046AbSGRAhG>; Wed, 17 Jul 2002 20:37:06 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:28804 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id <S318045AbSGRAhF>; Wed, 17 Jul 2002 20:37:05 -0400
Date: Thu, 18 Jul 2002 02:39:47 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andre Hedrick <andre@linux-ide.org>,
       Klaus Dittrich <kladit@t-online.de>,
       linux mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19rc2 and Promise RAID controller
In-Reply-To: <Pine.SOL.4.30.0207180223130.12077-100000@mion.elka.pw.edu.pl>
Message-ID: <Pine.SOL.4.30.0207180237300.12077-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 18 Jul 2002, Bartlomiej Zolnierkiewicz wrote:

> Stupid me :-)
> Setting it on/off won't help :-)

Stupid^2, please set it on and change this #ifdef.

> Just change '#ifdef' around
> 	if (dev->class >> 8 == PCI_CLASS_STORAGE_RAID)
> in ide-pci.c to '#ifndef' and it should work.

Regards
--
Bartlomiej

