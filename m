Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269541AbRHXG2S>; Fri, 24 Aug 2001 02:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269718AbRHXG2J>; Fri, 24 Aug 2001 02:28:09 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:44039 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S269541AbRHXG1t>;
	Fri, 24 Aug 2001 02:27:49 -0400
Date: Fri, 24 Aug 2001 03:27:58 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Andrew Ebling <kernelhacker@lineone.net>
Cc: kernelnewbies@nl.linux.org, linux-kernel@vger.kernel.org
Subject: Re: suggestions for new kernel hacking-HOWTO
Message-ID: <20010824032758.K1022@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Andrew Ebling <kernelhacker@lineone.net>, kernelnewbies@nl.linux.org,
	linux-kernel@vger.kernel.org
In-Reply-To: <998602169.405.21.camel@elixr.jfreak>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.17i
In-Reply-To: <998602169.405.21.camel@elixr.jfreak>; from kernelhacker@lineone.net on Thu, Aug 23, 2001 at 10:29:27PM +0100
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Aug 23, 2001 at 10:29:27PM +0100, Andrew Ebling escreveu:
> Hi all,
> 
> I am considering putting together a new, more in depth kernel hacking
> HOWTO.  
> 
> The existing HOWTO (by Rusty), although an excellent source of technical
> information does not contain much practical advice on how to get
> started.
> 
> Therefore I would like to propose the following structure (for your
> comments):
> 
> - Intro
>         - Who is this document for etc.
>         - Prerequisites
> 
> - Key Kernel Concepts
> 	(placing these in a good order is important)
>         - virtual memory/memory management
>         - virtual file system/IO management
>         - process/scheduling
>         - contexts/interrupts/exceptions
>         - system calls/signals/IPC
>         - boot sequence
> 
> - Kernel source tour
>         What goes where in the source tree
> 
> - Tools
>         - source code navigation (lxr, cscope, tags)

sourcenav (http://sources.redhat.com/sourcenav)
cflow (+ graphviz)

>         - source code manipulation (vim, diff, patch, RCS/CVS)

interdiff

> 
> - How do I... ?
>         - Print messages to kernel logs
>         - create a new module
>         - Add a system call
>         - write ioctls
>         - Add a /proc entry
>         - Write a driver for a new device
>         - Add an option to the kernel configuation
> 
> - Kernel Debugging
>         - A word on debugging
>         - Different approaches
>                 - local running kernel
>                 - UML
>         - two box debugging (I have already write a sort of mini HOWTO
> on this, which can be found at
> http://www.kernelhacking.org/docs/2boxdebugging.txt)
>         	- Setting up
>                 	- hardware
>                 	- software
>         	- Preparing the source
>         	- Example debugging session
>         	- Troublshooting

kdb
ikd
linux trace toolkit

and here one could search all the DEBUG features already in the kernel
(WAITQÜEUE_DEBUG, SLAB poisoning, etc) and send a nice patch to Alan/Linus
so that it becomes configurable at make config/menuconfig/the others

> 
> - Kernel Profiling
> 	How to find bottlenecks

linux trace toolkit, docs by Andrew Morton on low latency, etc

> 
> - Hacking Tips
>         - Avoiding deadlock
> 	<add to this list!>
> 
> - Books

already in http://www.dit.upm.es/~jmseyas/linux/kernel/hackers-docs.html
and Documentation/kernel-docs.txt

> 
> - FAQ
> 
> - Links
> 
> - where to get help
>         - mailing lists
>         - irc
> 
> - references
> 
> I'm interested in hearing from seasoned kernel hackers (on what
> should/shouldn't go in this HOWTO) and newbies (what is particularly
> puzzling or not clear when setting out), hence the cross posting of this
> message.
> 
> I do not have all the know how/experience required to write this
> document single handed, so I am also looking for willing volunteers to
> contribute their expertise/know how/tips and to proof read/make
> suggestions as the document progresses.
> 
> My website (http://www.kernelhacking.org) will serve as a base for this
> project.
> 
> best regards,
> 
> Andy
> 
> PS.  Please post general discussion back to the list(s) as appropriate
> and post specific ideas/requests to my personal address only.  Thanks :)


                        - Arnaldo
