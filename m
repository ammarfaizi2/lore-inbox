Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280957AbRKTIFY>; Tue, 20 Nov 2001 03:05:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280958AbRKTIFO>; Tue, 20 Nov 2001 03:05:14 -0500
Received: from femail48.sdc1.sfba.home.com ([24.254.60.42]:9365 "EHLO
	femail48.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S280957AbRKTIFF>; Tue, 20 Nov 2001 03:05:05 -0500
From: "Sameer K S" <kssameer@home.com>
To: "Akshat Kapoor" <akshat@mercurykr.com>, <linux-kernel@vger.kernel.org>
Subject: RE: Query - How to Send Signal to application from kernel module !
Date: Tue, 20 Nov 2001 00:05:08 -0800
Message-ID: <JPEEJKELOKAGJLNKDMJPCEAECJAA.kssameer@home.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <001401c17192$ebf8ce80$150d85a5@mercurykr.com>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You might want to check out async notification stuff at
http://www.xml.com/ldd/chapter/book/ch05.html#t4

Sameer.

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Akshat Kapoor
Sent: Monday, November 19, 2001 11:14 PM
To: linux-kernel@vger.kernel.org
Subject: Query - How to Send Signal to application from kernel module !


Hi All,
         I'm writing a network device driver.  I want to communicate with an
application running in user mode. I want to send a signal (using
something like kill) on which the application would be listening.
Subsequently the application will send an IOCTL call to the driver to fetch
the information.
Is it possible in Linux to send  a signal to an application from a driver ?
I've done this in Windows NT but Idont know how to do it in Linux. I
searched
the archives but couldn't find any relevant thread. I tried to use the kill
system call but when I compiled the driver with  <signal.h> it gave me all
sorts of errors. Also the equivalent signal.h in kernel source tree doesn't
have a proto for kill().
Am I missing something ?
Sorry if I'm asking something silly as I'm new to this but can somebody
kindly point me to the right direction ?

TIA,
Regards,
Akshat

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

