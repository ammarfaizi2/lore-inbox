Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267518AbTAXDXZ>; Thu, 23 Jan 2003 22:23:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267523AbTAXDXZ>; Thu, 23 Jan 2003 22:23:25 -0500
Received: from web80302.mail.yahoo.com ([66.218.79.18]:11188 "HELO
	web80302.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S267518AbTAXDXY>; Thu, 23 Jan 2003 22:23:24 -0500
Message-ID: <20030124033230.37656.qmail@web80302.mail.yahoo.com>
Date: Thu, 23 Jan 2003 19:32:30 -0800 (PST)
From: Kevin Lawton <kevinlawton2001@yahoo.com>
Subject: Re: Simple patches for Linux as a guest OS in a plex86 VM (please consider)
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, rev#4 (and hopefully final).  I only renamed a file,
as per suggestion of Andrew Morton.  Haven't seen anything
else worth changing.

Quick recap of the mods involved:

  o Documentation/x86-hal.txt      # added file
  o include/asm-i386/eflags_if.h   # added file (only used for VM)
  o arch/i386/Kconfig              # added one menu entry
  o arch/i386/Makefile             # added one ifdef..endif
  o arch/i386/boot/Makefile        # added one ifdef..endif

Diffs are available at:

  http://bochs.sourceforge.net/tmp/linux-2.5.59-hal4

The file 'Documentation/x86-hal.txt' explains the rationale for
these mods and my case for them going into the kernel before 2.6.

No *.{c,h,S} files are modified.

-Kevin

__________________________________________________
Do you Yahoo!?
New DSL Internet Access from SBC & Yahoo!
http://sbc.yahoo.com
