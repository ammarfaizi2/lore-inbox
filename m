Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267825AbUHJXn3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267825AbUHJXn3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 19:43:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267829AbUHJXn3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 19:43:29 -0400
Received: from out001pub.verizon.net ([206.46.170.140]:25271 "EHLO
	out001.verizon.net") by vger.kernel.org with ESMTP id S267826AbUHJXmu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 19:42:50 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org, Martin Schlemmer <azarah@nosferatu.za.org>
Subject: Re: The prune_dcache saga, truely epic proportions now
Date: Tue, 10 Aug 2004 19:42:46 -0400
User-Agent: KMail/1.6.82
References: <200408031421.58487.gene.heskett@verizon.net> <1092172017.8976.36.camel@nosferatu.lan>
In-Reply-To: <1092172017.8976.36.camel@nosferatu.lan>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408101942.47004.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out001.verizon.net from [141.153.76.4] at Tue, 10 Aug 2004 18:42:48 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 10 August 2004 17:06, Martin Schlemmer wrote:
>On Tue, 2004-08-03 at 20:21, Gene Heskett wrote:
>> Greetings;
>>
>> This machine has repeatadly passed memtest86-3a for as many as a
>> dozen full passes without errors.
>>
>> Running 2.6.8-rc2-mm2 which is an improvement, I almost got a 24
>> hour uptime.  BUT, it just went away again while trying to run the
>> FC2 version of up2date.
>>
>> A trimmed log, and my .config are attached, please, can someone
>> look at this?  I can also supply objdumps of the dcache.o file,
>> and a marked ((#asm "nop #char") style) up dcache.s file if you
>> can tell me where to put the markups.
>
>If not resolved yet - have you tried yet to disable 4K stacks ?
>Might not be related but can't hurt?

The last time I tried it, I don't believe it made any difference.  But 
I haven't tried it recently, Linus said to run it with everything 
turned on, so I haven't shut that off for the last 2-3 builds.  I've 
had to reboot 3 times since, but its not leaving any footprints in 
the logs, darnit.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.24% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
