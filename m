Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317819AbSGPMtD>; Tue, 16 Jul 2002 08:49:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317814AbSGPMtB>; Tue, 16 Jul 2002 08:49:01 -0400
Received: from mailhub.fokus.gmd.de ([193.174.154.14]:60326 "EHLO
	mailhub.fokus.gmd.de") by vger.kernel.org with ESMTP
	id <S317798AbSGPMsK>; Tue, 16 Jul 2002 08:48:10 -0400
Date: Tue, 16 Jul 2002 14:49:26 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.gmd.de>
Message-Id: <200207161249.g6GCnQZ9021743@burner.fokus.gmd.de>
To: schilling@fokus.gmd.de, vojtech@suse.cz
Cc: James.Bottomley@steeleye.com, linux-kernel@vger.kernel.org
Subject: Re: IDE/ATAPI in 2.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From vojtech@ucw.cz Tue Jul 16 13:59:27 2002

>> It would help, if somebody would correct the current SCSI addressng scheme used 
>> in Linux. Linux currently uses something called BUS/channel/target/lun.
>> This does not reflect reality.
>> 
>> What Linux calls a SCSI bus is definitely not a SCSI bus but a SCSI HBA card.
>> What Linux calls a channel really is one of possibly more SCSI busses going
>> off one of the SCSI HBA cards. It makes sense to just count SCSI busses.

>Well, no. It doesn't. Because the numbers will change if you add a card
>(even at runtime - hotplugging USB SCSI is something real happening
>today. And that'd be a very bad thing.

It hey change, then this is a Linux kernel problem. On Solaris they don't 
change because Solaris manages /etc/path_to_inst

Jörg

 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.gmd.de		(work) chars I am J"org Schilling
 URL:  http://www.fokus.gmd.de/usr/schilling   ftp://ftp.fokus.gmd.de/pub/unix
