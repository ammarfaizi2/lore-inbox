Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267480AbTAXB1A>; Thu, 23 Jan 2003 20:27:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267490AbTAXB1A>; Thu, 23 Jan 2003 20:27:00 -0500
Received: from ns1.mountaincable.net ([24.215.0.11]:40861 "EHLO
	ns1.mountaincable.net") by vger.kernel.org with ESMTP
	id <S267480AbTAXB06>; Thu, 23 Jan 2003 20:26:58 -0500
Subject: ieee1394: Node 01:1023 has non-standard ROM format (0 quads),
	cannot parse
From: desrt <desrt@desrt.ca>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1043372135.1442.7.camel@nothing.desrt.ca>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1- 
Date: 23 Jan 2003 20:35:35 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I just got a new plextor combo (read dvd, write cd) drive and installed
it into my firewire drive enclosure.  The CD-ROM drive that was in there
previously was working fine.  I am using an Audigy as my firewire
controller.

Now, on attach/power on/modprobe ohci1394/etc I get this message:

ieee1394: Node 01:1023 has non-standard ROM format (0 quads), cannot
parse

I get the same message with 2.4.20, .21-pre3, and 2.5.59.

I've tried increasing the number of attempts that the loop in nodemgr.c
makes to attempt to get this quantity from 4 tries (1 second) to 40 (10
seconds.)  The only difference that made was that the error takes longer
to appear.

Not sure if this is useful information, but this is what it says with
the CD-ROM drive in (ie: when it is working)
ieee1394: Device added: Node[01:1023]  GUID[0030999550551539] 
[NewMotion Technology Corp.  ]

I've googled and searched the list archives at no avail.  IRC also isn't
working out.

If anybody has experienced this before, has any ideas, would like
information about the problem or even knows of a better forum to direct
this question to, your help would be greatly appreciated.  Please CC: me
a copy of your reply as I am not on the list.

Thanks in advance,
 Ryan

