Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262602AbSJ0UNX>; Sun, 27 Oct 2002 15:13:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262604AbSJ0UNX>; Sun, 27 Oct 2002 15:13:23 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:1554 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S262602AbSJ0UNW>; Sun, 27 Oct 2002 15:13:22 -0500
Message-ID: <3DBC4A4F.4C00CB41@linux-m68k.org>
Date: Sun, 27 Oct 2002 21:19:27 +0100
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>,
       kbuild-devel <kbuild-devel@lists.sourceforge.net>
Subject: linux kernel conf 1.2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

At http://www.xs4all.nl/~zippel/lc/ you can find the latest version of
the new config system.
Changes:
- qconf ui improvements.
- the parser is compiled as a single file (which includes the other
source files), which should speed up the compile a bit and might
simplify kbuild.

A small comment on how I plan to merge this. I will send the patch
(maybe slightly splitted) to Linus. At first the old config files won't
be removed, so Linus can continue to apply other patches, he just can't
configure all the new features. I will rsync periodically his tree and
send him updates. Arch maintainers have a bit time to convert their
trees, they can either use my converter or send me patches relativ to
2.5.4[45] and I'll do it. The old config files will be removed with
2.5.4[67].
This means Linus only needs to apply all the patches and I have all the
work. :)

bye, Roman
