Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290902AbSASJoV>; Sat, 19 Jan 2002 04:44:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290905AbSASJoL>; Sat, 19 Jan 2002 04:44:11 -0500
Received: from nydalah028.sn.umu.se ([130.239.118.227]:12161 "EHLO
	x-files.giron.wox.org") by vger.kernel.org with ESMTP
	id <S290902AbSASJn4>; Sat, 19 Jan 2002 04:43:56 -0500
Message-ID: <007101c1a0cd$f1b734a0$0201a8c0@HOMER>
From: "Martin Eriksson" <nitrax@giron.wox.org>
To: "Anton Tinchev" <atl@top.bg>,
        "Linux Kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <3C49A8AD.2BBC7F7A@top.bg>
Subject: Re: Sharing Interrupt+HPT366 Problem on BP6
Date: Sat, 19 Jan 2002 10:44:51 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message -----
From: "Anton Tinchev" <atl@top.bg>
To: "Linux Kernel" <linux-kernel@vger.kernel.org>
Sent: Saturday, January 19, 2002 6:11 PM
Subject: Sharing Interrupt+HPT366 Problem on BP6


> There some problems with HPT366 maybe
>
> I used 3 disks for raid level 5
> 2 on the one of the channels
> 1 on the other channel
>
> Few second after starting raid (it start background recovery) the system
> locks totaly
> not even the Magic SysRq key works, only reset
>
> The HPT366 uses IRQ sharing (same IRQ on both chnnes)
>
> When i use only one channel, everiting is OK:
> 2 on the one of the channels
> 1 on the ordinary PIIX ide controler
>
> The configuration is:
> Abit BP6 MB
> Single Celeron 366 processor
> 1X10G hdd
> 3X60G hdd
> 256MB ram
> Davicom 100MB/s NIC
> S3 Trio3D AGP VGA
> Attached both dmesg:

<snip>

Have you tried the ATA patches from Andre Hedrick?

http://www.linuxdiskcert.org

Those cured all my HPT366 problems.

 _____________________________________________________
|  Martin Eriksson <nitrax@giron.wox.org>
|  MSc CSE student, department of Computing Science
|  Umeå University, Sweden

- ABIT BP6(RU) - 2xCeleron 400 - 128MB/PC100/C2 Acer
- Maxtor 10/5400/U33 HPT P/M - Seagate 6/5400/U33 HPT S/M
- 2xDE-530TX - 1xTulip - Linux 2.4.17+ide+preempt

