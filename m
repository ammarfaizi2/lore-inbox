Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316878AbSHATwJ>; Thu, 1 Aug 2002 15:52:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316896AbSHATwI>; Thu, 1 Aug 2002 15:52:08 -0400
Received: from smtp1.auracom.net ([165.154.140.23]:15846 "EHLO
	smtp1.auracom.net") by vger.kernel.org with ESMTP
	id <S316878AbSHATwI>; Thu, 1 Aug 2002 15:52:08 -0400
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: garym@teledyn.com
Subject: Kernel compiled from source won't read /parts/ of a CD?
From: Gary Lawrence Murphy <garym@canada.com>
X-Home-Page: http://www.teledyn.com
Organization: TCI Business Innovation through Open Source Computing
Reply-To: Gary Lawrence Murphy <garym@canada.com>
X-Url: http://www.teledyn.com/
Date: 01 Aug 2002 15:48:49 -0400
Message-ID: <m24reetl5q.fsf@maya.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is one of the strangest situations I have ever seen: my
re-compiled Linux 2.4.18 kernel now /refuses/ to read /only/ the
"/Mandrake" directory branch of all three of the Mandrake distribution
CDs.  It /has/ to be some kernel option, but I can't figure which one;
any advice or debugging hints at all are greatly appreciated.

I had to recompile a Mandrake 8.2 kernel to remove pcmcia support (so
I could use the sf release of it) Using the stock Mandrake 8.2 binary
kernel, the CDs can be read just fine, it is only the kernel that I
compiled from the linux-2.4.18-6mdk.src package that has this trouble.
There are no warning messages, only one line returned to the console
to say "ls /Mandrake: Invalid argument" and one line in syslog to say
"ISO 9660: RRIP_1991A" and that's the total diagnostic information I
have.

Using /usr/bin/isoinfo, I can list the CD contents just fine; all the
unix tools (ls, cd, cp ...) and rpm cannot read /Mandrake.

What could I have possibly omitted from the kernel config to cause
this?  How could that one directory be singled out by a simple kernel
config problem? (or could it be a gcc 2.96 problem?)

-- 
Gary Lawrence Murphy <garym@teledyn.com> TeleDynamics Communications Inc
Business Innovations Through Open Source Systems: http://www.teledyn.com
"Computers are useless.  They can only give you answers."(Pablo Picasso)

