Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423118AbWJQFb7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423118AbWJQFb7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 01:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423117AbWJQFb7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 01:31:59 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:37255 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1423114AbWJQFb6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 01:31:58 -0400
From: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
Subject: [ANNOUNCE] GIT 1.4.2.4
cc: linux-kernel@vger.kernel.org
Date: Mon, 16 Oct 2006 22:31:56 -0700
Message-ID: <7vvemjqzhv.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The latest maintenance release GIT 1.4.2.4 is available at the
usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.4.2.4.tar.{gz,bz2}			(tarball)
  git-htmldocs-1.4.2.4.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.4.2.4.tar.{gz,bz2}		(preformatted docs)
  RPMS/$arch/git-*-1.4.2.4-1.$arch.rpm	(RPM)

We are close to 1.4.3, so this update coulc become moot very
soon, but just in case we have to delay it, I am pushing this
out for a rather important performance fix.  Without it, "git
diff" on 64-bit machines can run 100x times slower than it
should be on unfortunate input.

Many thanks go to Jim Mayering for giving an easy to reproduce
initial problem report, and Linus and Davide Libenzi to quickly
come up with a fix.

Unfortunately I do not have access to any RPM capable machine
other than an x86-64 right now hence there is no RPM for x86-32
for this release yet (but 32-bit machines do not need this fix
to begin with, so it's Ok).

----------------------------------------------------------------

There is only one change since v1.4.2.3.

Linus Torvalds:
      Fix hash function in xdiff library


