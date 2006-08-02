Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750946AbWHBKgQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750946AbWHBKgQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 06:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750898AbWHBKgF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 06:36:05 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:42501 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1750895AbWHBKgD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 06:36:03 -0400
Date: Wed, 2 Aug 2006 10:18:03 +0000
From: Pavel Machek <pavel@suse.cz>
To: Harald Dunkel <harald.dunkel@t-online.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18-rc2, problem to wake up spinned down drive?
Message-ID: <20060802101803.GH7601@ucw.cz>
References: <44CC9F7E.8040807@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44CC9F7E.8040807@t-online.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I tried to spin down my harddisk using hdparm, but when it is
> supposed to spin up again, then it is blocked for quite some
> time. dmesg says:
> 
> ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> ata1.00: (BMDMA stat 0x20)
> ata1.00: tag 0 cmd 0xca Emask 0x4 stat 0x40 err 0x0 (timeout)
> ata1: port is slow to respond, please be patient
> ata1: port failed to respond (30 secs)
> ata1: soft resetting port
> ata1.00: configured for UDMA/133
> ata1: EH complete
> SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
> sda: Write Protect is off
> sda: Mode Sense: 00 3a 00 00
> SCSI device sda: drive cache: write back
> 
> The disk is a SAMSUNG SP1614C.
> 
> 
> On another machine (with a SAMSUNG SP2504C inside) there is no
> such problem: The disk is back after just a few seconds.

How do you manage to spindown SATA disks? I tried hdparm -y, but that
did not work iirc.
							Pavel

-- 
Thanks for all the (sleeping) penguins.
