Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130064AbRBZAiZ>; Sun, 25 Feb 2001 19:38:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130071AbRBZAiG>; Sun, 25 Feb 2001 19:38:06 -0500
Received: from andromeda.dsdk12.net ([207.109.100.251]:45787 "HELO
	patriot.dsdk12.net") by vger.kernel.org with SMTP
	id <S130070AbRBZAh5>; Sun, 25 Feb 2001 19:37:57 -0500
Date: Sun, 25 Feb 2001 17:37:53 -0700 (MST)
From: Derrik Pates <dpates@andromeda.dsdk12.net>
To: <linux-kernel@vger.kernel.org>
Subject: IDE floppy drives and devfs - no device nodes if no disk loaded at
 boot
Message-ID: <Pine.LNX.4.33.0102251733400.11946-100000@andromeda.dsdk12.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject says about all there is to say. I have figured out that IDE drives
are enumerated as part of the boot-time partition check in
fs/partitions/check.c, but if I don't have something loaded at boot time
(IDE SuperDisk in PC at home, IDE Zip 100 in G3 tower at work), I never
get device nodes at all with devfs. Something really needs to be done
about this, IMHO.

Derrik Pates      | Sysadmin, Douglas School|    _   #linuxOS on EFnet
dpates@dsdk12.net |  District (dsdk12.net)  |   | |   and now OPN too!
   Student @ South Dakota School of Mines   | __| |___ _ _ _   ___ _ _   ____
       & Technology (www.sdsmt.edu)         |/ _  / -_) ' \ '\/ _ \ ' \ (____)
UNIX: Because you want to USE your computer.|\___,\___|_||_||_\___/_||_|

