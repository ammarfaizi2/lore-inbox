Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316185AbSEOICX>; Wed, 15 May 2002 04:02:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316189AbSEOICX>; Wed, 15 May 2002 04:02:23 -0400
Received: from a217-118-40-108.bluecom.no ([217.118.40.108]:35604 "EHLO
	mail.circlestorm.org") by vger.kernel.org with ESMTP
	id <S316185AbSEOICW>; Wed, 15 May 2002 04:02:22 -0400
Message-ID: <006601c1fbe6$d47594d0$0d01a8c0@studio2pw0bzm4>
From: "Dead2" <dead2@circlestorm.org>
To: "Tigran Aivazian" <tigran@veritas.com>, <syslinux@zytor.com>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0205141920420.1577-100000@einstein.homenet>
Subject: Re: Initrd or Cdrom as root
Date: Wed, 15 May 2002 10:02:15 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I suspect that whatever is he using for creating the images (what is this
> "isolinux.cfg"?) has modified the boot command line and that is why it
> fails. It works fine for me (and worked since the time I wrote it around
> 2.4.0 or so).

Your assumption is correct!

It seems that isolinux does not pass the append parameters at all.
The booting works fine when I made your patch use cdrom as root
no matter what.

> This is my isolinux.cfg file:
> ---
> DEFAULT zoac
>
> LABEL zoac
>     KERNEL /boot/bzImage
>     APPEND "enableapic rootcd=1"
> ---

-=Dead2=-

