Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317026AbSGNTQx>; Sun, 14 Jul 2002 15:16:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317030AbSGNTQw>; Sun, 14 Jul 2002 15:16:52 -0400
Received: from mailhub.fokus.gmd.de ([193.174.154.14]:14054 "EHLO
	mailhub.fokus.gmd.de") by vger.kernel.org with ESMTP
	id <S317026AbSGNTQv>; Sun, 14 Jul 2002 15:16:51 -0400
Date: Sun, 14 Jul 2002 21:18:08 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.gmd.de>
Message-Id: <200207141918.g6EJI8kj019362@burner.fokus.gmd.de>
To: andersen@codepoet.org, schilling@fokus.gmd.de
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: IDE/ATAPI in 2.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Erik Andersen <andersen@codepoet.org>

>> We don't need just another unrelated interface but a generic
>> transort. CDROM_SEND_PACKET is not a generic interface, it is limited
>> to ATAPI CD-ROM's.

>Wrong.  It is a _generic CD-ROM packet interface.  Thanks for not even
>spending the two seconds it would take reading the kernel source code
>to discover this.

>$ grep -l CDC_GENERIC_PACKET drivers/scsi/sr.c drivers/ide/ide-cd.c 
>drivers/scsi/sr.c
>drivers/ide/ide-cd.c

That does not change anything.

Having a transport of limited usability is a problem for libscg.

BTW: If it turns out that people are interested in useful discussions, 
I may put more effort in reading current Linux kernel sources.

Jörg

 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.gmd.de		(work) chars I am J"org Schilling
 URL:  http://www.fokus.gmd.de/usr/schilling   ftp://ftp.fokus.gmd.de/pub/unix
