Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292324AbSBPJBq>; Sat, 16 Feb 2002 04:01:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292325AbSBPJBh>; Sat, 16 Feb 2002 04:01:37 -0500
Received: from duba05h05-0.dplanet.ch ([212.35.36.52]:29456 "EHLO
	duba05h05-0.dplanet.ch") by vger.kernel.org with ESMTP
	id <S292324AbSBPJB0>; Sat, 16 Feb 2002 04:01:26 -0500
Message-ID: <3C6E1F90.40404@dplanet.ch>
Date: Sat, 16 Feb 2002 10:00:00 +0100
From: "Giacomo A. Catenazzi" <cate@dplanet.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:0.9.5) Gecko/20011023
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: kbuild [which is not only CML2]
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I have some comment/explications about the thread
about kbuild.


1-
The discussion was also on lkml, ESR asked to kbuild
people to give some comments, using also the feed-back
of lkml.
As you noticed, in lkml the discussion went into flames,
fogetting the important points.
[As this flame is going forgetting kbuild-2.5..]]

2-
The comments in kbuild list are accessible to all.
You should read them (hmm, really there are only one full
comment [my comment] + discution/flame]

3-
The importants points are:
CML2 and kbuild-2.5 are two different projects, which
don't depend each other.
The need of the two project is also demostrated by the
other never finished similar project (mconfig, kernconfig,
mcml2, cml2config, dancing-makefiles, ...)

4-
Nobody talked about kbuild-2.5. It really correct actual
makefiles. And I hope that Linus correct this bahaviour in
a time manner (and not as last big makefile correction in
2.4.0-testX).

5-
What wrong with kbuild-2.5?
Keith seems to comunicate better with other kernel developers,
[The main point of kbuild-2.5 are:
  no more required make mrproper -> faster,
  no more 'touch include/*/*.h',
  multiple trees, read-oly sources,...]

6-
Old configuration programs, IMHO, are not so broken, but there
is a big problem of maintainability. Every 10 patches, few are
incorrect.
Few developers (maybe no developers) will use xconfig, and
also few developers have read the Documentation/kbuild/.
This inevitably port people to write Config.in as bash
shell (WRONG!), forgetting that unset configuration have
variable unset OR set to 'n'.

These problems seems not so huge, but with actual kernel
development there are. It is difficult to push corection patch
into the main kernel. Who will help kbuild people?
[CML2 will solve the problem at the source: same engine for
all interface, with more checks, so original sender will have
the correct config.in].

7-
Andrea'WAlan did you make some tools for CML1 and did you not
publish? Why? (not published == not existance from the other
people).

8-
Read who wrote menuconfig, and you see why ESR want to
replace it.

9-
Read some user list about configuration problem and you see
that CML1 cause user much problem that a kernel hacker see.
(menuconfig didn't compile, where is such symbols?)


No flame please.
Tell us what is wrong in kbuild-2-5 and in CML2. Don't flame!
If you flame about CML2, ESR will answer you and then he
forget the initial proposal of improvement.


         giacomo, who don't understan why kbuild-2.5 is not in kernel

