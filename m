Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263395AbSJIAfb>; Tue, 8 Oct 2002 20:35:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263403AbSJIAfb>; Tue, 8 Oct 2002 20:35:31 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:17415 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S263395AbSJIAf2>; Tue, 8 Oct 2002 20:35:28 -0400
Message-ID: <3DA37B0B.59BA4AEF@linux-m68k.org>
Date: Wed, 09 Oct 2002 02:40:43 +0200
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       kbuild-devel <kbuild-devel@lists.sourceforge.net>
Subject: linux kernel conf 0.8
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

At http://www.xs4all.nl/~zippel/lc/ you can find the latest version of
the new config system.

As already mentioned before lkc is pretty much ready (except for kbuild
integration).
Linus, do you have any interest in merging it in the near future? If
not, what's missing?
The 2.5.40 release showed again, how bad three different parsers are, so
I think it's important to fix this finally for 2.6.

Changes this time:
- update to 2.5.41
- better error handling
- I introduced a few automaticly defined symbols (currently ARCH,
KERNELRELEASE, UNAME_RELEASE), which are currently only used for the
default location of the default config (e.g.
"/boot/config-$UNAME_RELEASE" or "arch/$ARCH/defconfig"), which are
currently still hardcoded, but could later be moved into Build.conf.
- more fine tuning
- I had to use my own Makefile again (Rules.make is slowly driving me
insane).

bye, Roman
