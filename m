Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292150AbSCONAO>; Fri, 15 Mar 2002 08:00:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292178AbSCONAD>; Fri, 15 Mar 2002 08:00:03 -0500
Received: from nydalah028.sn.umu.se ([130.239.118.227]:46480 "EHLO
	x-files.giron.wox.org") by vger.kernel.org with ESMTP
	id <S292150AbSCOM7s>; Fri, 15 Mar 2002 07:59:48 -0500
Message-ID: <018901c1cc21$4a05b680$0201a8c0@homer>
From: "Martin Eriksson" <nitrax@giron.wox.org>
To: "Luigi Genoni" <kernel@Expansa.sns.it>,
        "Thunder from the hill" <thunder@ngforever.de>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0203151027560.24394-100000@Expansa.sns.it>
Subject: Re: HPT370 RAID-1 or Software RAID-1, what's "best"?
Date: Fri, 15 Mar 2002 13:59:49 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message -----
From: "Luigi Genoni" <kernel@Expansa.sns.it>
To: "Thunder from the hill" <thunder@ngforever.de>
Cc: <linux-kernel@vger.kernel.org>; "Martin Eriksson" <nitrax@giron.wox.org>
Sent: Friday, March 15, 2002 10:31 AM
Subject: Re: HPT370 RAID-1 or Software RAID-1, what's "best"?


> HPT370 IDE Raid is not really an hardware raid.
> It is a software Raid, since Linux does not use tha raid implementation
> that comes with the BIOS, but it uses softwareraid.

Well, even if it uses the BIOS raid, the CPU still has to do all the work.
You can easily spot true hardware raid because of the largish PCI boards,
and the big onboard processors. But this is a budget project... so no true
hardware raid.

I have come to a conclusion now though... as this machine will be used
without a monitor, any RAID arrays will be controlled via a web application.
To do this I need software RAID. Also, from the start it will be running the
following config:

Celeron-II CPU on an i815 board, 256MB RAM

P/M: Boot drive, temporary backup storage for CD-R backup (a few gigs)
P/S: RAID-1 disk #1

S/M: CD-RW drive
S/S: RAID-1 disk #2

In the future, if more storage is needed, there will propably be a three to
four-disk RAID-5 array with some/all disks on a promise controller.

Now this has gone off-topic, so please send replies only to me.

PS. the "mdadm" package is very nice. Among other things it solved the
"array is in use" problem.

