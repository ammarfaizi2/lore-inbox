Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266198AbUHGACI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266198AbUHGACI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 20:02:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268148AbUHGACI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 20:02:08 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:43467 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S266198AbUHGACE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 20:02:04 -0400
Date: Sat, 7 Aug 2004 02:01:25 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Message-Id: <200408070001.i7701PSa006663@burner.fokus.fraunhofer.de>
To: mj@ucw.cz, schilling@fokus.fraunhofer.de
Cc: James.Bottomley@steeleye.com, axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Martin Mares <mj@ucw.cz>

>> Let me lead you to the right place to look for:
>> 
>> 	The CAM interface (which is from the SCSI standards group)
>> 	usually is implemeted in a way that applications open /dev/cam and
>> 	later supply bus, target and lun in order to get connected
>> 	to any device on the system that talks SCSI.
>> 
>> Let me repeat: If you believe that this is a bad idea, give very good reasons.

>There is one: hotplug. The physical topology of buses where all the SCSI-like
>devices (being it ATAPI devices, iSCSI, USB disks or other such beasts)
>are connected is too complex, so every attempt to map them to the
>(bus, target, lun) triplets in any sane way is destined to fail.

I see always the same answers from Linux people who don't know anyrthing than
their belly button :-(

Chek Solaris to see that your statements are wrong.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.fraunhofer.de	(work) chars I am J"org Schilling
 URL:  http://www.fokus.fraunhofer.de/usr/schilling ftp://ftp.berlios.de/pub/schily
