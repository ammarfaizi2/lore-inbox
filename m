Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266425AbUAIHQu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 02:16:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266426AbUAIHQu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 02:16:50 -0500
Received: from fw.osdl.org ([65.172.181.6]:48621 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266425AbUAIHQs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 02:16:48 -0500
Date: Thu, 8 Jan 2004 22:49:01 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux-2.6.1
Message-ID: <Pine.LNX.4.58.0401082242010.27013@evo.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, the diffs from -rc3 are minimal, most noticeably the (very _very_ hard
to trigger, but nasty if you ever did) fork() race that Ingo found.

I'm going to be in Australia (and on airplanes) for the week, but we're
all in the capable hands of Andrew, so why worry? The fact that I'm
fleeing the country should in no way be construed as anything sinister at
all, no siree. Nope. I'm innocent, and nobody saw me do it. 

The full changelog is getting uploaded right now along with the release, 
and the BK trees have already been pushed. 

Up up and away,

		Linus

============================================
Summary of changes from v2.6.1-rc3 to v2.6.1
============================================

Dave Jones:
  o [AGPGART] Duh, is_r200 is a function, not a variable

Linus Torvalds:
  o Fix subtle fork() race that Ingo noticed

Nathan Scott:
  o [XFS] Add the noikeep mount option, make ikeep the default for now
  o [XFS] Fix a possible bio-leak on I/O submission, in a case where no
    I/O was required
  o [XFS] Update XFS documentation

