Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313842AbSDIL0M>; Tue, 9 Apr 2002 07:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313846AbSDIL0L>; Tue, 9 Apr 2002 07:26:11 -0400
Received: from pa215.tychy-biskupa.sdi.tpnet.pl ([217.96.211.215]:59344 "EHLO
	server.ze.com.pl") by vger.kernel.org with ESMTP id <S313842AbSDIL0K>;
	Tue, 9 Apr 2002 07:26:10 -0400
From: "Damian Wrobel" <dwrobel@ertel.com.pl>
To: <linux-kernel@vger.kernel.org>
Subject: RE: Compaq Alpha DS10 - Kernel 2.4.18
Date: Tue, 9 Apr 2002 13:25:56 +0200
Message-ID: <CDEOINGOFOFAOEOLKDEDOENACAAA.dwrobel@ertel.com.pl>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <000d01c1dfb0$0da74a30$010b10ac@sbp.uptime.at>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org 
>[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Oliver Pitzeier
>Sent: Tuesday, April 09, 2002 12:20 PM
>To: linux-kernel@vger.kernel.org
>Subject: Compaq Alpha DS10 - Kernel 2.4.18
>
>
>Hi all!
>
>I've got a really big problem with kernel 2.4.18 and 2.4.17 on
>an Alpha.
>
>I can compile, install and boot the kernel on my Alpha.
>But if I shutdown the machine without shutting down the
>system - I know this is crazy, but sometimes this happens...
>
>So if I'm this mad and restart the machine afterwards, I get
>a lot of fsck errors 'til the system give up and tell's me,
>that I have to check it with fsck myself.
>
>OK, I did so... fsck -y /dev/sda1 -> Works perfectly. After
>fsck has corrected more than 1000 errors I'm able to
>reboot the machine.
>
>And than: MY SYSTEM IS NO LONGER BOOTABLE. It's totally
>currupted...
>
>I never saw the filesystem curruption bug on Intel, but it
>sounds like this.
>
>Is this the same bug that was on Intel?
>Have I done something wrong?
>
>Are there any alpha-users in this list? :o))))
>
>Greetz, I look forward for answers,
> Oliver
>
>
>-

Think about one of journaling filesystems: ext3, reiserfs, xfs, jfs...

Regards,
Damian Wrobel
