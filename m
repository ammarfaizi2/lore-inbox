Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262380AbUCREwC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 23:52:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262384AbUCREwB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 23:52:01 -0500
Received: from fw.osdl.org ([65.172.181.6]:40639 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262380AbUCREv5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 23:51:57 -0500
Date: Wed, 17 Mar 2004 20:51:59 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nivedita Singhvi <niv@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: New documentation file - SuccessfulProjects.txt
Message-Id: <20040317205159.6bad1ca2.akpm@osdl.org>
In-Reply-To: <4054E77E.3090206@us.ibm.com>
References: <4054E77E.3090206@us.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nivedita Singhvi <niv@us.ibm.com> wrote:
>
> This draft is a start on a Documentation file for new Linux
> projects in the family of SubmittingPatches and CodingStyle.
> 
> It attempts to capture advice kernel maintainers repeatedly give
> to large Linux project developers, especially those new to Linux.
> With an increasing amount of software development taking place
> in the Linux environment, it is hoped this contributes in some
> small way to help people avoid the mistakes of those who have gone
> before them in getting their code accepted into the Linux kernel.
> Inspired by Andrew Morton's post on lkml just a while back on this
> subject.
> 
> If including this file in the Documentation directory is agreed to,
> I'll be glad to incorporate feedback and resubmit.
>
> Any thoughts?

Looks useful, thanks.  I guess I'm not really in the target audience, so
I'll probably miss things.


> --------------------
> File:	SuccessfulProjects.txt
> Date:	3/14/04
> Title:	How To Run A Successful Linux Project
> 
> " How to improve your chances of launching and sustaining a successful Linux
>     project, get your code or technology accepted into the Linux kernel and
>     adopted by the community, earn fame (or employment, or at least continued
>     employment, or well, at least not completely waste your spare time), all
>     without losing your hair and your sanity. "
> 
> Goal
> ====
> - Increase the success rate of Linux development projects
> - Reduce the burden on the kernel maintainers and the community
> - Decrease the angst and conflict experienced by project developers
> - Make software development faster and more efficient
> - Make users, consumers of those software projects happier
> 

  - Use the kernel's review processes and testing base to increase the
    quality of your software.

> 
> Introduction
> ============
> Most of the information here is very basic, obvious and covered frequently in a
> multitude of places, at length.  However, it is also difficult to locate in one
> convenient place, and ignored frequently enough to provoke the presence of this
> file in the kernel Documentation subdirectory.
> 
> 
> Tips
> ====
> 

Read Documentation/CodingStyle!  If the code doesn't look like kernel code
you've just made things much harder for yourself.


> 1]. Become familiar with Linux kernel development!
> --------------------------------------------------
> 1.1 Who are the maintainers affected?
>       Learn who the maintainers are for the subsystems affected by your project,
>       and for the various releases, especially for the releases you intend to
>       provide code to.
>       2.4 -> Marcelo Tosatti
>       2.6 -> Andrew Morton
>       development -> Linus
>       Maintainers file -> current list of maintainers

        ./MAINTAINERS

> 
> 1.2 Which are the mailing lists you need?
>       Learn which mailing lists cover development in the areas affected by your
>       project.  It is always a good idea to involve the kernel community or
>       sub-community as the case may be - which involves posting to the right
>       mailing lists.  Solicit advice on which lists are appropriate.
>       You can start by checking the MARC archives to find the right lists.
>       http://marc.theaimsgroup.com/

Well.  Hopefully simply *reading* the mailing lists will help get people up
to speed.

> 1.3 Learn Linux Kernel Mailing List (lkml) etiquette
>       Read the Linux Kernel Mailing List FAQ.
>       http://www.tux.org/lkml/
> 
> 1.4 Which Linux source tree?
>       Learn what a stable release and what a development release is.
>           Read the Linux FAQ.
>           http://en.tldp.org/FAQ/Linux-FAQ/index.html
>           This is, admittedly, already slightly out of date.

It would be a good idea to spell this out here.  People often do
development against kernels which, frankly, are not development kernels.



Apart from that, heck, why not?  Please run up a diff.



