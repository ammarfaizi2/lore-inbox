Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277203AbRJQU40>; Wed, 17 Oct 2001 16:56:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277199AbRJQU4Q>; Wed, 17 Oct 2001 16:56:16 -0400
Received: from doorbell.lineo.com ([204.246.147.253]:25060 "EHLO
	thor.lineo.com") by vger.kernel.org with ESMTP id <S277192AbRJQU4D>;
	Wed, 17 Oct 2001 16:56:03 -0400
Message-ID: <3BCDFFE8.3DDB2591@lineo.com>
Date: Wed, 17 Oct 2001 15:02:16 -0700
From: pierre@lineo.com
X-Accept-Language: en
MIME-Version: 1.0
To: arjanv@redhat.com
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: GPLONLY kernel symbols???
In-Reply-To: <Pine.LNX.4.10.10110171126480.5821-100000@innerfire.net> <3BCDE77F.D1B164A@lineo.com> <200110171934.f9HJY8w01260@adsl-209-76-109-63.dsl.snfc21.pacbell.net> <3BCDF89C.32916516@lineo.com> <3BCDEAD9.DEC2415F@redhat.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> 
> It's not legal issues.

Of course it is, this is code that deals with
whether or not the kernel has loaded something
that's not covered under the GPL license.

> It's 1 integer and 1 sysctl variable that allow
> easy filtering of nvidia and other bugreports.
> THAT is the purpose of "tainted". Show in the oops
> that binary only modules are used.

Then that's the wrong purpose : instead, oops
posters should be made aware that they should
post the list of loaded modules as well. If you
really insist on having the kernel deal with this,
make the kernel print the list of modules as well
as the oops.

(this assumes all gpl modules to have a
MODULE_LICENSE() line which doesn't result in code
and isn't loaded into kernel memory;

Yes it is : what about the code that allows me
to cat /proc/sys/kernel/tainted and echo an integer
into it ? and the code that's not loaded into kernel
memory sure takes storage space, even if it's not
much.

But that's not the point : the point is, the kernel
should contain as much non-kernel junk as possible.
Kernel code, even a small amount of it, that deals
with licensing is junk code. It's silly enough to
have "sponsored by" strings in the kernel as it is.

                ////\
                (@ @)
------------oOOo-(_)-oOOo-------------
Pierre-Philippe Coupard
Senior Software Engineer, Lineo, Inc.
(801) 426-5001 x 208
--------------------------------------

There are many intelligent species in the universe, and they all own
cats.
