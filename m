Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314085AbSEFDx3>; Sun, 5 May 2002 23:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314087AbSEFDx2>; Sun, 5 May 2002 23:53:28 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:59922 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S314085AbSEFDx1>; Sun, 5 May 2002 23:53:27 -0400
Date: Sun, 5 May 2002 20:53:32 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux-2.5.14..
Message-ID: <Pine.LNX.4.44.0205052046590.1405-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There's a lot of stuff that has happened in the 2.5.x series lately, and
you can see the gory details in the ChangeLog files that accompany
releases these days, but I thought I'd point out 2.5.14, since it has some
interesting fundamental changes to how dirty state is maintained in the
VM.

(The big changes were actually in 2.5.12, but 2.5.13 contained various
minor fixes and tweaks, and 2.5.14 contains a number of fixes especially
wrt truncate, so hopefully it's fairly _stable_ as of 2.5.14.)

Credit goes to Andrew Morton, and not only does it clean up the code a
lot, it also seems to perform a lot better in many circumstances.

There's a lot of other stuff in the 2.5.x tree too, but few things are so
fundamental. Please test (but also, please be careful - backups are always
a good idea).

		Linus

