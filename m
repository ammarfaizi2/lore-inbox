Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261689AbSKCImH>; Sun, 3 Nov 2002 03:42:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261690AbSKCImH>; Sun, 3 Nov 2002 03:42:07 -0500
Received: from h-64-105-136-52.SNVACAID.covad.net ([64.105.136.52]:32935 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S261689AbSKCImG>; Sun, 3 Nov 2002 03:42:06 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sun, 3 Nov 2002 00:48:30 -0800
Message-Id: <200211030848.AAA07537@adam.yggdrasil.com>
To: axboe@suse.de
Subject: Re: Patch(2.5.45): move io_restrictions to blkdev.h
Cc: linux-kernel@vger.kernel.org, thornber@sistina.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
>On Sat, Nov 02 2002, Adam J. Richter wrote:
>> 	This patch makes good on a threat that I posted yesterday
>> to move struct io_restrictions from <linux/device-mapper.h> to
>> <linux/blkdev.h>, eliminating duplication of a list of fields in
>> struct request_queue.

>Adam, I generally think the patch is a good idea. I also think it's a
>very stupid time to start messing with stuff that is basically trivial
>but still touches lost of stuff.

	It's pretty much simple string substitution and it doesn't
touch that many files, but OK.

>Please leave it alone for a few weeks.

>> 	Jens, can I persuade you to integrate this change?

>In due time, yes.

	Great.  The only thing I was going to do that might depend
on this patch is try to port /dev/loop to device mapper, and I may
be able to eliminate the affected code anyhow.

	I've checked in the change and will continue running it in the
meantime.  Unless I hear otherwise or run into a problem with this
patch, I'll plan to resubmit it around November 24.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."


