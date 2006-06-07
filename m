Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751178AbWFGSAj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbWFGSAj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 14:00:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185AbWFGSAj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 14:00:39 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:45522 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751178AbWFGSAj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 14:00:39 -0400
Date: Wed, 7 Jun 2006 20:00:37 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Ram Gupta <ram.gupta5@gmail.com>
cc: linux mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: booting without initrd
In-Reply-To: <728201270606070913g2a6b23bbj9439168a1d8dbca8@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0606071959210.13918@yvahk01.tjqt.qr>
References: <728201270606070913g2a6b23bbj9439168a1d8dbca8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I am trying to boot with 2.6.16  kernel at my desktop running fedora
> core 4 . It does not boot without initrd generating the message "VFS:
> can not open device "804" or unknown-block(8,4)
> Please append a correct "root=" boot option
> Kernel panic - not syncing : VFS:Unable to mount root fs on unknown-block(8,4)
>
> I have disabled the module support & built in all modules/drivers for
> ide/scsi/sata but it does not boot. I have to disable the module as I
> need a statically built  kernel.
>
Recently added patches that show you all filesystems should help 
identifying the cause. Maybe you still have something missing and the 
printk_all_partitions() patch could be helpful.

> If someone could describe the way to boot without initrd it will be great.


Jan Engelhardt
-- 
