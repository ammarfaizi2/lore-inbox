Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263212AbTDYPbI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 11:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263330AbTDYPbI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 11:31:08 -0400
Received: from chaos.analogic.com ([204.178.40.224]:63626 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263212AbTDYPbG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 11:31:06 -0400
Date: Fri, 25 Apr 2003 11:45:18 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Matthew Sell <msell@ontimesupport.com>
cc: Stewart Smith <stewartsmith@mac.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: versioned filesystems in linux (was Re: kernel support for
 non-english user messages)
In-Reply-To: <3EA95242.9060303@ontimesupport.com>
Message-ID: <Pine.LNX.4.53.0304251131490.6515@chaos>
References: <03FA0FB7-76AC-11D7-BE62-00039346F142@mac.com>
 <3EA95242.9060303@ontimesupport.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Apr 2003, Matthew Sell wrote:

> Stewart Smith wrote:
>
> > On Friday, April 11, 2003, at 06:36  AM, John Bradford wrote:
> >
> >> When are we going to see versioned filesystems in Linux?  That was a
> >> standard feature in VMS.
> >
> >
> > This is (part of) what I'm doing for my honors project this year - so
> > possibly something (might) be around and (almost) working by the end
> > of the year. The real big trick is remote efficiency - but what's the
> > fun of research if there isn't something tricky?
> >
> > If people are actually really interested in it, I might make it a bit
> > more of a focus :)
> >
> > More info avail on request :)
>
>
> It would be nice to see what assistance the FreeVMS group may be able to
> offer. It appears that they are attempting to make an operating system
> compatible with VMS based on the Linux kernel.
>
>  From what I have observed, a few of them seem to have extensive
> experience with VMS and may be able to offer at least some baseline
> knowledge as to how VMS accomplishes this.
>
> My curiosity lies with the ability to run FreeVMS on VAX....
>
> (Why not? It's just a hobby....)
>
>
>     - Matt
>

Good grief!  Versioning is just a file-naming convention!

MISSING;0
MISSING;1
MISSING;3
MISSING;4
Makefile;0
Makefile;1
Makefile;3
bufio.c;9
bufio.c;10
bufio.c;11
bufio.o;0
checker;0
checker.c;0
checker.c;1
checker.c;2
checker.o;0

You just modify your user-mode tools and your 'C' runtime library
to make whatever atrocious versioning mechanism you want. You can
even make all filenames upper case, just like VAX/VMS, and you can
even make your shell DCL if you want. It's where the rules are
enforced like (mapping everything to upper-case).

I can see it now, upon startup `init` execs:

   SYS$SYSTEM:LOGINOUT.EXE -
   INPUT=SYS$SYSTEM:[etc]inittab -
   OUTPUT=SYS$SYSTEM:[var.log]startup.log -
   ERROR=SYS$SYSTEM:[dev]console -
   UIC=[0,0] -
   PRIV=(NOALL, TMPMBX, NETMBX, SETPRV)


Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

