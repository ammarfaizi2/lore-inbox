Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280091AbRKIUkM>; Fri, 9 Nov 2001 15:40:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280095AbRKIUkB>; Fri, 9 Nov 2001 15:40:01 -0500
Received: from [195.66.192.167] ([195.66.192.167]:531 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S280091AbRKIUjn>; Fri, 9 Nov 2001 15:39:43 -0500
Content-Type: text/plain; charset=US-ASCII
From: vda <vda@port.imtp.ilyichevsk.odessa.ua>
To: Ken Brownfield <brownfld@irridia.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.>=13 VM/kswapd/shmem/Oracle issue (was Re: Google's mm problems)
Date: Fri, 9 Nov 2001 22:39:11 +0000
X-Mailer: KMail [version 1.2]
In-Reply-To: <E15yhyY-0000Yb-00@starship.berlin> <20011109033851.A15099@asooo.flowerfire.com>
In-Reply-To: <20011109033851.A15099@asooo.flowerfire.com>
MIME-Version: 1.0
Message-Id: <01110922391101.00807@nemo>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 09 November 2001 09:38, Ken Brownfield wrote:

> We're seeing an easily reproducible problem that I believe to be along
> the same lines as what Google is seeing.  I'm not sure if Oracle's SGA
> (shmem) can be mlock()ed, but I'm guessing there's a state analogous to
> Solaris' ISM.  We're seeing this on a 4GB machine with HIGHMEM/HIGHMEM4G
> set, using 2.4.1{3,4,5-pre1}.

[SNIP]

Oracle is a horrendous memory hog.
Looks like it's getting more bloated with each next release.

If I will start some seriuos database programming,
I will try PostgreSQL first... it is at least Open Source,
we can see what's inside.

> Basically, this problem makes it impossible to run Oracle on Linux,
> which is really a massive problem from our point of view.  If someone
> could show me how to provide more useful information or further debug
> this problem, I would greatly appreciate it.  This includes specific
> alternate kernels, or perhaps without HIGHMEM4G or HIGHMEM.

Whee, looks like you guys really willing to resolve this...
Pity I can't do anything for you. Let's hope some VM folks will be
interested.
--
vda
