Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277144AbRJQUZP>; Wed, 17 Oct 2001 16:25:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277146AbRJQUZF>; Wed, 17 Oct 2001 16:25:05 -0400
Received: from doorbell.lineo.com ([204.246.147.253]:62179 "EHLO
	thor.lineo.com") by vger.kernel.org with ESMTP id <S277144AbRJQUYz>;
	Wed, 17 Oct 2001 16:24:55 -0400
Message-ID: <3BCDF89C.32916516@lineo.com>
Date: Wed, 17 Oct 2001 14:31:08 -0700
From: pierre@lineo.com
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: GPLONLY kernel symbols???
In-Reply-To: <Pine.LNX.4.10.10110171126480.5821-100000@innerfire.net> <3BCDE77F.D1B164A@lineo.com> <200110171934.f9HJY8w01260@adsl-209-76-109-63.dsl.snfc21.pacbell.net>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wayne Whitney wrote:
> 
> I think the idea is that if you compile something
> inside the kernel, you have the source, so at
> least from the debugging point of view, the kernel
> has not been tainted by a binary-only module.

I can make a kernel driver that compiles statically
and also uses a non-GPL library, even in the form of
a binary .o file, and the "tainted" mechanism as it
is today will miss it entirely.

> It seems like people (collectively) have two
> different purposes in mind for
> /proc/sys/kernel/tainted: ensuring that only
> "open source" modules are used, for debugging
> purposes, and ensuring that only "GPL-compatible"
> modules are used, for possible legal purposes.
> If both of these are desirable, perhaps the two
> purposes should be separated into two /proc files?

The real question is whether or not the kernel
code should be encumbered with legal issues. The
fact that this or that piece of code is or isn't GPL
should be in a text file attached to the kernel 
tarball. This sort of thing has no place in the 
code : countless patches with useful code that
should live in userland have been (rightfully)
rejected as having no place inside the kernel, why
should code that deals with legal issues and is
pretty much dead weight from a technical standpoint
be allowed in ?

                ////\
                (@ @)
------------oOOo-(_)-oOOo-------------
Pierre-Philippe Coupard
Senior Software Engineer, Lineo, Inc.
(801) 426-5001 x 208
--------------------------------------
