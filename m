Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129998AbRCERdS>; Mon, 5 Mar 2001 12:33:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130079AbRCERdI>; Mon, 5 Mar 2001 12:33:08 -0500
Received: from chaos.analogic.com ([204.178.40.224]:640 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S129998AbRCERdA>; Mon, 5 Mar 2001 12:33:00 -0500
Date: Mon, 5 Mar 2001 12:32:44 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Loop stuck in -D state
Message-ID: <Pine.LNX.3.95.1010305122756.1098A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I tried Linux 2.4.2
Now I'm in a load of trouble. I can't make a boot-disk to get back
to 2.4.1 because I use initrd for my hard disk modules and the loop
device is broken.

   100     0  1055  1040   9   0    780   780 wait_on_buf D   1  0:00
mount -o loop -t ext2 /tmp/ram /tmp/Ramdisk 

This is gonna be fun. I'll have to make a boot floppy on another machine
that doesn't have a broken loop device.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.2 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


