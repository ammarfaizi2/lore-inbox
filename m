Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316434AbSGNMsv>; Sun, 14 Jul 2002 08:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316500AbSGNMsu>; Sun, 14 Jul 2002 08:48:50 -0400
Received: from mailhub.fokus.gmd.de ([193.174.154.14]:30711 "EHLO
	mailhub.fokus.gmd.de") by vger.kernel.org with ESMTP
	id <S316434AbSGNMst>; Sun, 14 Jul 2002 08:48:49 -0400
Date: Sun, 14 Jul 2002 14:50:07 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.gmd.de>
Message-Id: <200207141250.g6ECo7Tv019057@burner.fokus.gmd.de>
To: linux-kernel@vger.kernel.org
Subject: Re: IDE/ATAPI in 2.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Alan Cox wrote:


>If you load ide-scsi they are run as ATAPI, whats the problem ? Just don't
>do that for very old ide cdroms or for some ide floppies

Sounds like you got the message to some extent.

Why don't think this to it's reasonable end: Use ATAPI for all modern
(1993..1995 or newer) drives and support what old drives can do - reading
data CD-ROM media via the IDE read interface. This can be done via
the ATA HD drive interface.

Jörg

 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.gmd.de		(work) chars I am J"org Schilling
 URL:  http://www.fokus.gmd.de/usr/schilling   ftp://ftp.fokus.gmd.de/pub/unix
