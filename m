Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289532AbSBJPUI>; Sun, 10 Feb 2002 10:20:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289657AbSBJPT6>; Sun, 10 Feb 2002 10:19:58 -0500
Received: from 1Cust172.tnt15.sfo3.da.uu.net ([67.218.75.172]:32273 "EHLO
	morrowfield.home") by vger.kernel.org with ESMTP id <S289532AbSBJPTt>;
	Sun, 10 Feb 2002 10:19:49 -0500
Date: Sun, 10 Feb 2002 10:27:53 -0800 (PST)
Message-Id: <200202101827.KAA10439@morrowfield.home>
From: Tom Lord <lord@regexps.com>
To: rmk@arm.linux.org.uk
CC: linux-kernel@vger.kernel.org
In-Reply-To: <20020210095312.A12674@flint.arm.linux.org.uk> (message from
	Russell King on Sun, 10 Feb 2002 09:53:12 +0000)
Subject: Re: a new arch feature "for Linus"
In-Reply-To: <200202100913.BAA29987@morrowfield.home> <20020210095312.A12674@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



       > The command is:
       > 
       > 	  % arch touched-files-prereqs REVISION
       'arch' really isn't a good choice of command name:

Not it isn't. But the announcment I cut and pasted the example from is
out of date.  In 1.0pre7 the command has been renamed "larch".  The 
command is really:

       > 	  % larch touched-files-prereqs REVISION

Also in the latest NEWS file and worth mentioning since some kernel
maintainers have complained:

  * NOT DONE IN THIS RELEASE, BUT MUCH REQUESTED AND LIKELY TO HAPPEN

  The directory "{arch}" in project trees should, at least optionally,
  have a different name -- but this is slightly tricky to do in an 
  upward compatible way so I'm putting it off for now.

-t


