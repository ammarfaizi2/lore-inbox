Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270523AbRHWV05>; Thu, 23 Aug 2001 17:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270506AbRHWV0i>; Thu, 23 Aug 2001 17:26:38 -0400
Received: from mk-smarthost-2.mail.uk.worldonline.com ([212.74.112.72]:45838
	"EHLO mk-smarthost-2.mail.uk.worldonline.com") by vger.kernel.org
	with ESMTP id <S270480AbRHWV0g>; Thu, 23 Aug 2001 17:26:36 -0400
Subject: suggestions for new kernel hacking-HOWTO
From: Andrew Ebling <kernelhacker@lineone.net>
To: kernelnewbies@nl.linux.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12.99+cvs.2001.08.18.08.00 (Preview Release)
Date: 23 Aug 2001 22:29:27 +0100
Message-Id: <998602169.405.21.camel@elixr.jfreak>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I am considering putting together a new, more in depth kernel hacking
HOWTO.  

The existing HOWTO (by Rusty), although an excellent source of technical
information does not contain much practical advice on how to get
started.

Therefore I would like to propose the following structure (for your
comments):

- Intro
        - Who is this document for etc.
        - Prerequisites

- Key Kernel Concepts
	(placing these in a good order is important)
        - virtual memory/memory management
        - virtual file system/IO management
        - process/scheduling
        - contexts/interrupts/exceptions
        - system calls/signals/IPC
        - boot sequence

- Kernel source tour
        What goes where in the source tree

- Tools
        - source code navigation (lxr, cscope, tags)
        - source code manipulation (vim, diff, patch, RCS/CVS)

- How do I... ?
        - Print messages to kernel logs
        - create a new module
        - Add a system call
        - write ioctls
        - Add a /proc entry
        - Write a driver for a new device
        - Add an option to the kernel configuation

- Kernel Debugging
        - A word on debugging
        - Different approaches
                - local running kernel
                - UML
        - two box debugging (I have already write a sort of mini HOWTO
on this, which can be found at
http://www.kernelhacking.org/docs/2boxdebugging.txt)
        	- Setting up
                	- hardware
                	- software
        	- Preparing the source
        	- Example debugging session
        	- Troublshooting

- Kernel Profiling
	How to find bottlenecks

- Hacking Tips
        - Avoiding deadlock
	<add to this list!>

- Books

- FAQ

- Links

- where to get help
        - mailing lists
        - irc

- references

I'm interested in hearing from seasoned kernel hackers (on what
should/shouldn't go in this HOWTO) and newbies (what is particularly
puzzling or not clear when setting out), hence the cross posting of this
message.

I do not have all the know how/experience required to write this
document single handed, so I am also looking for willing volunteers to
contribute their expertise/know how/tips and to proof read/make
suggestions as the document progresses.

My website (http://www.kernelhacking.org) will serve as a base for this
project.

best regards,

Andy

PS.  Please post general discussion back to the list(s) as appropriate
and post specific ideas/requests to my personal address only.  Thanks :)

