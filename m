Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265591AbSJSMm1>; Sat, 19 Oct 2002 08:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265593AbSJSMm1>; Sat, 19 Oct 2002 08:42:27 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:45767 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S265591AbSJSMm0>; Sat, 19 Oct 2002 08:42:26 -0400
Date: Sat, 19 Oct 2002 14:48:25 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Bug tracking in the run up from 2.5 to 2.6
In-Reply-To: <205680000.1034895125@flay>
Message-ID: <Pine.NEB.4.44.0210191415390.28761-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Oct 2002, Martin J. Bligh wrote:

>...
> We really need to get some feedback before commiting resources to doing
> this - if you'd be willing to close out bugs as you find / fix them, please let
> me know. This is a web interface system, with handy email triggers, and is
> very easy to use.
>
> Feedback saying "well, it'll only be useful if you do XYZ" is welcome too.
> We're very unlikely to change tools to use something other than Bugzilla
> at this point, so that's not really open for debate.


First of all thanks for this, it sounds like a pretty good idea. :-)


Some comments/questions:


1. Related projects

1a Some time ago Dave Jones did something similar [1] and currently
   Thomas Molina maintains a bug tracking page [2]. These were/are both
   projects where one person did/does collect bug reports from
   linux-kernel by hand but roughly spoken it's the same thing you want to
   start (modulo the additional manpower you can provide). You should
   at least ask them for their experiences and use Thomas' collection
   as input for your bug tracking system.

1b The Trivial Patch Monkey [3] by Rusty Russell is not very related
   but it would be good if there was enough communication that it's noted
   in the bug tracking system whenever a bug is already fixed by a patch
   submitted to the Trivial Patch Monkey.


2. What is the suggested workflow?

   Let's say I want to report a "xyz doesn't compile in 2.5.44" bug.

   Currently I'm sending it to the people that seem to be responsible
   (looking at MAINTAINERS and the contents of the file that doesn't
   compile) with a Cc to linux-kernel.

   With a Web-based bug tracking system like Bugzilla it's additional work
   to add a bug to the bug tracking system, too, and to keep the
   information that is there updated (e.g. if the maintainer sends a patch
   a few hours later).

   What is the suggested workflow to avoid additional work?


> Martin.

cu
Adrian

[1] http://www.codemonkey.org.uk/Linux-2.5.html
[2] http://members.cox.net/tmolina/kernprobs/status.html
[3] http://www.kernel.org/pub/linux/kernel/people/rusty/trivial/

-- 

"Is there not promise of rain?" Ling Tan asked suddenly out
of the darkness. There had been need of rain for many days.
"Only a promise," Lao Er said.
                                Pearl S. Buck - Dragon Seed





