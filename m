Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269647AbUIRVsN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269647AbUIRVsN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 17:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269648AbUIRVsN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 17:48:13 -0400
Received: from dennis.enea.se ([192.36.1.67]:12971 "EHLO dennis.enea.se")
	by vger.kernel.org with ESMTP id S269647AbUIRVsK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 17:48:10 -0400
From: =?iso-8859-1?Q?M=E5rten_Berggren?= <berg@enea.se>
To: "'Andre Tomt'" <andre@tomt.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: IDE: pdc202xx_new on Asus A7V333?
Date: Sat, 18 Sep 2004 23:48:00 +0200
Organization: Enea Open Systems
Message-ID: <000801c49dc9$2aefc340$810113ac@enea.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Importance: Normal
In-Reply-To: <414CA90F.2060106@tomt.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > which gives me the impression that the module has loaded 
> ok, but there 
> > is no matching entries in /proc/ide and pdcraid does not 
> find it. So 
> > is there any way to tell if it is working or not? (Should 
> there be an 
> > entry in /proc/ide?)
> 
> If it's a so-called "raid" version of the PDC, you may need to enable 
> CONFIG_PDC202XX_FORCE, as the firmware "hides" the drives.

Good point. I forgot to mention that it is indeed sold as a RAID
system (and it seems to work under XP Pro) and that I have selected
"Ignore BIOS port disabled setting on FastTrak" and "Use PCI DMA by
default when available".

(I also tried to switch PCI-slot for my networking card, but the
effect was that the PDC now shares interrupts with more on-board
USB devices instead of the network card.)

Thanks

Mårten Berggren

