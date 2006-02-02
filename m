Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932159AbWBBQtv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159AbWBBQtv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 11:49:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932167AbWBBQtv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 11:49:51 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:3509 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932159AbWBBQtu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 11:49:50 -0500
Date: Thu, 2 Feb 2006 17:49:46 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Pavel Machek <pavel@ucw.cz>
cc: Bill Davidsen <davidsen@tmr.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: CD writing - related question
In-Reply-To: <20060201210433.GC8552@ucw.cz>
Message-ID: <Pine.LNX.4.61.0602021746090.13212@yvahk01.tjqt.qr>
References: <43DEA195.1080609@tmr.com> <20060201210433.GC8552@ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Please take this as a question to elicit information, not 
>> an invitation for argument.
>> 
>> In Linux currently:
>>  SCSI - liiks like SCSI

SCSI disks - pop up using the 'sd' driver
SCSI cdroms - sr

>>  USB - looks like SCSI

USB mass storage - pops up using the 'sd' driver
(USB cdrom - dunno, don't have any, presumably sr)

>>  Firewaire - looks like SCSI

Firewire disks - pop up using the 'sd' driver
(Firewire cdrom - dunno either, presumably sr)

>>  SATA - looks like SCSI

SATA disks - pop up using the 'sd' driver
(SATA cdrom - dunno either, presumably sr)

>> ATAPI - looks different unless ide-scsi used

(ATAPI disk - we don't have any, really :) )
ATAPI cdrom - pop up using
  - standard: 'ide-cd'
  - ide-scsi: 'sr'

I think that's where people stumble.


Jan Engelhardt
-- 
