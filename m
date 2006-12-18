Return-Path: <linux-kernel-owner+w=401wt.eu-S1754307AbWLRRRR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754307AbWLRRRR (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 12:17:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754308AbWLRRRR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 12:17:17 -0500
Received: from mail1.webmaster.com ([216.152.64.169]:1463 "EHLO
	mail1.webmaster.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754307AbWLRRRQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 12:17:16 -0500
From: "David Schwartz" <davids@webmaster.com>
To: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: RE: GPL only modules
Date: Mon, 18 Dec 2006 09:16:31 -0800
Message-ID: <MDEHLPKNGKAHNMBLJOLKKECHAHAC.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <200612171646.40655.dhazelton@enter.net>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3028
Importance: Normal
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Mon, 18 Dec 2006 10:19:05 -0800
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Mon, 18 Dec 2006 10:19:05 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Combined responses to save bandwidth and reduce the number of times people
have to press "d".

> Agreed. You missed the point.

I don't understand how you could lead with "agreed" and then proceed to
completely ignore the entire point I just made.

> Since the Linux Kernel header files
> contain a
> chunk of the source code for the kernel in the form of the macros
> for locking
> et. al. then using the headers - including that code in your
> module - makes
> it a derivative work.

No, it does not. The header files are purely function and not expressive in
this case. Copyright only protects one choice among many equally-practical
choices for expressing the same idea or performing the same function.

> Actually, thinking about it, the way a Linux driver module works actually
> seems to make *ANY* driver a derivative work, because they are
> loaded into
> the kernels memory space and cannot function without having that done.

If every practical way of expressing an idea contains something, then that
something is *not* protectable when used to express an idea of that kind.

> *IF* the "Usermode Driver" interface that is being worked on ever proves
> useful then, and only then, could you consider it *NOT* a
> derivative work.
> Because then the only thing it is using *IS* an interface, not complete
> chunks of the source as generated when the pre-processor finishes running
> through the file.

No, you have it completely backwards.

If a usermode driver interface was equally practical to develop a particular
type of driver, then using the kernel headers would make the driver a
derivative work. Because, in that case, the choice to use the kernel headers
would be a creative choice -- one chosen method among many equally practical
one.

Copyright only protects creative choices, not purely functional ones.

"A Linux 2.6 driver for the ATI X800 graphics chipset" is an idea. If the
only reasonably practical way to express that idea is with the Linux kernel
header files, then using the Linux kernel header files is scenes a fair, not
protected content.

For example, you cannot discuss the Napeleonic wars with using the word
"Napoleon", at least, not nearly as well. So nobody can claim copyright on
the word "Napoleon" when used to describe those wars because it is
deomnstrably *superior*. Only patents protect "best ways". Copyrights
protected "the way I choose among thousands of equally-good ways".

See Lexmark v. Static Controls and the Sega and Atari cases. This is clearly
a cases where "[w]hile, hypothetically, there might be a myriad of ways in
which a programmer may effectuate certain functions within a program . . .
efficiency concerns may so narrow the practical range of choice as to make
only one or two forms of expression workable options." "In order to
characterize a choice between alleged programming alternatives as
expressive, in short, the alternatives must be feasible within real-world
constraints."

The inclusion of the kernel header files in a kernel module is not
expressive, it's purely functional. The kernel header files are simply not
protectable expression when used in a kernel module.

-

>The difference - really - at least for static linking - is that "ln"
>makes modifications to each piece to make them work together, and in
>the case of a library, makes a selection of the parts of the library
>as needed by the rest of the program.  What ends up in the executable
>is not just a set of verbatim copies of the input files packed
>together, but rather a single program where the various parts have
>been modified so as to fit together and create a whole.  Thus it seems
>quite reasonable to me to say that a statically linked binary is a
>derived work of all of the object files and libraries that were linked
>together to form it.  IANAL, of course.

The linker makes no creative choices, so it does not produce a "work" for
copyright purposes. If it does not even produce a work, it cannot produce a
derivative work.

The question is not whether the combination is verbatim or transformative
but whether it is creative or mechanical. The linker combines things in a
mechanical and purely functional way.

A tar/gzip does the same thing. The compressed output for the third file may
be as dependent on the content of the second file as on the content of the
third file and in a very real sense will contain aspects of both of their
structures.

"Mere aggregation" does not mean a literal splicing of the raw code for two
or more files. It means a purely functional combination dictated completely
by technical concerns and lacking any creative input.

DS


