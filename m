Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317018AbSGNTSy>; Sun, 14 Jul 2002 15:18:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317020AbSGNTSx>; Sun, 14 Jul 2002 15:18:53 -0400
Received: from mailhub.fokus.gmd.de ([193.174.154.14]:43750 "EHLO
	mailhub.fokus.gmd.de") by vger.kernel.org with ESMTP
	id <S317018AbSGNTSw>; Sun, 14 Jul 2002 15:18:52 -0400
Date: Sun, 14 Jul 2002 21:20:09 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.gmd.de>
Message-Id: <200207141920.g6EJK9qm019370@burner.fokus.gmd.de>
To: andersen@codepoet.org, schilling@fokus.gmd.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: IDE/ATAPI in 2.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Erik Andersen <andersen@codepoet.org>

>> >cdrecord should use the CDROM_SEND_PACKET ioctl, then it would
>> >work regardless,
>> 
>> This only prooves that you are uninformed :-(

>No.  This only proves _you_ have not tried it.  I've used the
>CDROM_SEND_PACKET ioctl on both SCSI and ATAPI cdrom devices.
>What do you need to do in cdrecord that cannot be done with it?

The only reason, why I did add support for it was to be able
to use a CD writer in my notbook circumventing the driver bugs
that prevent to use ise-scsi on top of PCATA.

Jörg

 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.gmd.de		(work) chars I am J"org Schilling
 URL:  http://www.fokus.gmd.de/usr/schilling   ftp://ftp.fokus.gmd.de/pub/unix
