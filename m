Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751467AbWDYIod@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751467AbWDYIod (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 04:44:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750926AbWDYIoc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 04:44:32 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:42629 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751462AbWDYIoc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 04:44:32 -0400
Date: Tue, 25 Apr 2006 10:44:09 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Pierre Ossman <drzeus-list@drzeus.cx>, Ram <vshrirama@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: SD Card not mounting
In-Reply-To: <20060424123621.GA16464@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.61.0604251042240.26791@yvahk01.tjqt.qr>
References: <8bf247760604240215j12af040dk4e695dbe03d89a83@mail.gmail.com>
 <444CC1E2.5000101@drzeus.cx> <20060424123621.GA16464@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > mount /dev/mmcblk0 /mnt/mmc -t vfat
>> > mount: Mounting /dev/mmcblk0 on /mnt/mmc failed: Device or resource busy
>> 
>and I doubt that "Device or resource busy" has anything at all to do
>with MMC.  Sounds more like a userspace issue - maybe two filesystems
>are being mounted on /mnt/mmc?  Reading the mount(2) man page gives
>some ideas what this error may mean.
>
There are usually no problems with mounting something over a mountpoint. 
The side effect is just that you can't easily access the now-hidden mount.


Jan Engelhardt
-- 
