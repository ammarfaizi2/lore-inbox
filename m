Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276688AbRJPWel>; Tue, 16 Oct 2001 18:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276745AbRJPWea>; Tue, 16 Oct 2001 18:34:30 -0400
Received: from Expansa.sns.it ([192.167.206.189]:33804 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S276688AbRJPWeU>;
	Tue, 16 Oct 2001 18:34:20 -0400
Date: Wed, 17 Oct 2001 00:31:29 +0200 (CEST)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Rik van Riel <riel@conectiva.com.br>
cc: David Lang <david.lang@digitalinsight.com>,
        safemode <safemode@speakeasy.net>, <linux-kernel@vger.kernel.org>
Subject: Re: VM
In-Reply-To: <Pine.LNX.4.33L.0110161610170.6440-100000@imladris.surriel.com>
Message-ID: <Pine.LNX.4.33.0110170000180.19439-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 16 Oct 2001, Rik van Riel wrote:

> On Tue, 16 Oct 2001, David Lang wrote:
>
> > when 2.4 works it is FAR better then 2.2 and it has features not
> > available on 2.2, but with the Rik VM (versions that were in the linus
> > kernels up through 2.4.9) it has not reliably worked.
>
> Note that Linus hasn't been up to date on my VM since
> about 2.4.5.  And before you blame me for not sending
> patches, I did send them but Linus didn't apply them
> for unknown reasons.
>
2.4.5 had a little showstopper problem with iommu, and so my old E 3500
was really suffering with it.
As you know, VM performances are not the first priority for some servers,
while they are for desktops and for servers used for computational
simulations. But right now, definitelly, we are not at the point we copuld
care of 5% faster or slower. What we do care right now is to have a VM
that works for the jobs we need to be done. Belive me, that is a good
thing, and this also explain why people write that the VM is great, and
other that the VM is a disaster.

Sometimes I do not understand Linus decisions, but history showed he is
Linus and I am a simple Sysadmin who trys to give his contrib.

I am not arguing your VM was overdesigned, and to be honest I simply do
not think so.

One thing that should be took in account is that your VM
in ac tree  before 2.4.9acX was behaving better on sparc64 than x86
processors. Belive me i stressed a ultra5 (400 Mhz sparc64 processor 512
Megabyte of RAM) with a 2.4.8ac(not remember exactly) kernel, and it was
stable under a very high load.
A mutch faster Athlon 1000 Mhz, with same amount of faster memory, and
same UDMA66 disk, showed a suffering VM even not being equally
stressed.
maybe your approach was better working on this kind of architecture. (I am
sorry I could not test some mips).
On the other side your VM has some behavious that remembers me of my old
AIX times :). (you know I tend to be a bit nostalgic).

On the other side, AA VM (2.4.13-pre3aa1) is exactly what I need on my
webservers. You VM is more effective on a higly stressed server running
hundreds of eavty and memory intensive simulations on it (and also in
this case, I do not care it to be the fastest, but it has to be adle to
bring simulations to work properly).

That brings me to the point I made in my previous post.

If you remember the oops I sended you a lot of months ago with 2.4.3,
it was related to a server that had not to be fast, but had to reach years
of uptime.

When i think to desktops, I change my mind, they have to be as faster as
possible.

Linux does work on any kind of CPU, from a domain on SUN E 10000, to a 386
sx 25Mhz, and potentially it can be used for everything. This brings a
critical complexity to the VM, and this makes development difficoult.
This is a situation we must deal with.

Luigi


