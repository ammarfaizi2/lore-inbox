Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264717AbRF3XnL>; Sat, 30 Jun 2001 19:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264733AbRF3Xmw>; Sat, 30 Jun 2001 19:42:52 -0400
Received: from pcow034o.blueyonder.co.uk ([195.188.53.122]:47629 "EHLO
	blueyonder.co.uk") by vger.kernel.org with ESMTP id <S264717AbRF3Xmn> convert rfc822-to-8bit;
	Sat, 30 Jun 2001 19:42:43 -0400
Content-Type: text/plain; charset=US-ASCII
From: Alan Chandler <alan@chandlerfamily.org.uk>
To: <linux-kernel@vger.kernel.org>
Subject: All reiserfs system experiencing lockups under heavy load - 2.4.5-ac22
Date: Sun, 1 Jul 2001 00:42:40 +0100
X-Mailer: KMail [version 1.2.9]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E15GUNt-0004pL-00@roo.home>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am not subscribed to the list please cc me on replies.

I have seen a number of reports of complete lockup of systems.  I have been 
experiencing them almost since I decided to switch over to an all reiserfs 
system - and had installed linux 2.4.5-ac22 since it supposidly contained a 
patch that was supposed to fix a problem in this area (after ac13 which was 
OK but crashed occassionally, ac19 which locked up every 10 minutes or so, 
2.4.6-pre5 which was better but still crashed once yesterday).

I was running KDE at the time with a "make install" on a part of KDE which 
was doing a ldconfig.  The system went sluggish for 10 or 15 secs and then 
locked solid (mouse and screen froze, keyboard inactive and an attempt to 
connect via ssh from elsewhere showed no response).

KDE was running a CPU meter at the time and this showed (at the freeze) 
a) CPU load at 100% in the system (as opposed to user time), and
b) All memory being used by applications or buffers
c)  Either none, or a small amount of swap being used.

I'm running a Athlon 900Mhz on a Abit KT7-raid (raid not being used) 
motherboard - ie with the VIA KT133 chip that has also been giving problems 
to some - 128Mb of main memory. There are two IBM disks on IDE although hdc 
is more or less exclusively a backup disk.  The other has hda1 as a FAT32 
partition, hd2 as root hda3 as 500Mb swap, hda4 is a holder for hda5 (/home) 
hda6 (/usr) and hda7 (storage).  hda2,5,6,7 are all reiserfs. All partitions 
have plenty of free space.

I don't have kernel debugging built in - but I am willing to try anything to 
get more data for people - please just e-mail me.

-- 

  Alan - alan@chandlerfamily.org.uk
http://www.chandlerfamily.org.uk
