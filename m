Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261747AbVCSUDf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261747AbVCSUDf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 15:03:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261748AbVCSUDd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 15:03:33 -0500
Received: from vms046pub.verizon.net ([206.46.252.46]:13563 "EHLO
	vms046pub.verizon.net") by vger.kernel.org with ESMTP
	id S261747AbVCSUDa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 15:03:30 -0500
Date: Sat, 19 Mar 2005 15:03:25 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: 2.6.12-rc1 report
To: Linux and Kernel Video <video4linux-list@redhat.com>,
       linux-kernel@vger.kernel.org
Reply-to: gene.heskett@verizon.net
Message-id: <200503191503.26128.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings;

Usually I come looking for a bone when I post here, but today its with 
verbal flowers in hand.

I just built 2.6.12-rc1 and I'm pleased to report that the ieee1394 
problems that required the bk-ieee1394.patch previously are 
apparently alleviated.  Kino worked as expected, including the audio 
from the cameras microphones.

tvtime, with my pcHDTV-3000 card, had a miss-cue due to the wrong 
modprobe statement in my rc.local, so I cleaned out those modules 
that it had loaded, and reloaded them with the 'modprobe cx88_dvb' 
statement, which brought that up with working video but raw noise for 
audio at about +40db!  Going into its menu's for tv standards I chose 
to 'restart with new values' without changing anything which restored 
the audio to normal.  Thats happened before, and Jack tells me there 
will be another coding session this weekend so there will no doubt be 
more patches for that.  This FWIW, was without actually installing 
either version of his drivers, so this is nice progress.

My scanner works normally. As does the spca5xx stuffs that I did 
install again after the boot.

This just plain feels good under my fngertips, even kmails curser 
motions are as expected, but that lag comes and goes according to the 
number of bees around the crocus's in the front yard, or some such 
mysticly quasi random control.  I don't have any idea about how much 
faster the machine is in fact, but it sure feels snappier, a lot 
snappier.

So, a smart tip of the hat to all the patchers, this is seeable, 
feelable, progress.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.34% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
