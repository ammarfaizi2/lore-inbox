Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317066AbSFKPQ1>; Tue, 11 Jun 2002 11:16:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317121AbSFKPQ1>; Tue, 11 Jun 2002 11:16:27 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:43102 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S317066AbSFKPQZ>; Tue, 11 Jun 2002 11:16:25 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Helge Hafting <helgehaf@aitel.hist.no>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Futex Asynchronous Interface
In-Reply-To: <Pine.LNX.4.44.0206100810380.30336-100000@home.transmeta.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 11 Jun 2002 09:06:40 -0600
Message-ID: <m1r8jdvoqn.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

> On Mon, 10 Jun 2002, Helge Hafting wrote:
> >
> > Not much, but
> > ls /dev/net
> > eth0 eth1 eth2 ippp0
> > would be a convenient way to see what net devices exists.
> > This already works for other devices, when using devfs.
> 
> You might as well do
> 
> 	cat /proc/net/dev
> 
> instead.
> 
> Which works with existing kernels, going back to whatever..

Gap, puke.  

Sorry I have built kernels where space was tight and I only built in
/proc so I could read /proc/net/dev.  And since with /proc everything
is all in one basket it is very hard to turn off unneeded features.

/proc might be nice to user space but as it is implemented it is
nasty to work with.

So a netdevfs or some solution that factors better would really
be nice.

Eric
