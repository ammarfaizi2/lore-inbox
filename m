Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267276AbUHEMrT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267276AbUHEMrT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 08:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266686AbUHEMrS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 08:47:18 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:18428 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S267218AbUHEMqD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 08:46:03 -0400
Date: Thu, 5 Aug 2004 14:45:23 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Message-Id: <200408051245.i75CjNfJ004517@burner.fokus.fraunhofer.de>
To: axboe@suse.de, schilling@fokus.fraunhofer.de
Cc: kernel@wildsau.enemy.org, linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>From axboe@suse.de  Thu Aug  5 14:05:22 2004

>> >Which, happily, is what already happens and why it works fine when you
>> >just do -dev=/dev/hdX. What should be removed is the warning that
>> >cdrecord spits out when you do this, and the whole ATAPI thing should
>> >just mirror ATA and scsi-linux-ata be killed completely.
>> 
>> Nice idea!
>> 
>> So please start with fixing ide-scsi for Linux-2.4 so Linux won't
>> panic() when trying to access CD/DVD-drives that are connected via a
>> PC-card interface using ide-scsi.

>Let me dig through my mail box and find that report. Hmm that's strange,
>you don't seem to have sent one. I'll just dig out the crystal ball and
>get cracking on that fix.

....I am not repsonsible for your mail box....

I send it to Alan Cox and to LKML.... a long toime ago (in 2000)

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.fraunhofer.de	(work) chars I am J"org Schilling
 URL:  http://www.fokus.fraunhofer.de/usr/schilling ftp://ftp.berlios.de/pub/schily
