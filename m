Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316831AbSGNOTj>; Sun, 14 Jul 2002 10:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316836AbSGNOTi>; Sun, 14 Jul 2002 10:19:38 -0400
Received: from mailhub.fokus.gmd.de ([193.174.154.14]:60822 "EHLO
	mailhub.fokus.gmd.de") by vger.kernel.org with ESMTP
	id <S316831AbSGNOTh>; Sun, 14 Jul 2002 10:19:37 -0400
Date: Sun, 14 Jul 2002 16:20:55 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.gmd.de>
Message-Id: <200207141420.g6EEKtX4019135@burner.fokus.gmd.de>
To: alan@lxorguk.ukuu.org.uk, andersen@codepoet.org
Cc: linux-kernel@vger.kernel.org, schilling@fokus.gmd.de
Subject: Re: IDE/ATAPI in 2.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>From andersen@codepoet.org Sat Jul 13 07:49:29 2002

>On Fri Jul 12, 2002 at 10:17:21PM +0100, Alan Cox wrote:
>> CD burning is a side issue to stability and reliability. 
>> 
>> In terms of supporting old hardware most of that is irrelevant to cd
>> recording anyway, so why do you care ? What you actually need is a
>> generic interface for cd packet sending.

>A generic interface for cd packet sending?  Sounds useful.  So
>useful someone thought of it years ago, and called it the
>CDROM_SEND_PACKET ioctl.  Its been in the kernel since Aug 1999.
>What'll those crazy Linux CD-ROM people think of next?

We don't need just another unrelated interface but a generic
transort. CDROM_SEND_PACKET is not a generic interface, it is limited
to ATAPI CD-ROM's.


Jörg

 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.gmd.de		(work) chars I am J"org Schilling
 URL:  http://www.fokus.gmd.de/usr/schilling   ftp://ftp.fokus.gmd.de/pub/unix
