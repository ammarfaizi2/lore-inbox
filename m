Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287756AbSAIQIS>; Wed, 9 Jan 2002 11:08:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287720AbSAIQIJ>; Wed, 9 Jan 2002 11:08:09 -0500
Received: from 216-42-72-144.ppp.netsville.net ([216.42.72.144]:15312 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S287743AbSAIQH5>; Wed, 9 Jan 2002 11:07:57 -0500
Date: Wed, 09 Jan 2002 11:07:29 -0500
From: Chris Mason <mason@suse.com>
To: Oleg Drokin <green@namesys.com>
cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org,
        reiserfs-dev@namesys.com, adilger@turbolabs.com
Subject: Re: [reiserfs-dev] [PATCH] UUID & volume labels support for
 reiserfs
Message-ID: <100150000.1010592449@tiny>
In-Reply-To: <20020109185826.A1680@namesys.com>
In-Reply-To: <20020109155504.A4551@namesys.com> <52160000.1010591279@tiny>
 <20020109185826.A1680@namesys.com>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wednesday, January 09, 2002 06:58:26 PM +0300 Oleg Drokin
<green@namesys.com> wrote:

> Hello!
> 
> On Wed, Jan 09, 2002 at 10:47:59AM -0500, Chris Mason wrote:
> 
>> >     Attached is the patch that reserves space for volume label and UUID
>> > in reiserfs v3.6 superblock.     It also generates random UUID for
>> > volumes converted from 3.5 to 3.6 format by the kernel.     Original
>> > patch author is Andreas Dilger <adilger@turbolabs.com>.     Please
>> > apply.
>> This should not be applied until an updated (non beta) reiserfsprogs
>> package that supports these features has been released.
> Hey, reserving some space in superblock won't hurt.

Reserving it is fine ;-)  Using it isn't a good idea until the progs
understand it.  Our policy should be to never require a progs update in a
stable kernel series (just like most stable parts of the kernel).

But, the progs are improving so quickly that we should bend this rule a
little bit.  Another example is the unlink truncate patch never should have
been sent to Marcelo without a non-beta reiserfsprogs that understood it.
Neither should this patch (even though it is a much smaller problem).

-chris

