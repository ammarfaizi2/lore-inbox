Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267514AbRGXNDD>; Tue, 24 Jul 2001 09:03:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267516AbRGXNCy>; Tue, 24 Jul 2001 09:02:54 -0400
Received: from dsl-64135210.acton.ma.internetconnect.net ([64.13.5.210]:58810
	"EHLO alliance.centerclick.org") by vger.kernel.org with ESMTP
	id <S267514AbRGXNCf>; Tue, 24 Jul 2001 09:02:35 -0400
Mime-Version: 1.0
Message-Id: <v04210100b783212ef7bd@[10.0.2.30]>
In-Reply-To: <20010724102526.K4221@suse.de>
In-Reply-To: <v04210101b781c827accb@[10.0.2.30]>
 <20010724102526.K4221@suse.de>
X-Mailer: QUALCOMM MacOS Eudora Pro Version 4.2.1 (PPC)
Date: Tue, 24 Jul 2001 09:02:33 -0400
To: Jens Axboe <axboe@suse.de>
From: David Johnson <dave-kernel-list@centerclick.org>
Subject: Re: DVD-RAM media detected with wrong number of blocks (2.4.7)
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On 7/24/01, Jens Axboe wrote:
>On Mon, Jul 23 2001, David Johnson wrote:
>> When attempting to create an ext2 partition on a dvd-ram (2.6G/5.2G)
>> media the number of blocks is detected wrong causing only half of the
>> disk to be usable.  When creating the filesystem with mke2fs only
>> 609480 2K blocks are allowed instead of 1218960 2K blocks, and I end
>> up with a 1.2GB partition instead of 2.4GB one.  The 1.2GB fs works
>> fine, it's just a bit small :(
>>
>> This is with 2.4.7 using a Creative DVD-RAM drive (1216S) on an Adaptec
>> 2940UW.
>>
>> The correct number of blocks is detected in 2.4.6
>
>Does this work?
>

Shifting another bit causes the size to get cut in half again, not 
shifting at all appears to be the correct thing to do.

