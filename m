Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310180AbSCETpR>; Tue, 5 Mar 2002 14:45:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310175AbSCETpH>; Tue, 5 Mar 2002 14:45:07 -0500
Received: from dyn14.sndg-pm4-2.nethere.net ([216.188.7.14]:13184 "EHLO
	temerity.net") by vger.kernel.org with ESMTP id <S310174AbSCEToy>;
	Tue, 5 Mar 2002 14:44:54 -0500
Date: Tue, 5 Mar 2002 11:52:17 -0800 (PST)
From: Mike <mohr@temerity.net>
To: <linux-kernel@vger.kernel.org>
Subject: kernel upgrade
Message-ID: <Pine.LNX.4.33.0203051141460.342-100000@temerity.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all:

I am writing you because I recently upgraded my kernel from Slackware's
stock version 2.4.5 to 2.4.18 and have noticed some strange behavior.  My
computer, when left booted up but unused, seems to just decide to reboot
every few hours on its own.  I don't know why it does this, but the same
behavior was observed in kernel 2.4.17.  I would boot my machine up, use
it for whatever (email, surfing, adding software, etc), then log out and
leave the system up overnight.  The next morning, after touching the
keyboard to unblank the console, it would appear that the system had been
rebooted because I would be looking at tty1 with kernel boot messages
above it.  Yet I had been asleep while it apparently had been rebooted.

To see if I wasn't going crazy, I appended "date >> /root/boot.log" to
rc.local last night, echoed the system's uptime to the file, and went to sleep.
  Lo and behold, the next morning I woke up to see a rebooted system.
Checking boot.log this morning, I saw that indeed there was an entry for a
system reboot at about 7 am.

It might be worth noting that the computer is a 200MHz Compaq Presario
1220 notebook (about 5 years old).  It originally shipped with Windows 95.
How can I stop this reboot from happening?  Is it a problem with the
kernel or something else?  Any help is appreciated.

Michael

