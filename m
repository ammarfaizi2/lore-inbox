Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129429AbQLaNe4>; Sun, 31 Dec 2000 08:34:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129450AbQLaNeq>; Sun, 31 Dec 2000 08:34:46 -0500
Received: from [62.90.5.51] ([62.90.5.51]:5644 "EHLO salvador.shunra.co.il")
	by vger.kernel.org with ESMTP id <S129429AbQLaNeh>;
	Sun, 31 Dec 2000 08:34:37 -0500
Message-ID: <F1629832DE36D411858F00C04F24847A035890@SALVADOR>
From: Gabi Davar <gabi@SHUNRA.co.il>
To: "'RAJESH BALAN'" <atmproj@yahoo.com>
Cc: "Linux Kernel Mailing List (E-mail)" <linux-kernel@vger.kernel.org>
Subject: RE: Posix MessageQ's
Date: Sun, 31 Dec 2000 15:06:59 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2448.0)
Content-Type: text/plain;
	charset="WINDOWS-1255"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rajesh,

POSIX Message Queues are not implemented yet in glibc v2.2 (POSIX semaphores
are partially implemented). Once glibc will support them, you could test for
their existence via sysctl() and the relevant defines. As far as I know,
Linux implements only SysV MQs. Solaris and True64 implement them though.

Best regards,
Gabi Davar
______________________________________
Shunra Software - R&D

> -----Original Message-----
> From: RAJESH BALAN [mailto:atmproj@yahoo.com]
> Sent: Sunday, December 31, 2000 6:47 AM
> To: linux-kernel@vger.kernel.org
> Subject: Posix MessageQ's
> 
> 
> Hi,
> Does linux support Posix Message Q's. Iam reffering
> richard stevens V2 for IPC.. The book said to include 
> <mqueue.h>, which i was not able to find. Iam using
> Linux 2.2.
> 
> Thanks,
> Rajesh balan
> 
> __________________________________________________
> Do You Yahoo!?
> Yahoo! Photos - Share your holiday photos online!
> http://photos.yahoo.com/
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
