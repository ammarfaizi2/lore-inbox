Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266527AbSKORXk>; Fri, 15 Nov 2002 12:23:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266528AbSKORXk>; Fri, 15 Nov 2002 12:23:40 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:25263 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266527AbSKORXj>; Fri, 15 Nov 2002 12:23:39 -0500
Subject: Re: CD IO error
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: alan@cotse.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <YWxhbg==.a513a46732330fd5f834894ae7200923@1037378527.cotse.net>
References: <YWxhbg==.a513a46732330fd5f834894ae7200923@1037378527.cotse.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 15 Nov 2002 17:56:57 +0000
Message-Id: <1037383017.19987.44.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-11-15 at 16:42, Alan Willis wrote:
> 
>   I've been getting these messages since about 2.5.45.  I can't mount any
> cds at all.  Elvtune (util-linux-2.11r) also fails on /dev/hda which I'm
> running on, and /dev/hdc, my cdrom.
> 
> Any further info needed?

The log before the I/O error line

>  HDIO_GET_MULTCOUNT failed: Inappropriate ioctl for device

This is the right behaviour for a CD

>  HDIO_GETGEO failed: Inappropriate ioctl for device

Ditto

- so the hdparm is fine, but the I/O error probably isnt


