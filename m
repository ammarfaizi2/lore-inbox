Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271318AbRHZMmT>; Sun, 26 Aug 2001 08:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271326AbRHZMmK>; Sun, 26 Aug 2001 08:42:10 -0400
Received: from juicer24.bigpond.com ([139.134.6.34]:26070 "EHLO
	mailin3.email.bigpond.com") by vger.kernel.org with ESMTP
	id <S271318AbRHZMl6>; Sun, 26 Aug 2001 08:41:58 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Ebling <kernelhacker@lineone.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: suggestions for new kernel hacking-HOWTO 
In-Reply-To: Your message of "23 Aug 2001 22:29:27 +0100."
             <998602169.405.21.camel@elixr.jfreak> 
Date: Sun, 26 Aug 2001 00:01:41 +1000
Message-Id: <E15ae0N-0008Pa-00@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <998602169.405.21.camel@elixr.jfreak> you write:
> Hi all,
> 
> I am considering putting together a new, more in depth kernel hacking
> HOWTO.  
> 
> The existing HOWTO (by Rusty), although an excellent source of technical
> information does not contain much practical advice on how to get
> started.

This sounds fantastic!  I'd always hoped that my document would be a
starting point for something more substantial, yet it never happened
8(

One word of warning: beware tying it too closely to shifting
architecture.  In particular, the original HOWTO was aimed at pointing
experienced programmers in the right direction, not reading the code
to them.

Perhaps consider adding:

	Kernel Style
		Don't do it in the kernel
		Don't sprinkle ifdefs
		User interfaces: read/write better than ioctls
		Architecture specific code & portability
		GNU extensions

	Kernel Politics:
		Licencing
		How to get a patch in
		Who owns what code?

Hope that helps,
Rusty.
--
Premature optmztion is rt of all evl. --DK
