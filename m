Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290275AbSAXGrL>; Thu, 24 Jan 2002 01:47:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290277AbSAXGrB>; Thu, 24 Jan 2002 01:47:01 -0500
Received: from [203.143.19.4] ([203.143.19.4]:24079 "EHLO kitul.learn.ac.lk")
	by vger.kernel.org with ESMTP id <S290275AbSAXGqu>;
	Thu, 24 Jan 2002 01:46:50 -0500
Date: Thu, 24 Jan 2002 12:45:48 +0600
From: Anuradha Ratnaweera <anuradha@gnu.org>
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] kernelconf-0.1.2
Message-ID: <20020124124548.A2435@lklug.pdn.ac.lk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here we go again...

Version 0.1.2 is an RFC.  Don't use it unless you are really adventurous.
The size of the tarball has grown by a factor of 6, mostly due to the
symbol files.

URLs:
	http://www.bee.lk/people/anuradha/kernelconf/
	http://www.lklug.pdn.ac.lk/~anuradha/kernelconf/

Getting menuconfig to work correctly is my first priority at this stage.  Then
I will get to oldconfig.  The menu style in this version is fixed. Pretty soon
the user will be able to set the look and feel.  Yes.  Including the good old
thing ;)

Derived values (such as turning on RTC when SMP is set) are working well, but
this is just a quick hack to test it.  The `real' program will prompt the user
whether such changes are to be done or not.

CML1 config.in files were convereted to kernelconf format with a simple awk
script.  There may be errors.

ChangeLog for 0.1.2:
  - Moved lxdialog from scripts/ to conf/
  - Values defined with "value:" are frozen
  - Almost all the symbols for i386 in .conf files
  - Reading config files
  - Vi compatible up and down movements (j and k) in lxdialog (menuconfig)
  - Integer, hex and character input/read/write
  - Symbols and menu handling done with a single tree
  - Made every tristate symbol's module value depend on CONFIG_MODULES
  - Made expression evaluation more sane
  - Better error handling
  - Lots of code cleanups

Known issues:
  - ttyconfig is broken in this version.
  - Menuconfig has some problems when handling the last item.
    Can do a quick and dirty fix, but I thought of addressing this
    issue when working on style selection.
  - Many symbols have duplicates.  The reading routine handles most
    of them properly, but eventually, these entries would unify.
  - Some symbols (notably in framebuffer section) were not convereted
    at all.
  - Many quick hacks here and there to get the program "working".
    Most of this code will disapper during the next week.

	Anuradha

-- 

Debian GNU/Linux (kernel 2.4.16-xfs)

You are absolute plate-glass. I see to the very back of your mind.
		-- Sherlock Holmes

