Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131681AbRCOM33>; Thu, 15 Mar 2001 07:29:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131704AbRCOM3J>; Thu, 15 Mar 2001 07:29:09 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:9478 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S131700AbRCOM26>; Thu, 15 Mar 2001 07:28:58 -0500
Date: Thu, 15 Mar 2001 07:28:30 -0500 (EST)
From: "Mike A. Harris" <mharris@opensourceadvocate.org>
X-X-Sender: <mharris@asdf.capslock.lan>
To: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Is swap == 2 * RAM a permanent thing?
Message-ID: <Pine.LNX.4.33.0103150720100.757-100000@asdf.capslock.lan>
X-Unexpected-Header: The Spanish Inquisition
X-Spam-To: uce@ftc.gov
Copyright: Copyright 2001 by Mike A. Harris - All rights reserved
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is the fact that we're supposed to use double the RAM size as
swap a permanent thing or a temporary annoyance that will get
tweaked/fixed in the future at some point during 2.4.x perhaps?

What are the technical reasons behind this change?  Just curious
as I see a lot of people are complaining about having to
repartition (although a slower swap file could be used also).

I'm curious because I currently have 96Mb of RAM and 256Mb of
swap, but swap rarely if ever gets used, and performance is very
good.  This is with 2.2.18 I'm speaking.

I'm planning on upping my RAM to 256Mb or more in the near future
however, and going to 2.4.3 or 2.4.4 when released, and since
96Mb does the job for me already it would suck to have to
increase swap at the same time when it never gets used as it is
right now.

Would it be better to make part of RAM a ramdisk and swap to
that?  Sounds like we're going backwards IMHO, but I don't
understand the details, so I'll let someone that does explain
them to me.

Thanks in advance.



----------------------------------------------------------------------
    Mike A. Harris  -  Linux advocate  -  Free Software advocate
          This message is copyright 2001, all rights reserved.
  Views expressed are my own, not necessarily shared by my employer.
----------------------------------------------------------------------
If it weren't for C, we'd all be programming in BASI and OBOL.

