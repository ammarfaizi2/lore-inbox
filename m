Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267666AbUHEMBL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267666AbUHEMBL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 08:01:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267662AbUHEL5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 07:57:13 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:2993 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S267666AbUHELy0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 07:54:26 -0400
Date: Thu, 5 Aug 2004 13:53:48 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Message-Id: <200408051153.i75BrmCp004333@burner.fokus.fraunhofer.de>
To: axboe@suse.de, kernel@wildsau.enemy.org
Cc: linux-kernel@vger.kernel.org, schilling@fokus.fraunhofer.de
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From axboe@suse.de  Wed Aug  4 14:58:33 2004

>> That's an extremely bad idea, you want to force ATA driver in either
>> case.

>Which, happily, is what already happens and why it works fine when you
>just do -dev=/dev/hdX. What should be removed is the warning that
>cdrecord spits out when you do this, and the whole ATAPI thing should
>just mirror ATA and scsi-linux-ata be killed completely.

Nice idea!

So please start with fixing ide-scsi for Linux-2.4 so Linux won't panic()
when trying to access CD/DVD-drives that are connected via a PC-card interface
using ide-scsi.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.fraunhofer.de	(work) chars I am J"org Schilling
 URL:  http://www.fokus.fraunhofer.de/usr/schilling ftp://ftp.berlios.de/pub/schily
