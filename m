Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136047AbREBWqg>; Wed, 2 May 2001 18:46:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136049AbREBWqZ>; Wed, 2 May 2001 18:46:25 -0400
Received: from [63.109.146.2] ([63.109.146.2]:41980 "EHLO mail0.myrio.com")
	by vger.kernel.org with ESMTP id <S136047AbREBWqW>;
	Wed, 2 May 2001 18:46:22 -0400
Message-ID: <B65FF72654C9F944A02CF9CC22034CE22E1BA2@mail0.myrio.com>
From: Torrey Hoffman <torrey.hoffman@myrio.com>
To: linux-kernel@vger.kernel.org
Subject: [OT] automated remote install of Linux from WinNT4
Date: Wed, 2 May 2001 15:46:13 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Apologies for the off topic post. I have searched Google, Freshmeat 
and Sourceforge without success, and this is where the smart people 
are...

I need to do an automated, remote installation of Linux on a large 
number of networked computers running Windows NT 4.0.  I can place 
an executable on each of these computers and run it with Admin 
privileges.  These computers are using an NTFS file system and have
unpartitioned space available.

So, I need a Windows NT program that can create a bootable Linux 
partition, and then reboot into Linux from that partition.

Does anyone know of anything like that?  

If nothing like this exists, I will have to write it in the next
month or two.

My hypothetical plan is to (1) port a recent LILO or GRUB to 
Windows, and then (2) write a Windows NT program that creates a 
small FAT32 partition, formats it, mounts it, and copies in the
kernel, modules, init, and a minimal set of essential files.  

It would then run the Windows NT port of LILO/GRUB to set up the 
MBR to boot Linux from the new partition.  

The minimal Linux install would bootstrap the rest of the Linux 
install over the network.

Thanks for any advice or hints anyone can provide...

Torrey Hoffman
torrey.hoffman@myrio.com
