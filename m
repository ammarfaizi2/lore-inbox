Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317908AbSGPRd5>; Tue, 16 Jul 2002 13:33:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317911AbSGPRdz>; Tue, 16 Jul 2002 13:33:55 -0400
Received: from mailhub.fokus.gmd.de ([193.174.154.14]:18845 "EHLO
	mailhub.fokus.gmd.de") by vger.kernel.org with ESMTP
	id <S317908AbSGPRcy>; Tue, 16 Jul 2002 13:32:54 -0400
Date: Tue, 16 Jul 2002 19:34:12 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.gmd.de>
Message-Id: <200207161734.g6GHYCDk027351@burner.fokus.gmd.de>
To: Richard.Zidlicky@stud.informatik.uni-erlangen.de, schilling@fokus.gmd.de
Cc: andersen@codepoet.org, linux-kernel@vger.kernel.org
Subject: Re: IDE/ATAPI in 2.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Richard Zidlicky <Richard.Zidlicky@stud.informatik.uni-erlangen.de>

>> >Solaris vold? Thanks no, floppy access was so easy in SunOS before the 
>> >days of the volume manager.
>> 
>> .... and it is even simpler since vold is present. Call volcheck to tell vold
>> that the media changed or use a SCSI floppy which supports to tell the kernel
>> that a media change did happen.

>when it is properly configured which doesn't seem the common case.
>More often than not, things like accessing raw floppy images turn
>out to be a problem.

Being properly configured _is_ the common case if you don't change things 
manually. A standard Solaris system install from scratch will always result in 
a usable floppy drive that is handled as expected by vold.

Try to keep your fingers away from the vold configuration files after you did a 
clean install from scratch.

Jörg

 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.gmd.de		(work) chars I am J"org Schilling
 URL:  http://www.fokus.gmd.de/usr/schilling   ftp://ftp.fokus.gmd.de/pub/unix
