Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266613AbUHIO07@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266613AbUHIO07 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 10:26:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266635AbUHIOZI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 10:25:08 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:39619 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S266613AbUHIOWr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 10:22:47 -0400
Date: Mon, 9 Aug 2004 16:21:44 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Message-Id: <200408091421.i79ELiPS010580@burner.fokus.fraunhofer.de>
To: alan@lxorguk.ukuu.org.uk, axboe@suse.de
Cc: James.Bottomley@steeleye.com, eric@lammerts.org,
       linux-kernel@vger.kernel.org, schilling@fokus.fraunhofer.de
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>From: Jens Axboe <axboe@suse.de>

>On Mon, Aug 09 2004, Alan Cox wrote:
>> On Llu, 2004-08-09 at 13:24, Joerg Schilling wrote:
>> > On Linux, it is impossible to run cdrecord without root privilleges.
>> > Make cdrecord suid root, it has been audited....
>> 
>> Wrong. Although in part that is a bug in the kernel urgently needing
>> a fix.

>Even with that fixing, write privileges on the device would be enough.
>So root would still not be required.

Please try again after you had a look into the cdrtools sources.

Cdrecord also needs privilleges to lock memory and to raise prioirity.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.fraunhofer.de	(work) chars I am J"org Schilling
 URL:  http://www.fokus.fraunhofer.de/usr/schilling ftp://ftp.berlios.de/pub/schily
