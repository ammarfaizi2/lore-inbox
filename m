Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131266AbRCHEZq>; Wed, 7 Mar 2001 23:25:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131267AbRCHEZg>; Wed, 7 Mar 2001 23:25:36 -0500
Received: from munk.apl.washington.edu ([128.95.96.184]:37904 "EHLO
	munk.apl.washington.edu") by vger.kernel.org with ESMTP
	id <S131266AbRCHEZ2>; Wed, 7 Mar 2001 23:25:28 -0500
Date: Wed, 7 Mar 2001 20:21:06 -0800 (PST)
From: Brian Dushaw <dushaw@munk.apl.washington.edu>
To: <linux-kernel@vger.kernel.org>
cc: Brian Dushaw <dushaw@munk.apl.washington.edu>
Subject: Linux kernel - and regular sync'ing?
Message-ID: <Pine.LNX.4.30.0103071959050.17257-100000@munk.apl.washington.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey There Kernel-people!
   I have a disk accessing question you may be able to help me with,
if I may be so bold....
   I have a notebook computer, and in the interests of saving power
I am trying to get its disk to go into suspend mode (hdparm -S 6 /dev/hda,
say...)  However, something seems to be continuously accessing the disk
at irregular intervals of 10-30 seconds, most likely calls to sync, so
that the disk never gets to sleep for long.  I've followed advice in the
various HOWTO's, e.g. modifying the line "ud::once:/sbin/update" in
/etc/inittab to only sync once an hour, to no avail.  Watching "top", it
sure looks as if various kernel-based daemons are responsible...nothing
else is running!
   Can you offer me any advice?  Any tweeks I can make to tell the system
that sync'ing only once every 5 minutes is o.k.?
   I have the 2.4.2 kernel (older kernels behaved the same way) and
the RedHat 6.2 distribution.

Thx!
B.D.

-- 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Brian Dushaw
Applied Physics Laboratory
University of Washington
1013 N.E. 40th Street
Seattle, WA  98105-6698
(206) 685-4198   (206) 543-1300
(206) 543-6785 (fax)
dushaw@apl.washington.edu

Web Page:  http://staff.washington.edu/dushaw/index.html

