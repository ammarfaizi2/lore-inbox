Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130079AbQKIEiV>; Wed, 8 Nov 2000 23:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130161AbQKIEiM>; Wed, 8 Nov 2000 23:38:12 -0500
Received: from andromeda.dsdk12.net ([207.109.100.251]:50333 "HELO
	patriot.dsdk12.net") by vger.kernel.org with SMTP
	id <S130079AbQKIEiG>; Wed, 8 Nov 2000 23:38:06 -0500
Date: Wed, 8 Nov 2000 21:38:02 -0700 (MST)
From: Derrik Pates <dpates@andromeda.dsdk12.net>
To: <linux-kernel@vger.kernel.org>
Subject: B/W G3 - big IDE problems with 2.4.0-test10
Message-ID: <Pine.LNX.4.30.0011082115050.27524-100000@andromeda.dsdk12.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been trying Debian woody for PowerPC on a blue-and-white G3 tower
machine (PPC750/350 MHz, 192 MB RAM). Finally got yaboot working, so now
I'm playing with getting 2.4.x going (in part to get the built-in support
for Mac-on-Linux). However, when I try to boot the kernel, I get errors
about conflicts in I/O address space, and the secondary IDE interface
(what 2.2.17 sees as hde/hdf) shows up as the primary, but both hard
drives (Linux installed on hdb, MacOS on hda) do not show at all. I can't
use serial-console, and I don't have an NFS server (I may have to setup a
basic NFS-root image on another machine to boot it from). Also, it has no
floppy drives. I can't scroll back, so I can't read all the messages.

I saw a previous post about a similar situation with test5 a ways back in
Geocrawler's linux-kernel archive, but I don't see any answer to the
earlier query.

Derrik Pates      | Sysadmin, Douglas School|    _   #linuxOS on EFnet
dpates@dsdk12.net |  District (dsdk12.net)  |   | |   and now OPN too!
   Student @ South Dakota School of Mines   | __| |___ _ _ _   ___ _ _   ____
       & Technology (www.sdsmt.edu)         |/ _  / -_) ' \ '\/ _ \ ' \ (____)
UNIX: Because you want to USE your computer.|\___,\___|_||_||_\___/_||_|

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
