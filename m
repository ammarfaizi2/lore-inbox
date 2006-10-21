Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423351AbWJUPKz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423351AbWJUPKz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 11:10:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423350AbWJUPKz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 11:10:55 -0400
Received: from vms044pub.verizon.net ([206.46.252.44]:16069 "EHLO
	vms044pub.verizon.net") by vger.kernel.org with ESMTP
	id S1423352AbWJUPKy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 11:10:54 -0400
Date: Sat, 21 Oct 2006 11:10:51 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: 2.6.19-rc1, timebomb?
In-reply-to: <200610210208.32203.gene.heskett@verizon.net>
To: linux-kernel@vger.kernel.org
Message-id: <200610211110.51894.gene.heskett@verizon.net>
Organization: Organization? Absolutely zip.
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <200610200130.44820.gene.heskett@verizon.net>
 <20061021050341.GA32640@tuatara.stupidest.org>
 <200610210208.32203.gene.heskett@verizon.net>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 21 October 2006 02:08, Gene Heskett wrote:
>On Saturday 21 October 2006 01:03, Chris Wedgwood wrote:
>>On Sat, Oct 21, 2006 at 12:37:56AM -0400, Gene Heskett wrote:
>>> I guess I'm 'waiting for the other shoe to drop' Until that time,
>>> everything seems normal.  But I did just note that 'fam' is using up
>>> to 99.3% of the cpu, which is unusual considering that amanda is
>>> also running, and its usually gtar thats the hog.  This is according
>>> to htop.
>>
>>I've had a few spontaneous restarts (which actually might have been
>>shutdowns, any key press will make the machine up so a power down when
>>working would probably look like a restart).
>>
>>I've assumed these were heat related, mostly because they also
>>occurred when the CPU was working hard and the weather has been pretty
>>warm lately.
>
>These may be related.  But I'm not convinced weather has anything to do
>with it.  The cpu is running about 120F, and is busier by quite a few
>processes than it was when the last failure occured.
>
>The 'fam' that was using 99.3% of the cpu, and which disappeared when I
>sent it a SIGHUP, has not returned, and amanda has completed her nightly
>chores without any hiccups.  It was not started as a service and is unk
> to getting a status report from it.  So I'm wondering just where it fits
> in the grand scheme of things?
>
Further addendum:  Another shutdown this morning, and the only line in the 
log is the 3rd one here:

Oct 21 07:42:18 coyote kernel: usb 3-2.1: reset low speed USB device using 
ohci_hcd and address 3
Oct 21 07:51:39 coyote kernel: usb 3-2.1: reset low speed USB device using 
ohci_hcd and address 3
Oct 21 08:01:01 coyote kernel: eth0: link down. <<------<<<
Oct 21 10:53:12 coyote syslogd 1.4.1: restart.

Thats a microsoft wireless mouse it keeps resetting, and I hadn't been in 
the room in 2+ hours.  My logs are littered with that message, but the 
mouse itself works fine.  I'd estimate that the mouse reset is over 90% of 
the content of my messages logs, and has been since back around 2.6.16 
days.  The batteries are fine.

I'm back to 2.6.18, but will build 2.6.19-rc2 shortly.

>>-
>>To unsubscribe from this list: send the line "unsubscribe linux-kernel"
>> in the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>Please read the FAQ at  http://www.tux.org/lkml/

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2006 by Maurice Eugene Heskett, all rights reserved.
