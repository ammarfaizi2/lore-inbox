Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932290AbVKWUPm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932290AbVKWUPm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 15:15:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932292AbVKWUPm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 15:15:42 -0500
Received: from vms042pub.verizon.net ([206.46.252.42]:33887 "EHLO
	vms042pub.verizon.net") by vger.kernel.org with ESMTP
	id S932290AbVKWUPl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 15:15:41 -0500
Date: Wed, 23 Nov 2005 15:14:16 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: Linux 2.6.15-rc2
In-reply-to: <4384C909.4040107@m1k.net>
To: linux-kernel@vger.kernel.org, mkrufky@m1k.net
Cc: Adrian Bunk <bunk@stusta.de>, Johannes Stezenbach <js@linuxtv.org>,
       Sam Ravnborg <sam@ravnborg.org>, Kirk Lapray <kirk.lapray@gmail.com>
Message-id: <200511231514.17157.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <Pine.LNX.4.64.0511191934210.8552@g5.osdl.org>
 <200511231436.54136.gene.heskett@verizon.net> <4384C909.4040107@m1k.net>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 23 November 2005 14:54, Michael Krufky wrote:
>Gene Heskett wrote:
>>On Wednesday 23 November 2005 14:17, Michael Krufky wrote:
>>
>>[...]
>>
>>>f it fixes Gene's problem (a quick glance at his emails suggests that
>>>it does) then:
>>
>>Read further Michael, it still takes a _cold_ reboot to 2.6.14.2 to
>> fix it.
>
>I'm sorry -- I should have been clearer... It fixes the following error
>message, correct?
>
>Gene Heskett wrote:
>> WARNING:/lib/modules/2.6.15-rc2/kernel/drivers/media/video/cx88/cx88-
>>dvb .ko needs unknown symbol nxt200x_attach.
>
>About the cold reboot needed for 2.6.14.2, well, that is completely
>unrelated...
>
>First, does the patch fix the unknown symbol error?  If so, then the
>patch is correct.

Yes, it fixes that just fine.
>
>Moving on........
>
>Kirk Lapray wrote both OR51132 and NXT200X frontend modules (cc added)
> ...
>
>First off, Gene, I am still under the impression that both v4l and dvb
>subsystems are broken under 2.6.15 due to the memory bugs... I don't
>know if Hugh Dickins fixed those yet or not.

Neither do I.  But as a tv engineer with 50+ years of experience, the
general appearance is if the antenna cable has been disconnected and
held about 2" away from the f-59 connector when a hot reboot is done. 
The audio in both cases sounds like its a station 300 miles away when
the atmospherics are behaving themselves.
>
>Please try to build merged v4l+dvb cvs trees against your 2.6.14.2
>kernel, and tell me if you are having the same problems.  If you are
>indeed having the same problem, then it confirms that something in the
>nxt200x module is causing problems in the OR51132 module.

And how & where do I obtain that?

>Kirk, are you able to use both modules together using both pcHDTV and
>ATI HDTV Wonder PCI cx88 boards simultaneously without causing any
>conflicts?
>
>Once again, Gene, please follow the tree-merge instructions located at:
>
>http://linuxtv.org/v4lwiki/index.php/How_to_build_from_CVS

I'll give this a shot and advise on the results.

>Please let me know if the problem persists.  If the problem is gone,
>then nxt200x is a red herring.
>
>Regards,
>
>Michael Krufky

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.36% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.

