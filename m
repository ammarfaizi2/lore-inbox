Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286413AbSAIQjq>; Wed, 9 Jan 2002 11:39:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287827AbSAIQjh>; Wed, 9 Jan 2002 11:39:37 -0500
Received: from 216-42-72-144.ppp.netsville.net ([216.42.72.144]:31696 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S286413AbSAIQjY>; Wed, 9 Jan 2002 11:39:24 -0500
Date: Wed, 09 Jan 2002 11:38:32 -0500
From: Chris Mason <mason@suse.com>
To: Oleg Drokin <green@namesys.com>
cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org,
        reiserfs-dev@namesys.com, adilger@turbolabs.com
Subject: Re: [reiserfs-dev] [PATCH] UUID & volume labels support for
 reiserfs
Message-ID: <145590000.1010594312@tiny>
In-Reply-To: <20020109192526.A1732@namesys.com>
In-Reply-To: <20020109155504.A4551@namesys.com> <52160000.1010591279@tiny>
 <20020109185826.A1680@namesys.com> <100150000.1010592449@tiny>
 <20020109192526.A1732@namesys.com>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wednesday, January 09, 2002 07:25:26 PM +0300 Oleg Drokin
<green@namesys.com> wrote:

> Hello!
> 
> On Wed, Jan 09, 2002 at 11:07:29AM -0500, Chris Mason wrote:
> 
>> >> This should not be applied until an updated (non beta) reiserfsprogs
>> >> package that supports these features has been released.
>> > Hey, reserving some space in superblock won't hurt.
>> Reserving it is fine ;-)  Using it isn't a good idea until the progs
> So we did it (reserved) ;)
> We do not use it. (generating of UUID does not count)

Yes, generating a uuid and storing in the super block counts as using the
field ;-)

> 
>> understand it.  Our policy should be to never require a progs update in a
>> stable kernel series (just like most stable parts of the kernel).
> We do not require progs upadte. But if someone will update their progs
> voluntarily, we cannot forbit them to! ;))
> 

The point is that we should never add something to the kernel until our
utils package understands it.  Yes, this is a simple case, but if we want
to call reiserfs stable, there are some basic rules we need to start
following.

-chris

