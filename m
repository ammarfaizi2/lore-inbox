Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267721AbUJOMMY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267721AbUJOMMY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 08:12:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267734AbUJOMMY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 08:12:24 -0400
Received: from chaos.analogic.com ([204.178.40.224]:19584 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S267721AbUJOMMP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 08:12:15 -0400
Date: Fri, 15 Oct 2004 08:10:35 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Roman Zippel <zippel@linux-m68k.org>
cc: David Howells <dhowells@redhat.com>,
       "Rusty Russell (IBM)" <rusty@au1.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>, Greg KH <greg@kroah.com>,
       Arjan van de Ven <arjanv@redhat.com>, Joy Latten <latten@us.ibm.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fw: signed kernel modules? 
In-Reply-To: <Pine.LNX.4.61.0410151253360.7182@scrub.home>
Message-ID: <Pine.LNX.4.61.0410150723180.8573@chaos.analogic.com>
References: <27277.1097702318@redhat.com>  <1097626296.4013.34.camel@localhost.localdomain>
 <1096411448.3230.22.camel@localhost.localdomain> <1092403984.29463.11.camel@bach>
 <1092369784.25194.225.camel@bach> <20040812092029.GA30255@devserv.devel.redhat.com>
 <20040811211719.GD21894@kroah.com> <OF4B7132F5.8BE9D947-ON87256EEB.007192D0-86256EEB.00740B23@us.ibm.com>
 <1092097278.20335.51.camel@bach> <20040810002741.GA7764@kroah.com>
 <1092189167.22236.67.camel@bach> <19388.1092301990@redhat.com>
 <30797.1092308768@redhat.com> <20040812111853.GB25950@devserv.devel.redhat.com>
 <20040812200917.GD2952@kroah.com> <26280.1092388799@redhat.com>
 <27175.1095936746@redhat.com> <30591.1096451074@redhat.com>
 <10345.1097507482@redhat.com> <1097507755.318.332.camel@hades.cambridge.redhat.com>
 <1097534090.16153.7.camel@localhost.localdomain>
 <1097570159.5788.1089.camel@baythorne.infradead.org>  <23446.1097777340@redhat.com>
 <Pine.LNX.4.61.0410151253360.7182@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Oct 2004, Roman Zippel wrote:

> Hi,
>
> On Thu, 14 Oct 2004, David Howells wrote:
>
>> I've uploaded an updated module signing patch with Rusty's suggested
>> additions:
>
> Can someone please put this patch into some context, where it's not
> completely pointless? As is it does not make anything more secure.
> Why is the kernel more trustable than a kernel module?
> If someone could show me how I can trust the running kernel, it should be
> rather easy to extend the same measures to modules without the need for
> this patch.
>
> bye, Roman
> -

This is just the first step, which I think must be quashed
immediately. The ultimate goal is to control what you put
into your computer. Eventually, some central licensing
authority will certify any modules that are allowed to
be run in your computer. Doesn't anybody else see this?

Freedom isn't lost in one big step when the storm-troopers
show up at your door. It is lost in little pieces, each
so small that they tend to be ignored.

We need to stop this nonsense now. Certainly persons who
lived, or still live, under highly regulated governmental
control, know that we must prevent some select group of
self-appointed authorities from controlling what we put
into our computers. In particular, when the five to
ten-thousand who contributed to the kernel, thought that
they were performing a service for the common good, not
to be taken from them and hidden behind some license.

I developed one of the first SCSI controllers for Linux,
back when Linus was in Helsinki. I did this because I
bought a new SCSI disk and controller. It worked under
DOS, but not Linux. Nobody, in those days, thought
anything about modules and licenses, etc. We just wanted
to make Linux better. Then, when I was working on some
other drivers, I needed to be able to change code without
having to re-boot. I made the first primitive 'module' to
do this. The old driver was not actually removed nor
even overwritten. I just made a program to perform
fix-ups in user-mode, and a built-in driver to allocate
memory, load the fixed-up code, and change pointers
to point to new code. This allowed me to write drivers
and install them without having to re-boot. Eventually,
the system would run out of memory and I'd have to
reboot, but in the meantime, I could continue
development. This was all the precursor of the more
modern 'modules' by Laarhoven and Tombs.

Now, I've watched through the years where every bit
of code that the original contributors wrote, was
overwritten. It was not necessarily better, only
different. Even the names of contributors have been
removed. The name-removers still haven't removed the
last vestige of my contributions although they probably
will now, but I'll make it difficult to find them...

Script started on Fri 15 Oct 2004 07:51:34 AM EDT
# for x in `find . -name "*.c"` ; do grep rjohnson@ $x ; done
     rjohnson@analogic.com : Changed init order so an interrupt will only
     rjohnson@analogic.com : Fix up PIO interface for efficient operation.
# exit
Script done on Fri 15 Oct 2004 07:52:45 AM EDT

Then, a certain Richard Stallman, tried to claim Linux as
his own as "GNU/Linux". Guess what? Most everybody fell into
that trap.

Why would anybody remove contributor names from even
`man` pages? Look at the new `man insmod`. Yes, the
original is in `insmod.old`. How long will that last?

Each of these little pieces of freedom are being chipped
away, bit-by-bit.

Wake up everybody. Get the POLICY out of the kernel.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.8 on an i686 machine (5537.79 Gimps).
             Note 96.31% of all statistics are fiction.

