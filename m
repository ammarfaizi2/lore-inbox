Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751165AbWFMOtz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751165AbWFMOtz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 10:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbWFMOtz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 10:49:55 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:23518 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751165AbWFMOty (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 10:49:54 -0400
Date: Tue, 13 Jun 2006 16:49:52 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Markus Biermaier <mbier@office-m.at>
cc: linux-kernel@vger.kernel.org
Subject: Re: Can't Mount CF-Card on boot of 2.6.15 Kernel on EPIA - VFS:
 Cannot open root device
In-Reply-To: <2F9A5649-92B3-439A-83E4-39FC6C5B7BB7@office-m.at>
Message-ID: <Pine.LNX.4.61.0606131648390.14789@yvahk01.tjqt.qr>
References: <0CB396BB-A11B-4191-982F-8C0B89F848D6@office-m.at>
 <Pine.LNX.4.61.0606122003190.7959@yvahk01.tjqt.qr>
 <6988083B-3A0E-41F2-A1E4-B4A953B88705@office-m.at>
 <Pine.LNX.4.61.0606122105490.27755@yvahk01.tjqt.qr>
 <2F9A5649-92B3-439A-83E4-39FC6C5B7BB7@office-m.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> block/genhd.c:240: Warnung: implicit declaration of function `mutex_lock'
mutex_lock not available in 2.6.15

> So the result before the boot-panic is:
>
> ...
> here are the partitions available:
> 2100     500472 hde driver: ide-disk
>  2101     500440 hde1
> ...
> What does this mean?
>
It means the partitions are there.
Which leads us to the next question:
 Can you mount hde1 using -t auto within your initrd shell?


Jan Engelhardt
-- 
