Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286005AbRLHWTD>; Sat, 8 Dec 2001 17:19:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286006AbRLHWSy>; Sat, 8 Dec 2001 17:18:54 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:28938 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S286005AbRLHWSq>; Sat, 8 Dec 2001 17:18:46 -0500
Subject: Re: SCSI????
To: Astinus@netcabo.pt (Miguel Maria Godinho de Matos)
Date: Sat, 8 Dec 2001 22:28:01 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <EXCH01SMTP01xavjrRZ0000bfbc@smtp.netcabo.pt> from "Miguel Maria Godinho de Matos" at Dec 08, 2001 10:13:59 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Cpww-0002wT-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have recently compiled the kernel 2.4.16 in a P2 running red hat 7.2.
> 
> whenever linux boots it trys to load the Scsi modules for the new kernel but 
> it [ fails ], i figure this is because my previous had scsi as module and now 
> it isn't a module but a integrated part of the kernel, so i turned off  the 
> scsi from the service manager. ( don't know if i am right though ).

Did you accidentally copy the initrd= line from the old kernel to the new
in your lilo or grub setup ?

Its a harmless warning anyway.

> second, how do i make sure scsi support is actually running???

cat /proc/scsi/scsi

> third, if scsi is running and if i have the usb mass storage built into the 
> kernel, why doesn't my cd-rw appear listed  as a scsi connected device as it 
> should??

That I don't know. Does it show up on /proc/bus/usb ?
