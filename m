Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265126AbSKRWDS>; Mon, 18 Nov 2002 17:03:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265059AbSKRV5O>; Mon, 18 Nov 2002 16:57:14 -0500
Received: from sccrmhc02.attbi.com ([204.127.202.62]:61864 "EHLO
	sccrmhc02.attbi.com") by vger.kernel.org with ESMTP
	id <S264939AbSKRVvs>; Mon, 18 Nov 2002 16:51:48 -0500
Message-ID: <3DD96803.7080407@kegel.com>
Date: Mon, 18 Nov 2002 14:21:55 -0800
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/4.0 (compatible; MSIE 5.5; Windows 98)
X-Accept-Language: de-de, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [rfc] epoll interface change and glibc bits ...
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich wrote:
>> epoll does hook f_op->poll() and hence uses the asm/poll.h bits.
> 
> It does today.  We are talking about "you promise that this will be the
> case ever after or we'll cut your head off".  I have no idea why you're
> so reluctant since you don't have to maintain any of the user-level
> bits.  And it is not you who has to deal with the fallout of a change
> when it happens.
> 
> If epoll is so different from poll (and this is what I've been told frmo
> Davide) then there should be a clear separation of the interfaces and
> all those arguing to unify the data types and constants better should
> rethink there understanding.

epoll is not really that different from poll, is it?
It delivers edge-triggered versions of the same events poll uses.
Or is there something epoll does I'm not aware of?
- Dan

