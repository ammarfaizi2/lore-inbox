Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751415AbWHXNM1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751415AbWHXNM1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 09:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbWHXNM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 09:12:27 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:30158 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1751415AbWHXNM0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 09:12:26 -0400
Date: Thu, 24 Aug 2006 15:10:33 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Daniel Rodrick <daniel.rodrick@gmail.com>
cc: linux-kernel@vger.kernel.org, kernelnewbies <kernelnewbies@nl.linux.org>,
       linux-newbie@vget.kernel.org, satinder.jeet@gmail.com
Subject: Re: Generic Disk Driver in Linux
In-Reply-To: <292693080608240547w394bacc4l2410b6eba98d950b@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0608241506200.19927@yvahk01.tjqt.qr>
References: <292693080608240547w394bacc4l2410b6eba98d950b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> I was curious that can we develop a generic disk driver that could
> handle all the kinds of hard drives - IDE, SCSI, RAID et al?

ide_generic
sd_mod

All there, what more do you want?

> I thought we could use the BIOS interrupt 13H for this purpose,
>
I fail to see a BIOS on non-x86 computers.

> but ran into a LOT of real mode / protected mode issues.
>
Sure. We are not real mode.
Ever heard of BIOS limitations? If no, first check out 
http://www.pcguide.com/ref/hdd/bios/sizeGB8-c.html



Jan Engelhardt
-- 
