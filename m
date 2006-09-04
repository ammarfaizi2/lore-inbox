Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964936AbWIDNm5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964936AbWIDNm5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 09:42:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964846AbWIDNm5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 09:42:57 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:57056 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1751382AbWIDNmz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 09:42:55 -0400
Date: Mon, 4 Sep 2006 15:35:41 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Tomasz Torcz <zdzichu@irc.pl>
cc: Grant Coady <gcoady.lk@gmail.com>, Jeff Garzik <jeff@garzik.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: PATA drivers queued for 2.6.19
In-Reply-To: <20060904123546.GB23978@irc.pl>
Message-ID: <Pine.LNX.4.61.0609041534210.17279@yvahk01.tjqt.qr>
References: <44FC0779.9030405@garzik.org> <po4of2pnhpc0325kqj2hd37b7eh3epcdsm@4ax.com>
 <Pine.LNX.4.61.0609041406140.21005@yvahk01.tjqt.qr> <20060904123546.GB23978@irc.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> Got udev?
>> 
>> /dev/disk/by-id/ata-ST3802110A_5LR13RN7-partX could be your friend.
>
>  Almost. It would alternate between "ata-" and "scsi-".

Well then label your partitions and use /dev/disk/by-label/ (harhar...)

You can also try by-uuid (FS UUID) (a214ecf5-6e06-47a8-bc6d-9cd9d6f10cd6) 
or by-path (pci-0000:00:1f.1-ide-0:0-part1).


Jan Engelhardt
-- 
