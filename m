Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751705AbWJUEh7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751705AbWJUEh7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 00:37:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751710AbWJUEh6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 00:37:58 -0400
Received: from vms042pub.verizon.net ([206.46.252.42]:35245 "EHLO
	vms042pub.verizon.net") by vger.kernel.org with ESMTP
	id S1751698AbWJUEh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 00:37:58 -0400
Date: Sat, 21 Oct 2006 00:37:56 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: 2.6.19-rc1, timebomb?
In-reply-to: <20061020212244.56f9f02b@localhost>
To: linux-kernel@vger.kernel.org
Cc: Chris Largret <largret@gmail.com>
Message-id: <200610210037.57871.gene.heskett@verizon.net>
Organization: Organization? Absolutely zip.
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <200610200130.44820.gene.heskett@verizon.net>
 <20061020212244.56f9f02b@localhost>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 21 October 2006 00:22, Chris Largret wrote:
>On Fri, 20 Oct 2006 01:30:44 -0400
>
>Gene Heskett <gene.heskett@verizon.net> wrote:
>> Greetings;
>>
>> I just arrived home a few hours ago, and my wife said the outside
>> lights hadn't worked for the last 2 days.
>>
>> I come in to check, the this machine, which runs some heyu scripts to
>> do this, was powered down.  So I powered it back up and it had to e2fsk
>> everything.  I have a ups with a fresh battery which passes the tests
>> just fine.
>>
>> The only thing in the logs is a single line about eth0 being down:
>> Oct 17 05:31:11 coyote kernel: eth0: link down.
>> Oct 19 20:37:49 coyote syslogd 1.4.1: restart.
>>
>> Uptime when this occurred was about 9 days.  Was this a known problem?
>
>Out of curiosity, did you check the UPS logs? The low- (and mid- ?)
>range ones I've played with have logs as well as the ability to tell
>the computer when there is a power problem. I'd check those logs and
>also look in the system BIOS for a way to power the computer back on
>when power returns. If it was powered off, I don't believe it would be
>kernel-related.
>
yes, they were clean.  Its a 1500kva Belkin, not exactly a small ups.

>I could always be wrong, but from my own experiences kernel problems
>result in a system that is on but not operational.

ISTR that was the second time an un-logged powerdown has been done since 
that kernel became the default.  For all practical purposes, it the equ of 
tapping the hard reset button and before it can start to reboot, the 4 
second powerdown expires and things get real quiet.

I guess I'm 'waiting for the other shoe to drop'  Until that time, 
everything seems normal.  But I did just note that 'fam' is using up to 
99.3% of the cpu, which is unusual considering that amanda is also 
running, and its usually gtar thats the hog.  This is according to htop.

That doesn't seem to be what I'd expect to see, thats for sure.  Even 
wierder, I just used htop to send it a SIGHUP and its now gone.  WTF??  Me 
wanders off for some sleep while the real brains ponder that one.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2006 by Maurice Eugene Heskett, all rights reserved.
