Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268786AbUH3Thi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268786AbUH3Thi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 15:37:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268838AbUH3Thi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 15:37:38 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:28721 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S268786AbUH3Thc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 15:37:32 -0400
Date: Mon, 30 Aug 2004 21:39:15 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
Subject: kbuild updates
Message-ID: <20040830193915.GA18518@mars.ravnborg.org>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, Andrew, lkml.

Here follows a few kbuild updates.
None of these are critical fixes so they may live in -mm for a while,
but safe to add to mainline.

o Adaptions for solaris and cygwin
  - I would be happy to hear reports of outstanding issues when
  building a kernel on non-linux platforms
  - The primary target group for this is embedded people that
  often use non-Linux environements.
  
o new static analyser tool 'namespacecheck' from Keith Owens.
  - Try it on your code and fix the issues
  - The kernel shall be build before running the tool:
    -> make namespacecheck
    Read comments in scripts/namespacecheck.pl to interpret the output
  - The output is comprehensive: ~8000 lines for allmodconfig kernel

Patches not previously posted will be posted to lkml.

Everything pushed to:
bk://linux-sam.bkbits.net/kbuild

	Sam
