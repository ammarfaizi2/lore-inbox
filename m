Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262388AbVAPCMO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262388AbVAPCMO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 21:12:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262401AbVAPCF5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 21:05:57 -0500
Received: from [81.2.110.250] ([81.2.110.250]:899 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S262397AbVAPCDJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 21:03:09 -0500
Subject: Re: SATA disk dead? ATA: abnormal status 0x59 on port 0xE407
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Erik Steffl <steffl@bigfoot.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <41E97C3D.3020104@bigfoot.com>
References: <41E97C3D.3020104@bigfoot.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105830698.15835.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 16 Jan 2005 00:58:35 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2005-01-15 at 20:25, Erik Steffl wrote:
>    I got these errors when accessing SATA disk (via scsi):
> 
> Jan 15 11:56:50 jojda kernel: ata2: command 0x25 timeout, stat 0x59 
> host_stat 0x21
> Jan 15 11:56:50 jojda kernel: ata2: status=0x59 { DriveReady 
> SeekComplete DataRequest Error }
> Jan 15 11:56:50 jojda kernel: ata2: error=0x40 { UncorrectableError }

Bad sector - the disk has lost the data on some blocks. Thats a physical
disk failure.

