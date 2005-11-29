Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932234AbVK2RHG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932234AbVK2RHG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 12:07:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932245AbVK2RHG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 12:07:06 -0500
Received: from vms048pub.verizon.net ([206.46.252.48]:63810 "EHLO
	vms048pub.verizon.net") by vger.kernel.org with ESMTP
	id S932234AbVK2RHE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 12:07:04 -0500
Date: Tue, 29 Nov 2005 12:06:42 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: cx88 totally fried in 2.6.15-rcX -was- Re: HD3000 - no NTSC via
 tuner
In-reply-to: <200511291106.17571.gene.heskett@verizon.net>
To: linux-kernel@vger.kernel.org
Cc: mkrufky@m1k.net, Linux and Kernel Video <video4linux-list@redhat.com>
Message-id: <200511291206.43105.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <200511282205.jASM5YUI018061@p-chan.krl.com>
 <438C7942.5080509@m1k.net> <200511291106.17571.gene.heskett@verizon.net>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 29 November 2005 11:06, Gene Heskett wrote:
>On Tuesday 29 November 2005 10:52, Michael Krufky wrote:
>>Gene Heskett wrote:
>>>>I should also add this is with 2.6.14.2 and todays v4l-dvb CVS.
>>>
>>>And I should add that 2.6.14, any version without the cvs update,
>>> works perfectly in ntsc here. I have to atsc signals available.
>>
>>Gene,
>>
>>Would you mind trying to install the cvs modules on top of 2.6.14,
>> using the instructions that I gave you last night?  This will confirm
>> once and for all whether your problems are due to a v4l regression,
>> or an upstream regression in 2.6.15.
>>
>>Thanks,
>
>Yes, I can do that. I can also confirm that its still borked in -rc3.

Turns out I'd borked the linkages in /lib/modules/2.6.14 with a
previous attempt, so I'm rebuilding 2.6.14 first in order to restore the
linakges.  The cvs build is slow, is the -j=1 in the Makefile?  Or do I
need to spec that on the cli?  I've forgotten.  Anyway, its done, so a
reboot is coming up.

And its broken in the same manner for 2.6.14 + cvs.  I tried to do a
screen snapshot but the tvtime window was blank in the snapshot. 
Didn't we used to have a snapshotter that grabbed only the window with
ficus way back when?

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.36% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.


