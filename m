Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280940AbRKTHOJ>; Tue, 20 Nov 2001 02:14:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280942AbRKTHN7>; Tue, 20 Nov 2001 02:13:59 -0500
Received: from [165.133.13.60] ([165.133.13.60]:18564 "EHLO
	india.mercurykr.com") by vger.kernel.org with ESMTP
	id <S280940AbRKTHNr>; Tue, 20 Nov 2001 02:13:47 -0500
Message-ID: <001401c17192$ebf8ce80$150d85a5@mercurykr.com>
From: "Akshat Kapoor" <akshat@mercurykr.com>
To: <linux-kernel@vger.kernel.org>
Subject: Query - How to Send Signal to application from kernel module !
Date: Tue, 20 Nov 2001 12:43:52 +0530
Organization: Mercury Corp. (Formerly Daewoo Telecom Ltd)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

