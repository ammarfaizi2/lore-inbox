Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262189AbVCUXGm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262189AbVCUXGm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 18:06:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262124AbVCUXE1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 18:04:27 -0500
Received: from vms044pub.verizon.net ([206.46.252.44]:47027 "EHLO
	vms044pub.verizon.net") by vger.kernel.org with ESMTP
	id S262175AbVCUXCe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 18:02:34 -0500
Date: Mon, 21 Mar 2005 18:02:24 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: 2.6.12-rc1 report
In-reply-to: <423F4BF2.8050603@tmr.com>
To: linux-kernel@vger.kernel.org
Cc: Bill Davidsen <davidsen@tmr.com>,
       Linux and Kernel Video <video4linux-list@redhat.com>
Reply-to: gene.heskett@verizon.net
Message-id: <200503211802.24945.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <200503191503.26128.gene.heskett@verizon.net>
 <423F4BF2.8050603@tmr.com>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 21 March 2005 17:34, Bill Davidsen wrote:
>Gene Heskett wrote:
>> Greetings;
>>
>> Usually I come looking for a bone when I post here, but today its
>> with verbal flowers in hand.
>>
>> I just built 2.6.12-rc1 and I'm pleased to report that the
>> ieee1394 problems that required the bk-ieee1394.patch previously
>> are apparently alleviated.  Kino worked as expected, including the
>> audio from the cameras microphones.
>>
>> tvtime, with my pcHDTV-3000 card, had a miss-cue due to the wrong
>> modprobe statement in my rc.local, so I cleaned out those modules
>> that it had loaded, and reloaded them with the 'modprobe cx88_dvb'
>> statement, which brought that up with working video but raw noise
>> for audio at about +40db!  Going into its menu's for tv standards
>> I chose to 'restart with new values' without changing anything
>> which restored the audio to normal.  Thats happened before, and
>> Jack tells me there will be another coding session this weekend so
>> there will no doubt be more patches for that.  This FWIW, was
>> without actually installing either version of his drivers, so this
>> is nice progress.
>>
>> My scanner works normally. As does the spca5xx stuffs that I did
>> install again after the boot.
>
>What distro are you using with this? Before I report problems I want
> to eliminate distro errors of the type you describe.

FC2, more or less.  I've quite a list of stuff thats home built here 
though, and xorg-6.8.1 is one of them, the full KDE-3.3.0 for 
another, along with virtually anything to do with printing, cups is 
1.1.22, gimp-print is now gutenprint-5.0beta2.  The list goes on, 
usually triggered by whatever itch needs scratched.

That statement in my modprobe.conf that I had to nuke, not mentioned 
in this message, may have been a leftover from trying to install the 
original, on the cd, drivers.  I didn't put it in there, and having 
looked at my modprobe.conf fairly often, I don't recall seeing it 
till someone asked me to do a general recheck on things in /etc.

The modprobe statement in my rc.local file had been installed to 
preload the 1.6 drivers, wrong for the current crop and that was 100% 
my doing.  You probably wouldn't recognize my rc.local file as 
haveing anything to do with redhat or fedora, its been hacked to add 
this or that many many times over the years.  Mainly to get stuff 
going even if I don't log in and start them, Like for instance, 
setiathome gets launched in there as does the boinc client, env vars 
for heyu, and all my audio stuff gets loaded or started in there.
So I see a lot of stuff go flying by before the login prompt comes up, 
another 15 seconds of delay in doing all that I expect.

But nothing that was there originally has been removed either.

Does this answer, or puzzle?  Puzzle clues available :)


-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.34% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
