Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751730AbWJUGIh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751730AbWJUGIh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 02:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751729AbWJUGIh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 02:08:37 -0400
Received: from vms044pub.verizon.net ([206.46.252.44]:13210 "EHLO
	vms044pub.verizon.net") by vger.kernel.org with ESMTP
	id S1751157AbWJUGIg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 02:08:36 -0400
Date: Sat, 21 Oct 2006 02:08:32 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: 2.6.19-rc1, timebomb?
In-reply-to: <20061021050341.GA32640@tuatara.stupidest.org>
To: linux-kernel@vger.kernel.org
Message-id: <200610210208.32203.gene.heskett@verizon.net>
Organization: Organization? Absolutely zip.
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <200610200130.44820.gene.heskett@verizon.net>
 <200610210037.57871.gene.heskett@verizon.net>
 <20061021050341.GA32640@tuatara.stupidest.org>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 21 October 2006 01:03, Chris Wedgwood wrote:
>On Sat, Oct 21, 2006 at 12:37:56AM -0400, Gene Heskett wrote:
>> I guess I'm 'waiting for the other shoe to drop' Until that time,
>> everything seems normal.  But I did just note that 'fam' is using up
>> to 99.3% of the cpu, which is unusual considering that amanda is
>> also running, and its usually gtar thats the hog.  This is according
>> to htop.
>
>I've had a few spontaneous restarts (which actually might have been
>shutdowns, any key press will make the machine up so a power down when
>working would probably look like a restart).
>
>I've assumed these were heat related, mostly because they also
>occurred when the CPU was working hard and the weather has been pretty
>warm lately.

These may be related.  But I'm not convinced weather has anything to do 
with it.  The cpu is running about 120F, and is busier by quite a few 
processes than it was when the last failure occured. 

The 'fam' that was using 99.3% of the cpu, and which disappeared when I 
sent it a SIGHUP, has not returned, and amanda has completed her nightly 
chores without any hiccups.  It was not started as a service and is unk to 
getting a status report from it.  So I'm wondering just where it fits in 
the grand scheme of things?

>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2006 by Maurice Eugene Heskett, all rights reserved.
