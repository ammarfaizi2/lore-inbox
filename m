Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261295AbSJLRPp>; Sat, 12 Oct 2002 13:15:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261296AbSJLRPp>; Sat, 12 Oct 2002 13:15:45 -0400
Received: from mx2.airmail.net ([209.196.77.99]:53264 "EHLO mx2.airmail.net")
	by vger.kernel.org with ESMTP id <S261295AbSJLRPm>;
	Sat, 12 Oct 2002 13:15:42 -0400
Date: Sat, 12 Oct 2002 12:05:50 -0500
From: Art Haas <ahaas@neosoft.com>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] C99 designated initializers for drivers/video
Message-ID: <20021012170550.GL633@debian>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="bCsyhTFzCvuiizWE"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bCsyhTFzCvuiizWE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi.

Here's a set of patches (20 in total) that switch drivers/video to use
C99 named initializers. When "cat"ing together the patches, the total
size was just over 20K, so I'm sending this patch set as a compressed
attachment.

Patched files:
aty128fb.c
controlfb.c
fbcon-afb.c
fbcon-cfb16.c
fbcon-cfb2.c
fbcon-cfb24.c
fbcon-cfb32.c
fbcon-cfb4.c
fbcon-cfb8.c
fbcon-ilbm.c
fbcon-iplan2p2.c
fbcon-iplan2p4.c
fbcon-iplan2p8.c
fbcon-mfb.c
fbcon-vga-planes.c
fbcon.c
g364fb.c
neofb.c
pm2fb.c
retz3fb.c

Art Haas
-- 
They that can give up essential liberty to obtain a little temporary safety
deserve neither liberty nor safety.
 -- Benjamin Franklin, Historical Review of Pennsylvania, 1759

--bCsyhTFzCvuiizWE
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="video.diff.gz"
Content-Transfer-Encoding: base64

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
kZ0OXf8DCnjMw09UAAA=

--bCsyhTFzCvuiizWE--
