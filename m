Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266091AbRF2O0m>; Fri, 29 Jun 2001 10:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266096AbRF2O0h>; Fri, 29 Jun 2001 10:26:37 -0400
Received: from paloma17.e0k.nbg-hannover.de ([62.159.219.17]:35261 "HELO
	paloma17.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S266091AbRF2O01>; Fri, 29 Jun 2001 10:26:27 -0400
Content-Type: text/plain; charset=US-ASCII
From: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Linux-2.4.5-ac21
Date: Fri, 29 Jun 2001 16:25:55 +0200
X-Mailer: KMail [version 1.2.2]
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010629142630Z266091-17721+7209@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Alan,

I mount my bootdisk (minix filesystem) with "mount /dev/fd0 /mnt" and copy my 
new compiled kernel to it. After that I do a "lilo -v -C /mnt/lilo.conf".

All following commands which are floppy related (filesystem) fall into the D 
state. Load goes up by 100 for every D state process.

ls /mnt
umount /mnt
sync

SunWave1#ps aux
root      1039  0.0  0.0  1404   64 pts/1    D    16:24   0:00 umount /mnt
nuetzel   1108  0.1  0.1  1412  500 pts/5    D    16:28   0:00 sync

Only the floppy (Minix) show this symptoms.
All other disk partitions (ReiserFS) working (mount/umount) as expected.

Thanks,
        Dieter

