Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266708AbSKURhn>; Thu, 21 Nov 2002 12:37:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266720AbSKURhn>; Thu, 21 Nov 2002 12:37:43 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:4737 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S266708AbSKURhm>; Thu, 21 Nov 2002 12:37:42 -0500
X-AuthUser: davidel@xmailserver.org
Date: Thu, 21 Nov 2002 09:45:24 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Mark Mielke <mark@mark.mielke.cc>
cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [rfc] epoll interface change and glibc bits ...
In-Reply-To: <20021121165102.GA5315@mark.mielke.cc>
Message-ID: <Pine.LNX.4.44.0211210944570.962-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Nov 2002, Mark Mielke wrote:

> On Thu, Nov 21, 2002 at 06:08:16PM -0200, Denis Vlasenko wrote:
> > >   typedef union epoll_obj {
> > >   	void *ptr;
> > >         int fd;
> > >   	__uint32_t u32[2];
> > >   	__uint64_t u64;
> > >   } epoll_obj_t;
> > u32 and u64 sounds more like type name. d32 / d64 ?
>
> d32 isn't as descriptive as u32 (unsigned). Also if every field had a 'd'
> in front of it, it would be 'dptr', 'dfd', ...
>
> u32 is fine to me.

I renamed epoll_obj_t to epoll_data_t ...



- Davide


