Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265269AbUHJNHR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265269AbUHJNHR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 09:07:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265264AbUHJNG5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 09:06:57 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:53227 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S265044AbUHJNDt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 09:03:49 -0400
Date: Tue, 10 Aug 2004 15:03:06 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Message-Id: <200408101303.i7AD36bD014078@burner.fokus.fraunhofer.de>
To: dwmw2@infradead.org, schilling@fokus.fraunhofer.de
Cc: James.Bottomley@steeleye.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de,
       eric@lammerts.org, linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: David Woodhouse <dwmw2@infradead.org>

>On Tue, 2004-08-10 at 14:47 +0200, Joerg Schilling wrote:
>> Cdrecord does not read /etc/cdrecord.conf

>And the world is flat.

>shinybook /home/dwmw2 $ strace -e open cdrecord -inq 2>&1 | grep /etc/cdrecord.conf
>open("/etc/cdrecord.conf", O_RDONLY)    = 3
>open("/etc/cdrecord.conf", O_RDONLY)    = 3
>open("/etc/cdrecord.conf", O_RDONLY)    = 3
>open("/etc/cdrecord.conf", O_RDONLY)    = 3

It seems that you like to constantly discredit yourself :-(

What you use if DEFINITELY NOT cdrecord.


Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.fraunhofer.de	(work) chars I am J"org Schilling
 URL:  http://www.fokus.fraunhofer.de/usr/schilling ftp://ftp.berlios.de/pub/schily
