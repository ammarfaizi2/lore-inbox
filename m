Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267688AbTCBUBz>; Sun, 2 Mar 2003 15:01:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268256AbTCBUBz>; Sun, 2 Mar 2003 15:01:55 -0500
Received: from smtp03.web.de ([217.72.192.158]:33293 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id <S267688AbTCBUBz>;
	Sun, 2 Mar 2003 15:01:55 -0500
From: Michael Buesch <freesoftwaredeveloper@web.de>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Kernel 2.4.20 ide-scsi
Date: Sun, 2 Mar 2003 21:12:18 +0000
User-Agent: KMail/1.5
References: <3E625282.8010101@hanaden.com> <200303022038.53606.freesoftwaredeveloper@web.de> <3E6261C3.1020700@pobox.com>
In-Reply-To: <3E6261C3.1020700@pobox.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303022112.18566.freesoftwaredeveloper@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The standard solution, supported by all major distributions, is to supply
> 	hdX=ide-scsi
> on the kernel command line.
>
> There is no need to completely disable IDE-CD.  IDE-CD and IDE-SCSI can
> and do interoperate all the time.

Yes I thought this also until yesterday. :)
GRUB is configured this way in my case:
kernel (hd1,0)/linux root=/dev/md0 hdd=ide-scsi hdb=ide-scsi mce vga=779

But nevertheless it didn't work until I disabled
CONFIG_BLK_DEV_IDECD

It's somewhat strange, but.. :)

bye, Michael Buesch.
