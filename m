Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264724AbSL0BmU>; Thu, 26 Dec 2002 20:42:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264729AbSL0BmT>; Thu, 26 Dec 2002 20:42:19 -0500
Received: from smtp002.mail.tpe.yahoo.com ([202.1.238.49]:57863 "HELO
	smtp002.mail.tpe.yahoo.com") by vger.kernel.org with SMTP
	id <S264724AbSL0BmT>; Thu, 26 Dec 2002 20:42:19 -0500
Message-ID: <003d01c2ad4a$54eb09f0$3716a8c0@taipei.via.com.tw>
From: "Joseph" <jospehchan@yahoo.com.tw>
To: "Oliver Neukum" <oliver@neukum.name>, <greg@kroah.com>
Cc: <linux-kernel@vger.kernel.org>
References: <002801c2acd2$edf6a870$3716a8c0@taipei.via.com.tw> <20021226174653.GA8229@kroah.com>
Subject: Re: [USB 2.0 problem] ASUS CD-RW cannot be mounted.
Date: Fri, 27 Dec 2002 09:50:23 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Are you sure you have all of the scsi modules you need loaded?  The
> dmesg output looks fine, what happens when you try to mount the drive?
> And does this drive work with older 2.5 kernels, or 2.4?

  I think I've made all scsi modules I need built-in kernel.
  (usbcore, ehci-hcd, usb-storage, sr_mod, sd_mod) Do I miss something?
  Also, I've tested the ASUS CD-RW under kernel 2.5.45 and it worked.
  But in the kernel 2.5.53, the system shows below when I try to mount the
CD-RW.
**   #mount /dev/scd0 /mnt/usb-cd
**   mount: /dev/scd0 is not a valid block device
  There is one thing I forgot to say before.
  I've checked the /proc/scsi/scsi file by running "cat" when I pluged the
device, and it shows below.
** Attached devices: none
 Thanks in advance.
BR,
  Joseph

-----------------------------------------------------------------
< ¨C¤Ñ³£ Yahoo!©_¼¯ >  www.yahoo.com.tw
