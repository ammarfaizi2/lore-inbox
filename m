Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284186AbRLASJa>; Sat, 1 Dec 2001 13:09:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284192AbRLASJT>; Sat, 1 Dec 2001 13:09:19 -0500
Received: from netfinity.realnet.co.sz ([196.28.7.2]:19173 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S284187AbRLASJE>; Sat, 1 Dec 2001 13:09:04 -0500
Date: Sat, 1 Dec 2001 20:13:53 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: <zwane@netfinity.realnet.co.sz>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] if (foo) kfree(foo) /fs cleanup + reverted JBD code path
 changes
In-Reply-To: <871yierf3d.fsf@devron.myhome.or.jp>
Message-ID: <Pine.LNX.4.33.0112012012200.14914-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Dec 2001, OGAWA Hirofumi wrote:

> Zwane Mwaikambo <zwane@linux.realnet.co.sz> writes:
>
> > On Sun, 2 Dec 2001, OGAWA Hirofumi wrote:
> > > In all failed cases, this message will be outputted. I think I shouldn't do
> > > so. (or remove this message.)
> >
> > I found all sorts of interesting things in my little adventure...
> > Heres an interesting one;
>
> Do you want to see the following message, even when not using nls?
>
> FAT: freeing iocharset=<NULL>

Ok in that case the it would never get there with a valid iocharset.
Probably old debugging code which lost its way ;)

Cheers,
	Zwane Mwaikambo



