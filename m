Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280288AbRKNHfD>; Wed, 14 Nov 2001 02:35:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280281AbRKNHex>; Wed, 14 Nov 2001 02:34:53 -0500
Received: from [212.3.242.3] ([212.3.242.3]:63501 "HELO mail.i4gate.net")
	by vger.kernel.org with SMTP id <S280262AbRKNHei> convert rfc822-to-8bit;
	Wed, 14 Nov 2001 02:34:38 -0500
Message-Id: <5.1.0.14.2.20011114083532.00a816a8@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 14 Nov 2001 08:35:40 +0100
To: linux-kernel@vger.kernel.org
From: DevilKin <devilkin@gmx.net>
Subject: Re: usb-storage fails with datafab md2-usb (ide hdd on usb) on
  newer kernels >2.4.8
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm... I've been experiencing the very same thing, but with a Digicam that 
reports to the PC as a usb-storage device. Mount just hangs.... I haven't 
had the patience to wait for it to time out (especially if i need my pics 
fast)...

Rebooting/halting usually causes an oops with me (while mount is still 
hanging, that is)

DK

At 01:04 14/11/2001 +0100, you wrote:
>On Wed, Nov 14, 2001 at 12:41:23AM +0100, Christoph Kampe wrote:
>... very much, but not the Problemdescription.
>
>Hi again,
>sorry i forget to write what went wrong with the DataFab Storage.
>
>Actually, with 2.4.8 when i connect the usb-storage it loads all
>necessary modules and a mount takes less then 1second.
>
>With 2.4.15-pre4 it loads the three modules too but, it gives
> > kernel: usb-storage: *** thread sleeping.
> > kernel: scsi: device set offline - not ready or command retry failed after
> >   bus reset: host 0 channel 0 id 0 lun 0
> > kernel:  I/O error: dev 08:05, sector 0
>in my log.
>as i wrote in my last mail (last 10 lines)
>a mount won´t work, takes some time and breaks with
>"I/O error:dev 08:05, sector 0"
>
>I dont´t know exactly if it fails because of the usb-storage or the
>scsi_mod module.
>
>Regards
>Christoph
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

