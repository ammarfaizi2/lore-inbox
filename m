Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269580AbRHCT70>; Fri, 3 Aug 2001 15:59:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269570AbRHCT7Q>; Fri, 3 Aug 2001 15:59:16 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:59400 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S269580AbRHCT7M>;
	Fri, 3 Aug 2001 15:59:12 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200108031959.f73Jx2d480109@saturn.cs.uml.edu>
Subject: Re: intermediate summary of ext3-2.4-0.9.4 thread
To: tao@acc.umu.se (David Weinehall)
Date: Fri, 3 Aug 2001 15:59:02 -0400 (EDT)
Cc: phillips@bonn-fries.net (Daniel Phillips),
        sct@redhat.com (Stephen C. Tweedie), linux-kernel@vger.kernel.org
In-Reply-To: <20010803105029.I6387@khan.acc.umu.se> from "David Weinehall" at Aug 03, 2001 10:50:30 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Weinehall writes:
> On Thu, Aug 02, 2001 at 07:37:50PM +0200, Matthias Andree wrote:

>> Still, some people object to a dirsync mount option. But this has been
>> the actual reason for the thread - MTA authors are refusing to pamper
>> Linux and use chattr +S instead which gives unnecessary (premature) sync
>> operations on write() - but MTAs know how to fsync().
>
> So what you mean is that MTA authors refuse to pamper Linux through use
> of fsync of the directory, but can accept to "pamper" Linux through use
> of chattr +S?! This seem ridiculous.  It seems equally ridiculous to
> demand that Linux should pamper for MTA authors that can't implement
> fsync on the directory instead of writing BSD-specific code.
>
> [snip]
>
> To me this seems mostly like a way of saying "Hey, we've finally found
> a way to make Linux look really bad compared to BSD-systems; let's
> complain instead of writing alternative code that suits Linux systems
> better than this code does." A lot like all the discussions on threads,
> ueally.

This is just completely true. One wonders why we seem to enjoy
getting screwed this way. We shouldn't be patching these MTAs or
hacking Linux to act like BSD. We should be avoiding these MTAs.

Somebody can create a big MTA list, listing the good and bad ones.
Then we get the Linux-hostile MTAs out of the Linux distributions,
demanding compliance like we do for filesystem layout. We also hunt
down Linux-related web pages that mention these MTAs and get the
pages changed or removed. The point is to make these MTAs just
disappear, never to be seen again. Nice MTAs get promoted.


