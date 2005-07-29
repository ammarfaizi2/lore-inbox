Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262482AbVG2Hy0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262482AbVG2Hy0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 03:54:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262506AbVG2HyR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 03:54:17 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:44222 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262505AbVG2HyD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 03:54:03 -0400
Date: Fri, 29 Jul 2005 09:53:47 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Andrey Borzenkov <arvidjaar@mail.ru>
cc: linux-kernel@vger.kernel.org
Subject: Re: Syncing single filesystem (slow USB writing)
In-Reply-To: <200507290731.32694.arvidjaar@mail.ru>
Message-ID: <Pine.LNX.4.61.0507290952180.26861@yvahk01.tjqt.qr>
References: <200507290731.32694.arvidjaar@mail.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Now, when full sync support for FATis in kernel, moutning with sync became 
>real pain. Writing speed dropped from 3MB/s to 30KB/s in my case (and I am 
>not alone).

Interesting. I mount all my USB drives and players with async option - and 
they do use vfat. There is no problem on unmount, they complete the sync. 
(Though btw, the drive's led still flashes after umount has returned.)
For USB 1.1 devices, it takes a little longer since the buffer cache or 
something like that is so big.



Jan Engelhardt
-- 
| Alphagate Systems, http://alphagate.hopto.org/
