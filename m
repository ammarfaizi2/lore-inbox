Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262446AbTAJMKk>; Fri, 10 Jan 2003 07:10:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264907AbTAJMKk>; Fri, 10 Jan 2003 07:10:40 -0500
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:39686 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S262446AbTAJMKh>; Fri, 10 Jan 2003 07:10:37 -0500
Message-Id: <200301101209.h0AC9Ns16328@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Chrissie <x.chrissie.x@t-online.de>, mdharm-usb@one-eyed-alien.net,
       <linux-kernel@vger.kernel.org>, <sjr@debian.org>, <eyesee@gmx.net>,
       <anti@webhome.de>, <thomas.hechelhammer@t-online.de>
Subject: Re: Oops with usb-mass-storage
Date: Fri, 10 Jan 2003 14:09:15 +0200
X-Mailer: KMail [version 1.3.2]
References: <Pine.LNX.4.50.0301091702070.958-100000@balearen.x-tra-designs>
In-Reply-To: <Pine.LNX.4.50.0301091702070.958-100000@balearen.x-tra-designs>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9 January 2003 18:50, Chrissie wrote:
> Now, i get the following output in dmesg after switching the camera
> on: hub.c: connect-debounce failed, port 2 disabled
> hub.c: new USB device 00:07.2-2, assigned address 2
> scsi1 : SCSI emulation for USB Mass Storage devices
>   Vendor:           Model:                   Rev:
>   Type:   Direct-Access                      ANSI SCSI revision: 02
> WARNING: USB Mass Storage data integrity not assured
> USB Mass Storage device found at 2
>
> Looks quite good, i think.
>
> chrissie@balearen:~$ cat /proc/scsi/scsi
> Attached devices:
> Host: scsi0 Channel: 00 Id: 00 Lun: 00
>   Vendor: LITEON   Model: CD-ROM LTN301    Rev: ML35
>   Type:   CD-ROM                           ANSI SCSI revision: 02
> Host: scsi0 Channel: 00 Id: 01 Lun: 00
>   Vendor:          Model: CD-R/RW RW7120A  Rev: 1.10
>   Type:   CD-ROM                           ANSI SCSI revision: 02
> Host: scsi1 Channel: 00 Id: 00 Lun: 00
>   Vendor: DSC      Model: Card Reader      Rev:  .
>   Type:   Direct-Access                    ANSI SCSI revision: 02
>
> The device now seems to be recogniced, and the usb-storage-to-scsi
> seems to work as well.
>
> I was very happy so far. But when i enter the following:
>
> root@balearen:~# mount /dev/sda1 /mnt -t vfat
>
> i get an kernel oops after following additional output to the console

An oops? This is *the* first oops, please decode and post it to USB folks.
Subsequent oopses are of much less help...
--
vda
