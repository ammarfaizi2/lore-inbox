Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265319AbRF0RZH>; Wed, 27 Jun 2001 13:25:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265333AbRF0RY5>; Wed, 27 Jun 2001 13:24:57 -0400
Received: from w146.z064001233.sjc-ca.dsl.cnc.net ([64.1.233.146]:14024 "EHLO
	windmill.gghcwest.com") by vger.kernel.org with ESMTP
	id <S265319AbRF0RYv>; Wed, 27 Jun 2001 13:24:51 -0400
Date: Wed, 27 Jun 2001 10:22:25 -0700 (PDT)
From: "Jeffrey W. Baker" <jwbaker@acm.org>
X-X-Sender: <jwb@heat.gghcwest.com>
To: <linux-kernel@vger.kernel.org>
Subject: How to change DVD-ROM speed?
Message-ID: <Pine.LNX.4.33.0106271018000.32012-100000@heat.gghcwest.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to change the spin rate of my IDE DVD-ROM drive.  My system is
an Apple PowerBook G4, and I am using kernel 2.4.  I want the drive to
spin at 1X when I watch movies.  Currently, it spins at its highest speed,
which is very loud and a large power load.

/proc/sys/dev/cdrom/info indicates that the speed of the drive can be
changed.  I use hdparm -E 1 /dev/dvd to attempt to set the speed, and it
reports success.  However, the drive continues to spin at its highest
speed.

Is this ioctl supposed to work on DVD drives?  PPC?  In MacOS, the DVD
spins quietly when watching movies.

Regards,
Jeffrey

