Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267650AbRGQXmq>; Tue, 17 Jul 2001 19:42:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267636AbRGQXmg>; Tue, 17 Jul 2001 19:42:36 -0400
Received: from gadolinium.btinternet.com ([194.73.73.111]:22735 "EHLO
	gadolinium.btinternet.com") by vger.kernel.org with ESMTP
	id <S267708AbRGQXmW>; Tue, 17 Jul 2001 19:42:22 -0400
Date: Wed, 18 Jul 2001 00:42:31 +0000 (GMT)
From: James Stevenson <mistral@stev.org>
To: "Jorg Pitts (306170)" <jorgp@bartnet.net>
cc: Linux-Kernel-Owner <linux-kernel@vger.kernel.org>
Subject: RE: serious cd writer kernel bug 2.4.x
In-Reply-To: <GBEALFKJGAFHFMBNFHAEGEBFCLAA.jorgp@bartnet.net>
Message-ID: <Pine.LNX.4.30.0107180038180.2075-100000@cyrix.stev.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

> I experience almost the exact same thing with my cd-rw.
> PlexWriter 8/4/32A, does the same thing, and if I compile the modules
> ide-scsi and scsi

> directly into the kernel, whenever I access the cd-rw at all (try to mount a
> valid filesystem) entire system locks and have to hard reboot.. I can access

i am not running modules but the ide-scsi stuff is compiled into the
kernel both drives are running under the scsi-emu.
can you also access the cd rom fine under linux.

the cd-rom works fine for me
as soon as i touch the writer it dies.

> boot). I am using stock Mandrake 8.0 with 2.4.6-ac2 kernel. I can run
> cdrecord --scanbus and it sees the cd-rw fine

i am also running mandrake 8.0 and cdrecord works up to that point
i have seen it crash under.

2.4.3
2.4.4
2.4.5
2.4.5-ac15
2.4.6
2.4.6-ac5

i have not tried earlery kernels for various other resons.

> hda - disk 1
> hdb - disk 2
> hdc - cd-rom
> hdd - cd-rw

almost like that but its
hda - disk 1
hdb - disk 2
hdc - cd writer
hdd - cd rom


-- 
---------------------------------------------
Web: http://www.stev.org
Mobile: +44 07779080838
E-Mail: mistral@stev.org
 12:30am  up 35 min,  6 users,  load average: 1.90, 2.32, 2.30

