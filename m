Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261914AbSJQRaa>; Thu, 17 Oct 2002 13:30:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261919AbSJQRaa>; Thu, 17 Oct 2002 13:30:30 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:6406 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S261914AbSJQRa3>; Thu, 17 Oct 2002 13:30:29 -0400
Date: Thu, 17 Oct 2002 19:36:14 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org,
       kbuild-devel <kbuild-devel@lists.sourceforge.net>
Subject: linux kernel conf 1.0
Message-ID: <Pine.LNX.4.44.0210171224020.338-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is now the final release (it's as usual at http://www.xs4all.nl/~zippel/lc/ ).
Changes in this release:
- help texts are a bit more indented (by two spaces) and long texts (more
than 10 lines), start with "---help---".
- in preparation of the library API I renamed a few structures/symbols.

Linus, nobody complained about it, so I put it now into your hands. :)
The easiest way is probably to use the converter with 'make install
KERNELSRC=...', which will convert your current tree.
The generated name is still Kconfig, if you prefer something different,
it's easily changable. The name is generated in cml1.y:gen_filename() and
only a search&replace in fixup-all.diff is needed.

bye, Roman

