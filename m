Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312331AbSDDX7w>; Thu, 4 Apr 2002 18:59:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312317AbSDDX7m>; Thu, 4 Apr 2002 18:59:42 -0500
Received: from mail3.aracnet.com ([216.99.193.38]:12486 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S312314AbSDDX7a>; Thu, 4 Apr 2002 18:59:30 -0500
Date: Thu, 4 Apr 2002 15:59:47 -0800 (PST)
From: "M. Edward (Ed) Borasky" <znmeb@aracnet.com>
To: "David N. Welton" <davidw@dedasys.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: forth interpreter as kernel module
In-Reply-To: <877knnowi8.fsf@dedasys.com>
Message-ID: <Pine.LNX.4.33.0204041549480.2309-100000@shell1.aracnet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5 Apr 2002, David N. Welton wrote:

>
> [ please CC replies to me ]
>
> Once upon a time, I had a rather random idea, and, acting on it, I
> wedged a forth interpreter into the Linux kernel.  I've always wanted
> to clean it up and do things nicely, but have never really found the
> time or the motivation.

We had another similar post a few weeks ago. *Two* Linux kernel Forth
interpreters in one year -- what are the odds? :)

Seriously, though, a Forth that could be accessed inside the kernel has
profound (in)security implications. I'm not sure I like the thought of
something as powerful as Forth available with kernel privileges. It
would make an interesting debugging / diagnostic tool if "kgdb", etc.
didn't exist, but given that there *are* some debug tools already, I'm
not sure what I'd do with it.

Now a *user-space* full-featured Forth -- something like Tom Zimmer's
Windows32 Forth or Forth, Inc.'s SwiftForth -- with GUIs and all the
other goodies -- now *that* I'd love to have. But a tiny Forth in the
kernel? Nope.
-- 
M. Edward Borasky
znmeb@borasky-research.net

The COUGAR Project
http://www.borasky-research.com/Cougar.htm

Q. How do you tell when a pineapple is ready to eat?
A. It picks up its knife and fork.

