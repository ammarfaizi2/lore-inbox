Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287144AbRL2G6A>; Sat, 29 Dec 2001 01:58:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287145AbRL2G5u>; Sat, 29 Dec 2001 01:57:50 -0500
Received: from svr3.applink.net ([206.50.88.3]:32275 "EHLO svr3.applink.net")
	by vger.kernel.org with ESMTP id <S287144AbRL2G5f>;
	Sat, 29 Dec 2001 01:57:35 -0500
Message-Id: <200112290657.fBT6vMSr008000@svr3.applink.net>
Content-Type: text/plain; charset=US-ASCII
From: Timothy Covell <timothy.covell@ashavan.org>
Reply-To: timothy.covell@ashavan.org
To: linux-kernel@vger.kernel.org
Subject: RFC: Linux Bug Tracking & Feature Tracking DB
Date: Sat, 29 Dec 2001 00:53:39 -0600
X-Mailer: KMail [version 1.3.2]
Cc: timothy.covell@ashavan.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm sure that this has been proposed and discussed
before, and I'm sure that some of the software houses
like RedHat must do this internally, but here goes again....


First the obvious problem:

Just today, I had a problem with a system lockup on 2.4.16
which was fixed in 2.4.17.  Although, I try to read the changelogs,
most of them are so terse as to be worthless to anyone but the
kernel hackers themselves.   And few people beside the hackers
have time to read through all the patches just in case the pertinant
fix might be there (and if said person could readily do this, he
could probably code his own fixes!)


Present solution:

Kernel hackers spend lots of time reading email and replying.
This requires that kernel hackers are user friendly, can easily
recognize bugs, and easily recall fixes, have lots of time on
their hands, etc.



Proposed Solution:

A kernel bug and feature tracking system.  This would similar
to what you all know (like Bugtraq).   Entries might look something like:

Example bug:

bug #13697
Synopsys: Hard kernel lockup on 2.4.16 with ieee1394 SBP-2.
Solution: Patch file: pdrv54678
            http://patches.linux.org./pub/linux/v2.4/patches/p/drv/54678.diff
Platform: x86
Section: drivers
Subsection: ieee1394
Contact: joe_hacker@linux-ieee1394.sourceforge.net.
Web URL: http://linux1394.sourceforge.net

Note: All patches in 'diff -urc' format.

Example Feature:

Search Results on Keyword: SBP-2 	Platform: x86

Topic: SBP-2
Platform: x86
Section: drivers
Subsection: ieee1394
Support on 2.2.x-2.2.y and 2.4.x-2.4.present
Maturity: 7 (of 10)
Relevant Bug Reports:   #13697, #14999
Contact: joe_hacker@linux-ieee1394.sourceforge.net.
Web URL: http://linux1394.sourceforge.net




The outstanding issues:

1. The maintainer of this DB would need to receive patches
along with patch.lsm and feature.lsm like files from the code 
maintainers.   That means  that Linus, Alan, Marcello, Dave 
Jones, et al.,  might have to be involved.

2. DB would be a high volume site (at least that's the idea!)

3. Would would pay for and maintain it?  (I know, since I'm
the one putting forth the idea, it's mine to run with.  However,
a. I ain't rich.  b. following from a., I have no bandwidth 24kbps
dialup.)




That's my RFC.


timothy.covell@ashavan.org.
