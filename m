Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316456AbSGNOGZ>; Sun, 14 Jul 2002 10:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316677AbSGNOGY>; Sun, 14 Jul 2002 10:06:24 -0400
Received: from mailhub.fokus.gmd.de ([193.174.154.14]:2707 "EHLO
	mailhub.fokus.gmd.de") by vger.kernel.org with ESMTP
	id <S316456AbSGNOGX>; Sun, 14 Jul 2002 10:06:23 -0400
Date: Sun, 14 Jul 2002 16:07:41 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.gmd.de>
Message-Id: <200207141407.g6EE7fcL019119@burner.fokus.gmd.de>
To: alan@lxorguk.ukuu.org.uk, schilling@fokus.gmd.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: IDE/ATAPI in 2.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>From alan@lxorguk.ukuu.org.uk Fri Jul 12 22:22:45 2002

>On Fri, 2002-07-12 at 21:08, Joerg Schilling wrote:
>> There are enough other OS that use a common ATAPI/SCSI driver concept and
>> do not have the problems you vagely name but never really describe.

>There are lots that fudge around and pretend scsi is the block layer
>when it is not. That sort of misses the point and slows down high end
>raid cards.

It seems that you miss to understand the needed underlying driver structures.
SCSI is not a block layer, it is a generic transport.


>> I believe it's OK to drop support for 10 year old hardware in case this
>> is no important hardware that _really_ needs continued support (like
>> e.g. 9 track trapes).

>We support and people continue to use large amounts of ten year old
>hardware. Thats why children at quite a few schools have access to
>computing through things like LTSP. There are people actively
>maintaining much of this stuff too. 

I never agued to completely drop support for them. You cannot do decent
DAE with pre-1998 CD-ROM drives, so why try to support DAE for old drives?
Just use them as read-only DA drives.

>Some things such as ide tapes which have needs rather different to scsi
>tape are still being made and released in newer and larger forms.

If you have a IDE tape that acts as tape, it most likely uses SCSI 
tape commands. If it acts as a big floppy, it is not relevent in this
discussion.

>> ATA devices that are neither hard disks, nor do support ATAPI decently
>> are Y 1992 crap - so unless you like to have continued support for your
>> provate museum, what is the reason that you like to prevent a change
>> to a more usable driver interface?

>You still don't seem to understand the difference between a driver
>interface and a hardware layer. 

Well, from previous discussions with you, you did proove that this is exactly
what _you_ don't understand.




Jörg

 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.gmd.de		(work) chars I am J"org Schilling
 URL:  http://www.fokus.gmd.de/usr/schilling   ftp://ftp.fokus.gmd.de/pub/unix
