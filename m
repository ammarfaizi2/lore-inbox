Return-Path: <linux-kernel-owner+w=401wt.eu-S1751670AbWLNFhP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751670AbWLNFhP (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 00:37:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751772AbWLNFhO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 00:37:14 -0500
Received: from vms042pub.verizon.net ([206.46.252.42]:47244 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751678AbWLNFhN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 00:37:13 -0500
Date: Thu, 14 Dec 2006 00:36:44 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: Linux 2.6.20-rc1
In-reply-to: <Pine.LNX.4.64.0612131918100.5718@woody.osdl.org>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>
Message-id: <200612140036.46083.gene.heskett@verizon.net>
Organization: Not detectable
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <Pine.LNX.4.64.0612131744290.5718@woody.osdl.org>
 <200612132146.41829.gene.heskett@verizon.net>
 <Pine.LNX.4.64.0612131918100.5718@woody.osdl.org>
User-Agent: KMail/1.9.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 13 December 2006 22:32, Linus Torvalds wrote:
>On Wed, 13 Dec 2006, Gene Heskett wrote:
>> Ok, one not so silly Q (IMO) from the resident old fart.  I saw,
>> sometime in the past week, a relatively huge ieee1394 update go by. 
>> And I have some issues with the present 2.6.19 version causeing
>> segfaults and kino go-aways when trying to capture from my firewire
>> movie camera.  Problems occur when trying to control the camera from
>> kino.
>>
>> Is this patchset in this -rc1?  If it is, I'll see if I can get a
>> build to work and check it out.
>
>-rc1 does include a reasonably big firewire update, but I'm not sure how
>it will affect your camera usage. In fact, the ieee1394 people seem to
> be trying to deprecate the dv1394 stuff, in favour of just raw1394 and
> user-mode libraries.
>
>I think you can tell Kino to use either the DV or the raw interface, but
>I'm not sure. If you can, try either. The raw interface seems to be
>horribly misdesigned (security problems), but is the one to use.

It is using the raw stuff now.

>
>But by all means, give it a shot,

Will do, sometime in the next few days, its muzzleloading deer season here 
ATM.  And I wasted half the season on a tv station up in upstate MI.

>and regardless of whether it works 
>better or not, you might want to cry on the shoulder of Stefan Richter
><stefanr@s5r6.in-berlin.de> about the issues you see.. Of course, please
>talk to the Kino people too (although I have absolutely no idea who they
>would be).
>
>		Linus

That would be primarily Dan Dennedy although Stefan may be the next in 
line.  Dan tells us that kino will be finalized very shortly as he has 
other irons in the fire too.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2006 by Maurice Eugene Heskett, all rights reserved.
