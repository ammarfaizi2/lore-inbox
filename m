Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263769AbUHEMeZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263769AbUHEMeZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 08:34:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262328AbUHEMeY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 08:34:24 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:5363 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S267676AbUHEMaq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 08:30:46 -0400
Date: Thu, 5 Aug 2004 14:30:04 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Message-Id: <200408051230.i75CU4RC004440@burner.fokus.fraunhofer.de>
To: axboe@suse.de, kernel@wildsau.enemy.org
Cc: linux-kernel@vger.kernel.org, schilling@fokus.fraunhofer.de
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>From: Jens Axboe <axboe@suse.de>

>> this is the reason why the patch forces the ata (atapi?) driver. no
>> SCSI driver or configuring of ide-scsi required.

>Maybe newer version broke then. Until very recently, cdrecord worked
>just fine as-is and used SG_IO access method when you used open by
>device name. Which was just the way we wanted it.

>If that doesn't work now, I suggest you take it up with Joerg. It's a
>problem with his program.

It's a problem caused by the design in the Linux kernel and not a problem of
libscg or cdrecord. 

The point is that Linux constantly invents new ugly and unneeded things and
after I found a workaround, people try to prevent the workaround from
being usable. 

In 1998, I did send a patch against the sg.c driver that introduced
everything that is needed for Generic SCSI transport. I am still waiting 
for even the needed features to appear........

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.fraunhofer.de	(work) chars I am J"org Schilling
 URL:  http://www.fokus.fraunhofer.de/usr/schilling ftp://ftp.berlios.de/pub/schily
