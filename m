Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265238AbSJWVU0>; Wed, 23 Oct 2002 17:20:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265240AbSJWVU0>; Wed, 23 Oct 2002 17:20:26 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:10397 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S265238AbSJWVU0>; Wed, 23 Oct 2002 17:20:26 -0400
X-AuthUser: davidel@xmailserver.org
Date: Wed, 23 Oct 2002 14:35:16 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Benjamin LaHaise <bcrl@redhat.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>
Subject: Re: epoll (was Re: [PATCH] async poll for 2.5)
In-Reply-To: <20021023171818.B9700@redhat.com>
Message-ID: <Pine.LNX.4.44.0210231434070.1581-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Oct 2002, Benjamin LaHaise wrote:

> On Wed, Oct 23, 2002 at 11:47:33AM -0700, Davide Libenzi wrote:
> > Ben, does it work at all currently read/write requests on sockets ? I
> > would like to test AIO on networking using my test http server, and I was
> > thinking about using poll() for async accept and AIO for read/write. The
> > poll() should be pretty fast because there's only one fd in the set and
> > the remaining code will use AIO for read/write. Might this work currently ?
>
> The socket async read/write code is not yet in the kernel.

Ok, this pretty much stops every attempt to test/compare AIO with sys_epoll ...
ETA ?



- Davide


