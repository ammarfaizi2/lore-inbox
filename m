Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129538AbRAATh0>; Mon, 1 Jan 2001 14:37:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129741AbRAAThB>; Mon, 1 Jan 2001 14:37:01 -0500
Received: from tweetie.comstar.net ([130.205.120.2]:7040 "EHLO
	tweetie.comstar.net") by vger.kernel.org with ESMTP
	id <S129534AbRAATgx>; Mon, 1 Jan 2001 14:36:53 -0500
Date: Mon, 1 Jan 2001 14:06:25 -0500 (EST)
From: Gregory McLean <gregm@comstar.net>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.0-prerelease shmget woes.
Message-ID: <Pine.LNX.4.30.0101011402001.1416-100000@tweetie.comstar.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, I just compiled and booted up 2.4.0-prerelease, dropped into X-Windows
and now gtk/gnome apps are giving the following warning:

Gdk-WARNING **: shmget failed!

Any ideas on what changed in the shm space to cause this?

This is a PII 333 RH 7.0 system 2.4.0-test10 worked just fine on this
machine.


/dev/shm is mounted:
none                     0     0     0   -  /dev/shm

The /usr/src/linux/Documentation/Changes file only mentions that this need
be mounted.

Tips, clues welcome.

-- Greg


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
