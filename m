Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288914AbSASJTG>; Sat, 19 Jan 2002 04:19:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288917AbSASJSz>; Sat, 19 Jan 2002 04:18:55 -0500
Received: from fc.capaccess.org ([151.200.199.53]:23818 "EHLO fc.Capaccess.org")
	by vger.kernel.org with ESMTP id <S288914AbSASJSl>;
	Sat, 19 Jan 2002 04:18:41 -0500
Message-id: <fc.008584120029b07d008584120029b07d.29b08f@Capaccess.org>
Date: Sat, 19 Jan 2002 04:17:37 -0500
Subject: Re: [STATUS 2.5] January 18, 2002
To: linux-kernel@vger.kernel.org
From: "Rick A. Hohensee" <rickh@Capaccess.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al The Virile quoted and wroted...

>Libenzi)
>> o Merged Rewrite of the block IO (bio) layer (Jens Axboe)
>> o Merged New kernel device structure (kdev_t) (Linus Torvalds, etc)
>> o Merged Initial support for USB 2.0 (David Brownell, Greg
>>Kroah-Hartman,>
>
>Merged: Per-process namespaces, late-boot cleanups.

Bold. I've been wondering when/if that would go in. Namespaces is the kind
of thing Bell Labs started over from scratch for. Linus merged that? If so
Al is to be congratulated, even if 2.5 never slithers off the labORatory
slab. Don't tell Al I said so***. I applaud namespaces as something very
personable, unlike the "IBM PC", and unlike most concerns of this mailing
list. Namespaces are the kind of thing an open source OS should be doing.
Cheers. Confetti. Good booze.

Here's a little something to keep in mind if namespaces explode on you.
Thier primary claimed benefits are to a user of a distributed operating
system. Note the absence of the term "process" in the previous sentence.
Namespaces (in the Plan 9 sense) are conceptually per user. When you need
to find simplifications, that's where to look.

For example, if I write a kernel, and it ever gets sequestered users, each
user that doesn't live in kernelspace, each "guest", will be one single
process. AmigaDos is one single process in the unix sense, so that's not
as confining as most of you will immediately imagine. That's one AmigaDos
per user. Another way to look at that is as if X and /bin are all shell
built-ins and /usr/bin is scripts. Very performant scripts. Or shell
modules. The guy that wrote the language that C should have remained,
BCPL*, Martin Richards**, is still tweaking the progenitor of AmigaDos,
Tripos, but now it's Cintpos on Linux.

In other words, in a unix context, if namespaces start to eat your head,
consider that they can be quite useful without spanning or surviving a
fork/execve, i.e. they can be useful as per-process-that-can't-fork.
Eunuch process? Note also that emasculating Al's processes would in no
wise compromise his manifest cyberstudmuffinhood.



* BCPL for example might have less problems with dev_t. Cells. See also:
ANSI Forth. 16 or 32 bit, sourcecode-transparently. BCPL is now MCPL
though, with some ML-isms and C-isms. Don't forget to enable shared memory
when looking at Cintpos, to be found at...

** http://www.cl.cam.ac.uk/~mr/

*** if anyone does want to dare to violate the sanctity of Al's
much-ballyhoo'ed killfile, please do .tel him I .sai .tha if he .keep
staring at .thos execve lines in main.c he's going to .star .seein dots.



Rick Hohensee    rickh@capaccess.org    http://linux01.gwdg.de/~rhohen

:; cLIeNUX /dev/tty6  03:47:33   /
:;d -d */
Ha3sm/       command/     floppy/      mounts/      subroutine/
Linux/       configure/   guest/       owner/       suite/
bmgsubs/     dev/         help/        sb/          temp/
boot/        device/      log/         source/
:; cLIeNUX /dev/tty5  03:30:03   /
:;


