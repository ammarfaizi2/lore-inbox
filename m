Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283061AbRK1Ojz>; Wed, 28 Nov 2001 09:39:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282147AbRK1Ojq>; Wed, 28 Nov 2001 09:39:46 -0500
Received: from insws8501.gs.com ([204.4.182.10]:12796 "HELO insws8501.gs.com")
	by vger.kernel.org with SMTP id <S283061AbRK1Oje>;
	Wed, 28 Nov 2001 09:39:34 -0500
Message-Id: <D28C5BE01ECBD41198ED00D0B7E4C9DA08E1AE3F@gsny31e.ny.fw.gs.com>
From: "Galappatti, Kishantha" <Kishantha.Galappatti@gs.com>
To: "'nbecker@fred.net'" <nbecker@fred.net>, linux-kernel@vger.kernel.org
Subject: RE: 3c905 problem
Date: Wed, 28 Nov 2001 09:39:28 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sounds like your hub and NIC card are mismatching on duplex, i.e. one is set
to half duplex (HDX) and one to full duplex (FDX). You don't need a switch
to fix the problem, you need to set them both to FDX.

-----Original Message-----
From: nbecker@fred.net [mailto:nbecker@fred.net]
Sent: Wednesday, November 28, 2001 9:09 AM
To: linux-kernel@vger.kernel.org
Subject: 3c905 problem


Sorry to bother you with a stupid question, but I don't know enough to
understand this.

I moved a machine which has a 3c905 connected to a linksys autosense
10/100 hub.  I set no options on the 3c905 module.

I get millions of dreaded:

 Nov 28 08:58:15 adglinux1 kernel:   9: @cf2b3440  length 800005ea status
000105ea
Nov 28 08:58:15 adglinux1 kernel:   10: @cf2b3480  length 800005ea status
000105ea
Nov 28 08:58:15 adglinux1 kernel:   11: @cf2b34c0  length 800005ea status
000105ea
Nov 28 08:58:15 adglinux1 kernel:   12: @cf2b3500  length 800005ea status
000105ea
Nov 28 08:58:15 adglinux1 kernel:   13: @cf2b3540  length 800005ea status
000105ea
Nov 28 08:58:15 adglinux1 kernel:   14: @cf2b3580  length 80000043 status
00010043
Nov 28 08:58:15 adglinux1 kernel:   15: @cf2b35c0  length 80000043 status
00010043
Nov 28 08:58:15 adglinux1 kernel: eth0: Transmit error, Tx status register
82.
Nov 28 08:58:15 adglinux1 kernel: Probably a duplex mismatch.  See
Documentation/networking/vortex.txt
Nov 28 08:58:15 adglinux1 kernel:   Flags; bus-master 1, dirty 77261(13)
current 77263(15)

What exactly does this mean?  How do I fix it?  I have looked at
Documentation/networking/vortex.txt, but I don't know what this
HDX/FDX means exactly, and how works with a hub or switch.  Would my
problem be fixed by replacing the hub with a "switch"?

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
