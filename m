Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265517AbTAWRok>; Thu, 23 Jan 2003 12:44:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265523AbTAWRok>; Thu, 23 Jan 2003 12:44:40 -0500
Received: from mailhub.fokus.gmd.de ([193.174.154.14]:39055 "EHLO
	mailhub.fokus.gmd.de") by vger.kernel.org with ESMTP
	id <S265517AbTAWRoj>; Thu, 23 Jan 2003 12:44:39 -0500
Date: Thu, 23 Jan 2003 18:52:24 +0100 (CET)
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Message-Id: <200301231752.h0NHqOM5001079@burner.fokus.gmd.de>
To: axboe@suse.de, greg@ulima.unil.ch
Cc: cdwrite@other.debian.org, linux-kernel@vger.kernel.org,
       schilling@fokus.fraunhofer.de
Subject: Re: Can't burn DVD under 2.5.59 with ide-cd
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From greg@ulima.unil.ch Thu Jan 23 18:51:42 2003
>   7 seconds.  0.98% done, estimate finish Thu Jan 23 18:51:05 2003
>   6 seconds.  1.22% done, estimate finish Thu Jan 23 18:51:46 2003
>   5 seconds.  1.46% done, estimate finish Thu Jan 23 18:52:14 2003
>   0 seconds. Operation starts.
>Waiting for reader process to fill input buffer ... input buffer ready.
>BURN-Free is ON.
>Starting new track at sector: 0
>Track 01:    4 of 4001 MB written (fifo  96%)  16.1x.cdrecord-prodvd: Success. write_g1: scsi sendcmd: no error
>CDB:  2A 00 00 00 08 B8 00 00 1F 00
>status: 0x2 (CHECK CONDITION)
>Sense Bytes:
>Sense Key: 0xFFFFFFFF [], Segment 0
>Sense Code: 0x00 Qual 0x00 (no additional sense information) Fru 0x0
>Sense flags: Blk 0 (not valid) 
>resid: 63488
>cmd finished after 0.007s timeout 100s


In one of my mails, I decribed why there are 2 bugs in the kernel.
Only one of them so far has been fixed. The sense data is still missing.

Jörg

 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.fhg.de		(work) chars I am J"org Schilling
 URL:  http://www.fokus.fhg.de/usr/schilling   ftp://ftp.berlios.de/pub/schily
