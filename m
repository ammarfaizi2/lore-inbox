Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266867AbUHOUJu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266867AbUHOUJu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 16:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266870AbUHOUJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 16:09:50 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:25195 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S266867AbUHOUJt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 16:09:49 -0400
Date: Sun, 15 Aug 2004 22:12:24 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>
Subject: kbuild + kconfig: Updates
Message-ID: <20040815201224.GI7682@mars.ravnborg.org>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A number of kbuild updates and Randy's Kconfig.debug

Most important stuff is:
o Get rid og bogus "has no CRC" when building external modules
o Rename *.lds.s to *.lds (*)
o Allow external modules to use host-progs

(*) The renaming of the *.lds file has been doen to allow the kernel to
be build with for example Cygwin.
The major outstanding issue with Cygwin/Solaris are availability of
certain .h files for the tools in scripts/* and spread in the tree.
Tested patches that allows the tools to be build under Cygwin/Solaris
are appreciated.

Patches follows this mail.

Everything pushed to:
bk://linux-sam.bkbits.net/kbuild

	Sam
