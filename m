Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264814AbSK0Uyw>; Wed, 27 Nov 2002 15:54:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264822AbSK0Uyw>; Wed, 27 Nov 2002 15:54:52 -0500
Received: from h-64-105-35-74.SNVACAID.covad.net ([64.105.35.74]:43142 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S264814AbSK0Uyv>; Wed, 27 Nov 2002 15:54:51 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Wed, 27 Nov 2002 12:59:46 -0800
Message-Id: <200211272059.MAA07630@baldur.yggdrasil.com>
To: hch@infradead.org
Subject: Re: Patch/resubmit(2.5.49): Use struct io_restrictions in blkdev.h
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On Wed, Nov 27, 2002 at 11:49:40AM -0800, Adam J. Richter wrote:
>> 	Here is an updated version of the patch.  The struct
>> io_restrictions declaration is in <linux/device-mapper.h> so that the
>> device-mapper user level utilities compile properly (device-mapper.h
>> is written to support inclusion by user level programs).

>They shouldn't include it anyway.  Please put it into a proper place.

	I don't know what you mean by "shouldn't" or "proper" in this
context.  If you'd state technical advantages or disadvanges, others
could determine these labels for themselves.

	Anyhow, what would be a "proper" place as you see it?

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
