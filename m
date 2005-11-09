Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965284AbVKIIKj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965284AbVKIIKj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 03:10:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965285AbVKIIKj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 03:10:39 -0500
Received: from vms042pub.verizon.net ([206.46.252.42]:49656 "EHLO
	vms042pub.verizon.net") by vger.kernel.org with ESMTP
	id S965284AbVKIIKi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 03:10:38 -0500
Date: Wed, 09 Nov 2005 03:10:37 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: amanda did run 1 time after install
To: Amanda Users List <amanda-users@amanda.org>
Cc: linux-kernel@vger.kernel.org
Message-id: <200511090310.37443.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings;

I just had to reboot, it seems that was the only way to fix amanda,
which did not backup this machine tonight due to a lack of comm between
the client and the server.

When I came in and found a very short report on the printer indicating
that only the firewall box had been dumped, the first thing I did was to
su amanda, and amcheck Daily, which reported that amandad was busy on
coyote (this box).

A ps -ea|grep amanda reported that 2 instances of amandad were there,
with one of them defunct.

So I killall amandad.  amcheck's client test says coyote isn't
responding, and when I check for amandad's theres two more of them, one
defunct.

So I backup a version to 2.4.5p1-20051024, same story
Then I re-installed the last 2.4.5, same story.

Reinstall the newest one again and reboot to the same, 2.6.14 kernel. 
amcheck is now happy.

Does anyone have an idea what happened to my cherrios?

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.35% setiathome rank, not too shabby for a WV hillbilly
Free OpenDocument reader/writer/converter download:
http://www.openoffice.org
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.

