Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280116AbRKECMt>; Sun, 4 Nov 2001 21:12:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280128AbRKECMj>; Sun, 4 Nov 2001 21:12:39 -0500
Received: from [202.135.142.194] ([202.135.142.194]:61707 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S280116AbRKECMW>; Sun, 4 Nov 2001 21:12:22 -0500
Date: Mon, 5 Nov 2001 11:12:39 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: tim@tjansen.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5 PROPOSAL: Replacement for current /proc of shit.
Message-Id: <20011105111239.3403b162.rusty@rustcorp.com.au>
In-Reply-To: <20011104013951Z16981-4784+741@humbolt.nl.linux.org>
In-Reply-To: <E15zF9H-0000NL-00@wagner>
	<15zGYm-1gibkeC@fmrl05.sul.t-online.com>
	<20011102132014.41f2d90a.rusty@rustcorp.com.au>
	<20011104013951Z16981-4784+741@humbolt.nl.linux.org>
X-Mailer: Sylpheed version 0.5.3 (GTK+ 1.2.10; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Nov 2001 02:40:51 +0100
Daniel Phillips <phillips@bonn-fries.net> wrote:

> On November 2, 2001 03:20 am, Rusty Russell wrote:
> > I agree with the "one file, one value" idea.
> 
> So cat /proc/partitions goes from being a nice, easy to read and use human 
> interface to something other than that.  Lets not go overboard.

Firstly, do not perpetuate the myth of /proc being "human readable".  (Hint:
what language do humans speak?)  It supposed to be "admin readable" and
"machine readable".

Secondly, it is possible to implement a table formatter which kicks in
when someone does a read() on a directory.  This is not a desirable format:
look at /proc/mounts when you have a mount point with a space in it for a
good example.

Thanks!
Rusty.
