Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932328AbWHOMg0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932328AbWHOMg0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 08:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932765AbWHOMg0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 08:36:26 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:61325 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932328AbWHOMgZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 08:36:25 -0400
Subject: Re: Daily crashes, incorrect RAID behaviour
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Carsten Otto <carsten.otto@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <13e988610608150436y6812f623p9919b2d5b1989427@mail.gmail.com>
References: <13e988610608150436y6812f623p9919b2d5b1989427@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 15 Aug 2006 13:57:01 +0100
Message-Id: <1155646621.24077.270.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-08-15 am 13:36 +0200, ysgrifennodd Carsten Otto:
> The system works normally and suddenly one disk does not respond.
> After a soft reboot the BIOS does not recognize the disk, here a hard
> reboot helps. Whenever I start my normal system in this situation, my

Rule of thumb (and a good one). If the soft reboot and BIOS cannot
recover the disk then the disk is the problem. There isn't really
anything we can tell the drive to do which should make it take a hike
and ignore a reset sequence.  (Should.. however..)

> DriveReadySeekComplete (I do not recall the exact words, sorry) for one disk

Pity the exact text is essential.

> However, after the upgrade to the new power supply the system worked
> fine for almost two weeks (then the weekly crashes started).

I assume you've run memtest86 and also checked temperatures look good
around all the disks.
