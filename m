Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266599AbUHIOTA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266599AbUHIOTA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 10:19:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266582AbUHIOR0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 10:17:26 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:19646 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S266617AbUHIOOw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 10:14:52 -0400
Date: Mon, 9 Aug 2004 16:13:55 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Message-Id: <200408091413.i79EDt9L010562@burner.fokus.fraunhofer.de>
To: paul@clubi.ie, schilling@fokus.fraunhofer.de
Cc: James.Bottomley@steeleye.com, axboe@suse.de, linux-kernel@vger.kernel.org,
       mj@ucw.cz
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>From: Paul Jakma <paul@clubi.ie>

>> Of course, ATAPI devices on Solaris are handled by the same
>> target drivers as e.g. those on 50 pin cables.

>Yes ATAPI is.

>> The ATA driver is implemented the way one would expect it by acting 
>> as a SCSI HBA.

>Yes, as does libata on Linux.

Then I would love to see a demo that uses /dev/sg* with a ATAPI drive 
using DMA for all related sector sizes.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.fraunhofer.de	(work) chars I am J"org Schilling
 URL:  http://www.fokus.fraunhofer.de/usr/schilling ftp://ftp.berlios.de/pub/schily
