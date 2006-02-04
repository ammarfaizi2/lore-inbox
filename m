Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946299AbWBDDcn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946299AbWBDDcn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 22:32:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946300AbWBDDcn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 22:32:43 -0500
Received: from vms042pub.verizon.net ([206.46.252.42]:51683 "EHLO
	vms042pub.verizon.net") by vger.kernel.org with ESMTP
	id S1946299AbWBDDcm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 22:32:42 -0500
Date: Fri, 03 Feb 2006 22:32:40 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: [2.6.16rc2] compile error
In-reply-to: <20060203200452.GA29077@mars.ravnborg.org>
To: linux-kernel@vger.kernel.org
Reply-to: gene.heskett@verizon.net
Message-id: <200602032232.40929.gene.heskett@verizon.net>
Organization: Absolutely none - usually detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <ds08vk$hk$1@sea.gmane.org>
 <200602031447.53193.gene.heskett@verizon.net>
 <20060203200452.GA29077@mars.ravnborg.org>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 03 February 2006 15:04, Sam Ravnborg wrote:
>On Fri, Feb 03, 2006 at 02:47:53PM -0500, Gene Heskett wrote:
>> >You are hit be an outstanding issue with -rc1 + rc2.
>> >When you build as root you will alter /dev/null and in your case it
>> >became a regular file.
>>
>> That didn't hit me Sam, and I built it as root, running it right
>> now.
>
>First you need to do make clean or make menuconfig to trigger
> theerror. Second, not all /dev/null are affected. On my gentoo box it
> does not fail.

I forgot to add that my makeit script does a make clean as the 2nd step, 
the first is a version check to make sure I edited it correctly.  My 
ancient fingers don't always type what I think...

> Sam
>-
>To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
Cheers, Gene
People having trouble with vz bouncing email to me should add the word
'online' between the 'verizon', and the dot which bypasses vz's
stupid bounce rules.  I do use spamassassin too. :-)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2006 by Maurice Eugene Heskett, all rights reserved.
