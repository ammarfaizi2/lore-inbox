Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318006AbSGLUIJ>; Fri, 12 Jul 2002 16:08:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318007AbSGLUII>; Fri, 12 Jul 2002 16:08:08 -0400
Received: from mailhub.fokus.gmd.de ([193.174.154.14]:19950 "EHLO
	mailhub.fokus.gmd.de") by vger.kernel.org with ESMTP
	id <S318006AbSGLUHg>; Fri, 12 Jul 2002 16:07:36 -0400
Date: Fri, 12 Jul 2002 22:08:53 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.gmd.de>
Message-Id: <200207122008.g6CK8rTc018445@burner.fokus.gmd.de>
To: linux-kernel@vger.kernel.org
Subject: Re: IDE/ATAPI in 2.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Alan Cox wrote:

>> In favour of the scrap:
>> 
>> 1. HPA.
>> 2. Adam J. Richter.
>> 3. Marcin Dalecki (basically due to give up on the idea
>> of gradual unification).

>In other words nobody who understands IDE is for and everyone who 
>understands you can't actually get rid of ide-floppy, tape, cdrom internal
>support and knows about IDE is..


I am not sure if any of your statements before does proove that you have 
knowledge on IDE, you definitely seem to miss important knowledge about SCSI.

I hope that this will not result in missing the chance of converting
to a more useful driver concept.

There are enough other OS that use a common ATAPI/SCSI driver concept and
do not have the problems you vagely name but never really describe.

I believe it's OK to drop support for 10 year old hardware in case this
is no important hardware that _really_ needs continued support (like
e.g. 9 track trapes).

ATA devices that are neither hard disks, nor do support ATAPI decently
are Y 1992 crap - so unless you like to have continued support for your
provate museum, what is the reason that you like to prevent a change
to a more usable driver interface?

Jörg

 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.gmd.de		(work) chars I am J"org Schilling
 URL:  http://www.fokus.gmd.de/usr/schilling   ftp://ftp.fokus.gmd.de/pub/unix
