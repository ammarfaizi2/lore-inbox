Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262464AbTCIHZx>; Sun, 9 Mar 2003 02:25:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262465AbTCIHZx>; Sun, 9 Mar 2003 02:25:53 -0500
Received: from 101.24.177.216.inaddr.G4.NET ([216.177.24.101]:63915 "EHLO
	sparrow.stearns.org") by vger.kernel.org with ESMTP
	id <S262464AbTCIHZw>; Sun, 9 Mar 2003 02:25:52 -0500
Date: Sun, 9 Mar 2003 02:36:16 -0500 (EST)
From: William Stearns <wstearns@pobox.com>
X-X-Sender: wstearns@sparrow
Reply-To: William Stearns <wstearns@pobox.com>
To: ML-linux-kernel <linux-kernel@vger.kernel.org>
cc: William Stearns <wstearns@pobox.com>
Subject: 2.5.64 file permissions
Message-ID: <Pine.LNX.4.44.0303090231220.3395-100000@sparrow>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good day, all,
	The file permissions on the following 4 are mode 640 instead of 
644 in 2.5.64:

drivers/char/agp/generic-3.0.c
drivers/char/agp/i7x05-agp.c 
drivers/input/joystick/grip_mp.c
include/video/neomagic.h
-rw-r-----    5 1046     named       15035 Mar  4 22:29 drivers/char/agp/generic-3.0.c
-rw-r-----    5 1046     named        6049 Mar  4 22:28 drivers/char/agp/i7x05-agp.c
-rw-r-----    5 1046     named       17188 Mar  4 22:29 drivers/input/joystick/grip_mp.c
-rw-r-----    5 1046     named        5926 Mar  4 22:29 include/video/neomagic.h

	Sorry, I'm not sure how to change that in a patch file.
	Cheers,
	- Bill

---------------------------------------------------------------------------
        "If this were a dictatorship, it'd be a heck of a lot easier,
just so long as I'm the dictator."
        -- George W. Bush Dec 18, 2000
(Courtesy of Harald Welte <laforge@gnumonks.org>)
--------------------------------------------------------------------------
William Stearns (wstearns@pobox.com).  Mason, Buildkernel, freedups, p0f,
rsync-backup, ssh-keyinstall, dns-check, more at:   http://www.stearns.org
Linux articles at:                         http://www.opensourcedigest.com
--------------------------------------------------------------------------

