Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751162AbWFLSEU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162AbWFLSEU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 14:04:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751005AbWFLSEU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 14:04:20 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:26532 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750802AbWFLSEU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 14:04:20 -0400
Date: Mon, 12 Jun 2006 20:04:10 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Markus Biermaier <mbier@office-m.at>
cc: linux-kernel@vger.kernel.org
Subject: Re: Can't Mount CF-Card on boot of 2.6.15 Kernel on EPIA - VFS:
 Cannot open root device
In-Reply-To: <0CB396BB-A11B-4191-982F-8C0B89F848D6@office-m.at>
Message-ID: <Pine.LNX.4.61.0606122003190.7959@yvahk01.tjqt.qr>
References: <0CB396BB-A11B-4191-982F-8C0B89F848D6@office-m.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi,
>
> I use an EPIA MII6000E motherboard with CF-Card as hard-drive.
> Since this device can't boot from CF-Card I boot from network via PXELINUX.
> Works fine for kernel 2.4.25.
>
> Now I want to change to kernel 2.6.15.4.
>
> I boot an initrd, execute "linuxrc" and at this point I can mount the CF-Card
> as "hde1", inspect the file-system, ...
>
Is the proper IDE driver loaded, are you sure the drive is still at hde1 
with 2.6?

> VFS: Cannot open root device "hde1" or unknown-block(0,0)
>                                                       ^^^
Lack of driver. If there was a driver, you would see a non-0,0 number at 
least.


Jan Engelhardt
-- 
