Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261621AbSJFODl>; Sun, 6 Oct 2002 10:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261622AbSJFODl>; Sun, 6 Oct 2002 10:03:41 -0400
Received: from paloma14.e0k.nbg-hannover.de ([62.181.130.14]:33517 "HELO
	paloma14.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S261621AbSJFODj> convert rfc822-to-8bit; Sun, 6 Oct 2002 10:03:39 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Jan-Hinnerk Reichert <jan-hinnerk_reichert@hamburg.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Hangs in 2.4.19 and 2.4.20-pre5 (IDE-related?)
Date: Sun, 6 Oct 2002 16:08:51 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200210061608.51459.jan-hinnerk_reichert@hamburg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guido Villa wrote:

> I forgot to say that unlike other posters I didn't notice a connection
> between huge disk activity and the hangups.
> Indeed, when I move mpeg files (from 60 to 700 mb in size) to and from
> the disk, and when I recompile the kernel the system does not hang.
> Actually, IIRC, I never had problems in the middle of "important" disk
> activity, it always hanged when it was rather idle.

Just had my first experience with this error. Machine was up and running for 
24 days. IDE died in the middle of the night.

I have 2.4.19 without any patches, three ide harddrives, no CD-ROM.
I quite like the data on my machine, so I won't install an 2.4.20-pre on it 
;-(

> Good bye
> 
> Guido
> 
> piribillo@yahoo.it (Guido Villa) wrote in message
> news:<96ea3b81.0210011033.699b0fd4@posting.google.com>...
>> I have the same problem, but I have a 2.4.18 kernel with Hedrick's
>> patch for big disks.
>> My pc is an Intel Celeron (Mendocino) 300A, with an Intel PIIX4 Ultra
>> 33 Chipset, two hard disks and a cdrom:
>> hda: Seagate ST51080A
>> hdb: NEC CD-ROM DRIVE
>> hdc: Maxtor 4G160J8 (the 160 GB disk)

hda: IBM-DTTA-351680
hdb: Maxtor 4D080H4
hdc: Maxtor 96147H8
 
>> I used to have ext2 on both disks, but after a few hangs I switched to
>> ext3 :-)

All reiserfs, some on top of LVM.

>> I confirm that already open shells continue to work, until you try
>> accessing the disk from them. IDE led is always lit when the pc hangs.

Forgot to look at the LED.
System responded to ping, virtual terminals were OK, no login possible.
/var/log/messages contains some NULLs.

>> If you need more information about my system, please tell me.

Ditto.

Bye
 Jan-Hinnerk

