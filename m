Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289545AbSAVX2Z>; Tue, 22 Jan 2002 18:28:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289551AbSAVX2O>; Tue, 22 Jan 2002 18:28:14 -0500
Received: from cmailg4.svr.pol.co.uk ([195.92.195.174]:47409 "EHLO
	cmailg4.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S289545AbSAVX2E>; Tue, 22 Jan 2002 18:28:04 -0500
Posted-Date: Tue, 22 Jan 2002 23:27:57 GMT
Date: Tue, 22 Jan 2002 23:27:57 +0000 (GMT)
From: Riley Williams <rhw@MemAlpha.cx>
Reply-To: Riley Williams <rhw@MemAlpha.cx>
To: Michael Scott <scott1@quik.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux Kernel version numbers
In-Reply-To: <000801c1a3aa$72994660$d618b0d8@computer>
Message-ID: <Pine.LNX.4.21.0201222318180.6998-100000@Consulate.UFP.CX>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael.

L-K: This is my definition, but if any of you would care to improve on
it, both Michael and I would appreciate hearing your comments. Michael
isn't on the list as far as I know, so please CC your replies to him/her.

> In the kernel versions, what do the numbers mean specificially?

The important part is this: For a production system, the first number
should be 2, the second number should be an even number, the third
number should be reasonably high and the fourth number should be
missing. Given that, the system should be reasonably stable.

> Example- 2.4.10. I was informed 2 is major, 4 is minor, 10 is patch
> and 5 is Pre. But I'm still lost what is major, minor, patch and
> pre??????

There's no official definition, but here's a reasonable one that I tend
to use on my programming projects:

MAJOR = Something extremely important changed, and the result is
	not backwards compatible with earlier versions.

MINOR = Something important changed, but the result is still
	backwards compatible with previous versions. Also, if
	this is an even number, the result is reasonably stable,
	but if this is an odd number, new features are probably
	under development and the result may not be usable.

PATCH = Something minor changed, and the result is usable.

PRE   = Something minor changed, and the result needs testing
	as it could easily be unstable if this is present.

It's not an exact fit to the Linux kernel development, but it isn't to
bad a fit to what Linus Torvalds decides to do.

> Thank you for your time

NP.

Best wishes from Riley.

