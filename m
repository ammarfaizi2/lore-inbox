Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262046AbUCNXSa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 18:18:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262053AbUCNXS3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 18:18:29 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:63897 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262046AbUCNXSC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 18:18:02 -0500
Message-ID: <4054E77E.3090206@us.ibm.com>
Date: Sun, 14 Mar 2004 15:15:10 -0800
From: Nivedita Singhvi <niv@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: New documentation file - SuccessfulProjects.txt
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This draft is a start on a Documentation file for new Linux
projects in the family of SubmittingPatches and CodingStyle.

It attempts to capture advice kernel maintainers repeatedly give
to large Linux project developers, especially those new to Linux.
With an increasing amount of software development taking place
in the Linux environment, it is hoped this contributes in some
small way to help people avoid the mistakes of those who have gone
before them in getting their code accepted into the Linux kernel.
Inspired by Andrew Morton's post on lkml just a while back on this
subject.

If including this file in the Documentation directory is agreed to,
I'll be glad to incorporate feedback and resubmit.

Any thoughts?

thanks,
Nivedita


--------------------
File:	SuccessfulProjects.txt
Date:	3/14/04
Title:	How To Run A Successful Linux Project

" How to improve your chances of launching and sustaining a successful Linux
    project, get your code or technology accepted into the Linux kernel and
    adopted by the community, earn fame (or employment, or at least continued
    employment, or well, at least not completely waste your spare time), all
    without losing your hair and your sanity. "

Goal
====
- Increase the success rate of Linux development projects
- Reduce the burden on the kernel maintainers and the community
- Decrease the angst and conflict experienced by project developers
- Make software development faster and more efficient
- Make users, consumers of those software projects happier


Introduction
============
Most of the information here is very basic, obvious and covered frequently in a
multitude of places, at length.  However, it is also difficult to locate in one
convenient place, and ignored frequently enough to provoke the presence of this
file in the kernel Documentation subdirectory.


Tips
====

1]. Become familiar with Linux kernel development!
--------------------------------------------------
1.1 Who are the maintainers affected?
      Learn who the maintainers are for the subsystems affected by your project,
      and for the various releases, especially for the releases you intend to
      provide code to.
      2.4 -> Marcelo Tosatti
      2.6 -> Andrew Morton
      development -> Linus
      Maintainers file -> current list of maintainers

1.2 Which are the mailing lists you need?
      Learn which mailing lists cover development in the areas affected by your
      project.  It is always a good idea to involve the kernel community or
      sub-community as the case may be - which involves posting to the right
      mailing lists.  Solicit advice on which lists are appropriate.
      You can start by checking the MARC archives to find the right lists.
      http://marc.theaimsgroup.com/

1.3 Learn Linux Kernel Mailing List (lkml) etiquette
      Read the Linux Kernel Mailing List FAQ.
      http://www.tux.org/lkml/

1.4 Which Linux source tree?
      Learn what a stable release and what a development release is.
          Read the Linux FAQ.
          http://en.tldp.org/FAQ/Linux-FAQ/index.html
          This is, admittedly, already slightly out of date.

      Also discover the various other source trees (-mm, -osdl, ...)
          Read the Linux Kernel Newbies FAQ.
          http://kernelnewbies.org/faq/

      Get advice from the community and your users on which kernel tree would be
      best to target for inclusion. Understand that kernel development occurs in
      parallel in various source trees, and you might need to provide support in
      multiple versions.


2]. Join or Create a Community
------------------------------
2.1 Join an existing community
      If there already exists a project developing functionality foo that you
      are interested in, work with it.  Join the people who have already spent
      time and effort solving the problem.  Sometimes, this is easier said
      than done because projects might be open source in name, but far from it in
      reality.  A good open source project, however, will have a public web site,
      a public mailing list that invites discussion and source code available to
      play with.

      If you cannot convince this community of the value of your ideas, the going
      will only get tougher when taken to the linux kernel community. Not always
      true, but true often enough.

      This is particularly true when APIs have to be designed and there are no
      mandated standards controlling what you should be implementing.  Having
      multiple conflicting implementations brought to the linux kernel mailing
      list puts the burden of sorting out basic issues related to your project
      on kernel maintainers, hardly a group with spare time on their hands.

2.2 Create an open source community if there is none
      If there is no existing project that meets your needs, create one.

      Maintain the public infrastructure that should ideally accompany a large
      project - a public website, mailing list, source code development
      infrastructure (SourceForge is a good place to start).  Described well
      in the links below.

      Read the Software Release Practices Howto.
      http://en.tldp.org/HOWTO/Software-Release-Practice-HOWTO/index.html

      Read the following documents in the Documentation subdirectory:
      CodingStyle
      SubmittingPatches
      SubmittingDrivers

      Do not take any of the above as gospel, confirm with the maintainers in
      question. There are exceptions to every rule.


3. Interact early, interact often
---------------------------------
3.1 Don't work in isolation
      It is not a good idea to spend several person-years working behind closed
      doors, or even within your own project environment.  Keep not only the
      project community involved, but also the maintainers concerned and the
      linux kernel community, if appropriate, in the loop.

      In Andrew Morton's words:

      "But beware of being *too* disconnected from the lists@vger.kernel.org.
      We don't want to get in the situation where you pop up with a couple
      of person-years' worth of work and other kernel developers have major
      issues with it.  Please find a balance - some way of regularly
      checkpointing."

      http://marc.theaimsgroup.com/?l=linux-kernel&m=107922697510704&w=2

      Even if you are in design on planning stages, it is worth a note to
      the community to say, "Hey, this is how we're going to go about it..."

      i.e. remain visible, and ensure that people know your project is alive
      and in good hands.

3.2 Avoid large code dumps
      Don't throw a massive, complex tarball of your final masterpiece at the
      kernel community and maintainers once you are done.  Break down your project
      into smaller pieces.  Submit easily digestible chunks at regular intervals.
      If you're making some ghastly, widespread mistake, catch it early.  Get
      agreement from the community and the maintainers on your approach. Again,
      to quote Andrew from the link above:

      "That way everyone else can see the code evolving, and can help, and
      can understand.  And other people will fix your bugs for you, and
      update your code as kernel-wide changes are implemented.  And we all
      avoid nasty surprises and extensive rework."

3.3 Be responsive to input from the community
      Good open source project maintainers earn the trust of the larger
      community and kernel maintainers by demonstrating they are willing to work
      in tandem with the community.

      See Greg Kroah-Hartman's slides on dealing with the community.
      http://www.kroah.com/linux/talks/cgl_talk_2002_10_16/


