Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132477AbRAJQzs>; Wed, 10 Jan 2001 11:55:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133048AbRAJQzi>; Wed, 10 Jan 2001 11:55:38 -0500
Received: from cannet.com ([206.156.188.2]:44298 "HELO mail.cannet.com")
	by vger.kernel.org with SMTP id <S132477AbRAJQzV>;
	Wed, 10 Jan 2001 11:55:21 -0500
Message-ID: <008b01c07b26$15069320$7930000a@hcd.net>
From: "Timothy A. DeWees" <whtdrgn@mail.cannet.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <007801c07b25$1695db20$7930000a@hcd.net>
Subject: Re: 2.2.18 reboots on high load.
Date: Wed, 10 Jan 2001 11:55:05 -0500
Organization: Himebaugh Consulting, Inc.
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I should make it clear that there are two hard drives.  One
1 Gb hard drive, and 1x14 Gb hard drive.  

 
----- Original Message ----- 
From: Timothy A. DeWees 
To: Linux Kernel 
Sent: Wednesday, January 10, 2001 11:47 AM
Subject: 2.2.18 reboots on high load.


Hello,

I have a 2.2.18 (with reiserfs patch), running on a Pentium 100

any time I get high disk writes or reads my system just reboots.
I have had it up and running with moderate disk activity (telnet
and small FTP's) for a week; however, when I write alot to the 
disk (100 Mb plus), the system just reboots.  I am also getting
kernel panics around every 3-4 times.  I tried writing to the disk
with Samba, and fith FTP.  I am running proFTP.  Please tell me
what I need to send you.  I will not that /proc/cpuinfo tells me that
my processor has a f00f bug?

The system is as follows.

Intel Pentium 100
32 Mb Ram
1Gb root partition - 32 Mb swap
14 Gb reiserfs partition

I am running Samba 2.0.7 and Apache 1.3.14 (with mod-ssl).

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
