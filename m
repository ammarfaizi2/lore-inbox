Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287372AbRL3KJP>; Sun, 30 Dec 2001 05:09:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287370AbRL3KJF>; Sun, 30 Dec 2001 05:09:05 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:47110 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S287373AbRL3KIx>; Sun, 30 Dec 2001 05:08:53 -0500
Subject: Re: VCD/XA files not reading
To: gbj@theforce.com.au (Grahame Jordan)
Date: Sun, 30 Dec 2001 10:19:05 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1009702262.2223.32.camel@falcon> from "Grahame Jordan" at Dec 30, 2001 07:51:02 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Kd3Z-0000je-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> try to read the mpeg file (avseq01.dat) it fails.  There seems to be
> support for XA in include/linux/cdrom.h but it's not working for me.  I
> downloaded the same file to my HDD and it works fine.

XA sectors aren't supported by the base ISOfs code. The ioctl interface
lets you read these sectors and play videocd but you'll have to do the hard
work in user space.

