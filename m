Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285022AbSALFuO>; Sat, 12 Jan 2002 00:50:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285023AbSALFty>; Sat, 12 Jan 2002 00:49:54 -0500
Received: from [203.143.19.4] ([203.143.19.4]:13836 "EHLO kitul.learn.ac.lk")
	by vger.kernel.org with ESMTP id <S285022AbSALFtn>;
	Sat, 12 Jan 2002 00:49:43 -0500
Date: Sat, 12 Jan 2002 11:48:55 +0600
From: Anuradha Ratnaweera <anuradha@gnu.org>
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] KernelConf - menuconfig and help works
Message-ID: <20020112114855.A8005@lklug.pdn.ac.lk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This time it is a working tarball ;)

Highlights: menuconfig, help

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

What am I doing now?
  Coding expression handling.  Converting expressiong to reverse polish
  and evaluating dependencies / derivatives / conflicts etc.  These
  will go into 0.1.x or may be into 0.2.0 if everything goes well.

Cheers,

Anuradha

-- 

Debian GNU/Linux (kernel 2.4.16-xfs)

We all know Linux is great... it does infinite loops in 5 seconds.
        -- Linus Torvalds

