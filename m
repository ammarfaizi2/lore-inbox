Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267450AbUHPFpz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267450AbUHPFpz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 01:45:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267449AbUHPFpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 01:45:46 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:54279 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S267445AbUHPFpn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 01:45:43 -0400
To: "Harald Dunkel" <harald.dunkel@t-online.de>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: amd64: Problems with vfat fs?
References: <411FA4E7.2010405@t-online.de>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Mon, 16 Aug 2004 14:45:29 +0900
In-Reply-To: <411FA4E7.2010405@t-online.de>
Message-ID: <874qn3iqkm.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3.50
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Harald Dunkel" <harald.dunkel@t-online.de> writes:

> 	cat DOS.img >/dev/sdd
> 	mount -t vfat /dev/sdd /mnt
> 	cp AWDFLASH.EXE FN85S235.BIN /mnt
> 	umount /mnt
> 
> The USB stick boots, but if I run AWDFLASH, then nothing
> happens. It justs sits there and doesn't do anything.
> 
> But if I try this instead
> 
> 	cp DOS.img FLASH.img
> 	mount -t vfat -o loop FLASH.img /mnt
> 	cp AWDFLASH.EXE FN85S235.BIN /mnt
> 	umount /mnt
> 	cat FLASH.img >/dev/sdd
> 
> then AWDFLASH works as expected.

Could you check difference of those disks?  Or could you send both
images to me?

And please send dmesg and .config.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
