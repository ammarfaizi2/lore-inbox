Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284516AbRLJWtV>; Mon, 10 Dec 2001 17:49:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284526AbRLJWtL>; Mon, 10 Dec 2001 17:49:11 -0500
Received: from hera.cwi.nl ([192.16.191.8]:58057 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S284516AbRLJWsx>;
	Mon, 10 Dec 2001 17:48:53 -0500
From: Andries.Brouwer@cwi.nl
Date: Mon, 10 Dec 2001 22:48:17 GMT
Message-Id: <UTC200112102248.WAA284049.aeb@cwi.nl>
To: Andries.Brouwer@cwi.nl, alan@lxorguk.ukuu.org.uk
Subject: Re: Linux/Pro  -- clusters
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com, viro@math.psu.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Basically you seem to be saying
> "void *  is cool" (aka kdev_t is basically an opaque magic).

Well, kdev_t is just as opaque as struct inode *.
One refers to what you want to know about a block device.
The other to what you want to know about an inode.

> I don't see what it gains you over "struct block_device *".

That is difficult to say, since the present struct block_device
still has a long way to go. At present it has no facilities
for storing data. Maybe the final results would be the same.
My main objective has always been to do a mechanical,
correctness preserving change (as the first and major step).

This means that very early on the road the objectives
"no arrays" and "large device numbers" are achieved.
Afterwards one can continue restructuring and polishing
as desired. Al's approach (as I understand it) will
achieve the same things, but later, and with more handwork.

Andries
