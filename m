Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316499AbSGNNGt>; Sun, 14 Jul 2002 09:06:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316500AbSGNNGs>; Sun, 14 Jul 2002 09:06:48 -0400
Received: from mailhub.fokus.gmd.de ([193.174.154.14]:49914 "EHLO
	mailhub.fokus.gmd.de") by vger.kernel.org with ESMTP
	id <S316499AbSGNNGs>; Sun, 14 Jul 2002 09:06:48 -0400
Date: Sun, 14 Jul 2002 15:08:06 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.gmd.de>
Message-Id: <200207141308.g6ED86GK019067@burner.fokus.gmd.de>
To: linux-kernel@vger.kernel.org
Subject: Re: IDE/ATAPI in 2.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>H. Peter Anvin wrote:

>hen *please* make a *compatible* interface available to user space. 
>This certainly can be done; the parallel port IDE interface stuff had 
>exactly such an interface (/dev/pg*) -- we could have a /dev/hg* 
>interface presumably.  That is an acceptable solution.

I would not call the /dev/pg* nterface a cmpatible interface.

It has advantages to the interface in the ide-cdrom driver in being
able to talk to different types of drives at the end, but it is
another incompatible user interface.

>Note again that this discussion (and it's a discussion, not a voting 
>session -- technical pros and cons is what applies) apply to ATAPI (SCSI 
>over IDE) only.  Alan has already brought up the fact of non-hard disk 
>non-ATAPI devices, and IMO those devices are explicitly out of scope. 

This is my idea too: CD-ROM drives should be accessed via ATAPI or 
handled as ATA disk.


Jörg

 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.gmd.de		(work) chars I am J"org Schilling
 URL:  http://www.fokus.gmd.de/usr/schilling   ftp://ftp.fokus.gmd.de/pub/unix
