Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314362AbSDROSI>; Thu, 18 Apr 2002 10:18:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314364AbSDROSG>; Thu, 18 Apr 2002 10:18:06 -0400
Received: from [137.112.40.22] ([137.112.40.22]:48278 "EHLO
	hermes.cs.rose-hulman.edu") by vger.kernel.org with ESMTP
	id <S314362AbSDROSA>; Thu, 18 Apr 2002 10:18:00 -0400
Date: Thu, 18 Apr 2002 09:16:39 -0500 (EST)
From: "Leslie F. Donaldson" <donaldlf@cs.rose-hulman.edu>
X-X-Sender: <donaldlf@voodoo>
To: <axp-kernel-list@redhat.com>, <linux-kernel@vger.kernel.org>
cc: <ldonald@nw.verizonwireless.com>
Subject: Booting on a raid/lvm combination?
Message-ID: <Pine.GSO.4.33.0204180909540.17436-100000@voodoo>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
  After loseing my hard drive to e2fs corruption I decided
to build the drive system up, so I am laying out an

raid-5 --> LVM --> reiserfs

Distribution is 7.1 (soon to be upgraded to rawhide)

My problem is I boot with milo and I can't get it to work.
I have my kernel on a dos part at sda1 and I have added
a file initrd.gz to that disk. My real root system is sda3
which is the raid.

I boot using (or try to boot)

boot sda1:/vmlinux.gz root=/dev/sda3 initrd=/initrd.gz

but it can't find the file because it's on the lvm drive which
is no active yet. I tried something along the lines of

boot sda1:/vmlinux.gz root=/dev/sda3 initrd=sda1:/initrd.gz

Does anyone have a clue I can use?

Please reply to me directly ad without my drives working
it's a terminal session to my email account <sigh>

Leslie Donaldson


