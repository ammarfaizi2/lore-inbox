Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287868AbSANHDN>; Mon, 14 Jan 2002 02:03:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288864AbSANHDE>; Mon, 14 Jan 2002 02:03:04 -0500
Received: from [203.143.19.4] ([203.143.19.4]:11017 "EHLO kitul.learn.ac.lk")
	by vger.kernel.org with ESMTP id <S288850AbSANHCt>;
	Mon, 14 Jan 2002 02:02:49 -0500
Date: Mon, 14 Jan 2002 13:02:05 +0600
From: Anuradha Ratnaweera <anuradha@gnu.org>
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] kernelconf-0.1.1 - menu dependencies working
Message-ID: <20020114130205.A10156@lklug.pdn.ac.lk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here goes another release of kernelconf...

Highlights are, expression parsing (almost complate), expression evaluation,
and menu dependencies.  Most work was done on menuconfig.

0.2.0 will contain full support for dependencies, derived values and menu
dependencies. 0.1.1 has most necessary infrastructure to handle expressions,
but I want to go through the code again to make sure that everything is fine,
before trying anything further.  Also, refinements and cleanups are necessary
for some parts of the code.

Notice that I am trying to keep kernelconf interface compatible with CML1 at
the initial stages.

URLs:
    http://www.bee.lk/people/anuradha/kernelconf/
    http://www.lklug.pdn.ac.lk/~anuradha/kernelconf/

Version 0.1.1
  - Menu dependancies in menuconfig
  - Expression evaluating (mostly boolean)
  - Expression parsing (almost complete)
  - Fixed menuconfig not to alter parent menu items twice
  - Prompt for saving new configuration on exit
  - Return to parent menu after radio button selection (menuconfig)
  - Radio button menus display current selection (menuconfig)
  - Unlink tempory files created by menuconfig
  - More symbols and dependencies in config files

Version 0.1.0
  - Added menuconfig using lxdialog
  - Added help support (doesn't use Configure.help)
  - Added selection support in ttyconfig
  - Made ttyconfig much better
  - Added more symbols and menu-items to i386.conf file from CML1
  - Added some comments from Configure.help to i386.conf file
  - A lot (too numerous to mention) of code cleanups and bugfixes
  - New bugs ;)

Version 0.0.1
  - Reads and parses symbols and menus from .conf files into a binary tree
  - Menu hiearachy is functional for boolean and tristate symbols
  - make ttyconfig works for boolean and tristate symbols
  - Writing .config and autoconf.h works for boolean and tristate symbols
  - Just a couple of symbols and menu items in the i386.conf file

	Anuradha

-- 

Debian GNU/Linux (kernel 2.4.16-xfs)

When a float occurs on the same page as the start of a supertabular
you can expect unexpected results.
	-- Documentation of supertabular.sty

