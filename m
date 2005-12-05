Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751042AbVLEFbd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751042AbVLEFbd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 00:31:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751051AbVLEFbd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 00:31:33 -0500
Received: from vms044pub.verizon.net ([206.46.252.44]:64702 "EHLO
	vms044pub.verizon.net") by vger.kernel.org with ESMTP
	id S1751042AbVLEFbc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 00:31:32 -0500
Date: Mon, 05 Dec 2005 00:31:39 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: ntp problems
To: linux-kernel@vger.kernel.org
Message-id: <200512050031.39438.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings everybody;

I seem to have an ntp problem.  I noticed a few minutes ago that if
my watch was anywhere near correct, then the computer was about 6
minutes fast.  Doing a service ntpd restart crash set it back nearly
6 minutes.

Kernel is 2.6.15-rc5, xp2800 athlon box, gig of ram.

Heres the log since yesterdays reboot, including the restart just
now.  What can be learned from it?

4 Dec 10:39:16 ntpd[1981]: logging to file /var/log/ntp.log
 4 Dec 10:39:16 ntpd[1981]: ntpd 4.2.0a@1.1190-r Fri Aug 26 04:27:20
EDT 2005 (1)
 4 Dec 10:39:16 ntpd[1981]: precision = 1.000 usec
 4 Dec 10:39:16 ntpd[1981]: Listening on interface wildcard,
0.0.0.0#123
 4 Dec 10:39:16 ntpd[1981]: Listening on interface lo, 127.0.0.1#123
 4 Dec 10:39:16 ntpd[1981]: Listening on interface eth0,
192.168.71.3#123
 4 Dec 10:39:16 ntpd[1981]: kernel time sync status 0040
 4 Dec 10:39:17 ntpd[1981]: frequency initialized 4.392 PPM from
/var/lib/ntp/drift
 4 Dec 10:42:32 ntpd[1981]: synchronized to LOCAL(0), stratum 10
 4 Dec 10:42:32 ntpd[1981]: kernel time sync disabled 0041
 4 Dec 10:43:36 ntpd[1981]: kernel time sync enabled 0001
 4 Dec 14:30:12 ntpd[1981]: synchronized to 80.96.120.249, stratum 2
 4 Dec 14:33:02 ntpd[1981]: synchronized to 64.109.43.141, stratum 2
 4 Dec 14:35:12 ntpd[1981]: synchronized to LOCAL(0), stratum 10
 4 Dec 20:35:32 ntpd[1981]: synchronized to 80.96.120.249, stratum 2
 4 Dec 20:37:40 ntpd[1981]: synchronized to 64.109.43.141, stratum 2
 4 Dec 20:38:56 ntpd[1981]: synchronized to LOCAL(0), stratum 10
 5 Dec 00:06:20 ntpd[1981]: ntpd exiting on signal 15
 5 Dec 00:00:38 ntpd[22610]: logging to file /var/log/ntp.log
 5 Dec 00:00:38 ntpd[22610]: ntpd 4.2.0a@1.1190-r Fri Aug 26 04:27:20
EDT 2005 (1)
 5 Dec 00:00:38 ntpd[22610]: precision = 1.000 usec
 5 Dec 00:00:38 ntpd[22610]: Listening on interface wildcard,
0.0.0.0#123
 5 Dec 00:00:38 ntpd[22610]: Listening on interface lo, 127.0.0.1#123
 5 Dec 00:00:38 ntpd[22610]: Listening on interface eth0,
192.168.71.3#123
 5 Dec 00:00:38 ntpd[22610]: kernel time sync status 0040
 5 Dec 00:00:39 ntpd[22610]: frequency initialized 4.392 PPM from
/var/lib/ntp/drift
 5 Dec 00:03:58 ntpd[22610]: synchronized to LOCAL(0), stratum 10
 5 Dec 00:03:58 ntpd[22610]: kernel time sync disabled 0041
 5 Dec 00:05:04 ntpd[22610]: kernel time sync enabled 0001

 Thanks for any hints anybody can throw my way.
 
-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.36% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.


