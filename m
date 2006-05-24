Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932485AbWEXAJ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932485AbWEXAJ7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 20:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932488AbWEXAJ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 20:09:59 -0400
Received: from smtpq1.tilbu1.nb.home.nl ([213.51.146.200]:38296 "EHLO
	smtpq1.tilbu1.nb.home.nl") by vger.kernel.org with ESMTP
	id S932485AbWEXAJ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 20:09:58 -0400
Message-ID: <4473A498.4070101@keyaccess.nl>
Date: Wed, 24 May 2006 02:11:04 +0200
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: libata PATA patch update
References: <1147104400.3172.7.camel@localhost.localdomain> <445FD8D4.9030106@keyaccess.nl> <44739A36.90701@keyaccess.nl>
In-Reply-To: <44739A36.90701@keyaccess.nl>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rene Herman wrote:

>> CD and DVD ROMs are also working fine, including readcd and CDDA.
> 
> Well, other than spamming the kernel message buffer into oblivion. Must
> have missed these last time around

Confirmed. Realised I was on 2.6.17-rc4-ide1 now, and 2.6.17-rc3-ide1 last
time, but I just downgraded and these messages are indeed also present on
2.6.17-rc3-ide1.

> but cdparanoia (regular cdparanoia) triggers tons and tons of these, with
> both sr0 (hdc, a CD-RW) and sr1 (hdd, DVD-ROM):
> 
> sg_write: data in/out 56/56 bytes for SCSI command 0x12--guessing data in;
>   program cdparanoia not setting count and/or reply_len properly
> sg_write: data in/out 26/26 bytes for SCSI command 0x5a--guessing data in;
>   program cdparanoia not setting count and/or reply_len properly
> sg_write: data in/out 12/12 bytes for SCSI command 0x43--guessing data in;
>   program cdparanoia not setting count and/or reply_len properly
> sg_write: data in/out 12/12 bytes for SCSI command 0x43--guessing data in;
>   program cdparanoia not setting count and/or reply_len properly
> sg_write: data in/out 12/12 bytes for SCSI command 0x43--guessing data in;
>   program cdparanoia not setting count and/or reply_len properly
> sg_write: data in/out 12/12 bytes for SCSI command 0x43--guessing data in;
>   program cdparanoia not setting count and/or reply_len properly
> sg_write: data in/out 12/12 bytes for SCSI command 0x43--guessing data in;
>   program cdparanoia not setting count and/or reply_len properly
> sg_write: data in/out 12/12 bytes for SCSI command 0x43--guessing data in;
>   program cdparanoia not setting count and/or reply_len properly
> sg_write: data in/out 12/12 bytes for SCSI command 0x43--guessing data in;
>   program cdparanoia not setting count and/or reply_len properly
> sg_write: data in/out 12/12 bytes for SCSI command 0x43--guessing data in;
>   program cdparanoia not setting count and/or reply_len properly
> printk: 106 messages suppressed.
> sg_write: data in/out 30576/30576 bytes for SCSI command 0xbe--guessing 
> data in;
>   program cdparanoia not setting count and/or reply_len properly
> printk: 1087 messages suppressed.
> sg_write: data in/out 16464/16464 bytes for SCSI command 0xbe--guessing 
> data in;
>   program cdparanoia not setting count and/or reply_len properly
> printk: 1147 messages suppressed.
> sg_write: data in/out 30576/30576 bytes for SCSI command 0xbe--guessing 
> data in;
>   program cdparanoia not setting count and/or reply_len properly

Rene.
