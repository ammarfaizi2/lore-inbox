Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265174AbTB0Os2>; Thu, 27 Feb 2003 09:48:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265177AbTB0Os2>; Thu, 27 Feb 2003 09:48:28 -0500
Received: from oumail.zero.ou.edu ([129.15.0.75]:1782 "EHLO c3p0.ou.edu")
	by vger.kernel.org with ESMTP id <S265174AbTB0Os1>;
	Thu, 27 Feb 2003 09:48:27 -0500
Date: Thu, 27 Feb 2003 08:58:41 -0600
From: Steve Kenton <skenton@ou.edu>
Subject: pointer to .subsection and .previous usage in kernel?
To: lkml <linux-kernel@vger.kernel.org>
Message-id: <3E5E27A1.70BE4B30@ou.edu>
Organization: The University Of Oklahoma
MIME-version: 1.0
X-Mailer: Mozilla 4.7 [en] (X11; U; SunOS 5.8 sun4u)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anyone have a pointer to what we are really trying to accomplish
with .subsection and .previous in the in-line and asm stuff?

Like maybe a readme or coding style doc for in-line and asm code?

That was the main thing I tripped over while trying to build
a 2.5 kernel using the cygwin toolchain with an eye towards
uml under windows.  I found very little documentation about
the directives themselves even in the gnu info stuff and nada,
except one thread about abstracting them in spinlocks,
bout how/why they are used in the kernel.  They appear to be
elf specific which is why the i386pe stuff puked on them.  I
assume that most of this is to maximize cache hits, but that's
just a guess.  There are a largish handful of them scattered
around the kernel outside of locks. Any pointers would be appreciated.

Steve
