Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315784AbSGNNAp>; Sun, 14 Jul 2002 09:00:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316456AbSGNNAo>; Sun, 14 Jul 2002 09:00:44 -0400
Received: from mailhub.fokus.gmd.de ([193.174.154.14]:33785 "EHLO
	mailhub.fokus.gmd.de") by vger.kernel.org with ESMTP
	id <S315784AbSGNNAo>; Sun, 14 Jul 2002 09:00:44 -0400
Date: Sun, 14 Jul 2002 15:02:02 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.gmd.de>
Message-Id: <200207141302.g6ED22G0019061@burner.fokus.gmd.de>
To: linux-kernel@vger.kernel.org
Subject: Re: IDE/ATAPI in 2.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Linus Torvalds wrote:

>I will violently oppose anything that implies that the IDE layer uses the
>SCSI layer normally.  No way, Jose. I'm all for scrapping, but the thing
>that should be scrapped is ide-scsi.

Nobody who has a technical backgroupd and knows what to do wuld ever
make such a proposal.

Instead, there needs to be one or more SCSI HA driver as part of the SCSI stack.
This driver also needs to deal with plain ATA in order to be able to
coordinate access.

Jörg

 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.gmd.de		(work) chars I am J"org Schilling
 URL:  http://www.fokus.gmd.de/usr/schilling   ftp://ftp.fokus.gmd.de/pub/unix
