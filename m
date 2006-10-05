Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751672AbWJELBV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751672AbWJELBV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 07:01:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751675AbWJELBV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 07:01:21 -0400
Received: from vms044pub.verizon.net ([206.46.252.44]:19434 "EHLO
	vms044pub.verizon.net") by vger.kernel.org with ESMTP
	id S1751672AbWJELBU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 07:01:20 -0400
Date: Thu, 05 Oct 2006 07:01:15 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: 2.6.19-rc1: known regressions
In-reply-to: <20061005063700.GH5170@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <jens.axboe@oracle.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Adrian Bunk <bunk@stusta.de>, Linus Torvalds <torvalds@osdl.org>
Message-id: <200610050701.15559.gene.heskett@verizon.net>
Organization: Organization? Absolutely zip.
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <Pine.LNX.4.64.0610042017340.3952@g5.osdl.org>
 <1160023503.22232.10.camel@localhost.localdomain>
 <20061005063700.GH5170@kernel.dk>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 October 2006 02:37, Jens Axboe wrote:
>On Thu, Oct 05 2006, Benjamin Herrenschmidt wrote:
>> On Thu, 2006-10-05 at 06:28 +0200, Adrian Bunk wrote:
>> > Contrary to popular belief, there are people who test -rc kernels
>> > and report bugs.
>> >
>> > And there are even people who test -git kernels.
>> >
>> > This email lists some known regressions in 2.6.19-rc1 compared to
>> > 2.6.18.
>> >
>> > If you find your name in the Cc header, you are either submitter of
>> > one of the bugs, maintainer of an affectected subsystem or driver, a
>> > patch of you was declared guilty for a breakage or I'm considering
>> > you in any other way possibly involved with one or more of these
>> > issues.
>> >
>> > Due to the huge amount of recipients, please trim the Cc when
>> > answering.

No idea who to trim, sorry.

It is possible to setup in kconfig, an initramfs system that won't boot, 
giving the message as it locks up tight that there is not any initramfs 
cpio magic.  I have it rebuilding now with the proper options turned on I 
hope.

>> Add sleep/wakeup on powerbooks apparently busted. Haven't tracked down
>> yet.
>
>Let me know if it appears to be ide related, there's a chance it could
>be the same thing as:
>
>Subject    : DVD drive lost DVD capabilities
>References : http://lkml.org/lkml/2006/10/1/45
>Submitter  : Olaf Hering <olaf@aepfle.de>
>Guilty     : Jens Axboe <axboe@suse.de>
>             commit 4aff5e2333c9a1609662f2091f55c3f6fffdad36
>Handled-By : Jens Axboe <axboe@suse.de>
>Status     : Jens is working on a fix

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2006 by Maurice Eugene Heskett, all rights reserved.
