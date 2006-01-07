Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964864AbWAGHBh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964864AbWAGHBh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 02:01:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964848AbWAGHBh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 02:01:37 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:39345 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S964824AbWAGHBg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 02:01:36 -0500
From: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
Subject: [ANNOUNCE] GIT 1.0.7
cc: linux-kernel@vger.kernel.org
Date: Fri, 06 Jan 2006 23:01:34 -0800
Message-ID: <7vhd8go71t.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

GIT 1.0.7 is available at http://www.kernel.org/pub/software/scm/git/

Just bunch of cleanups, documentation formatting and spelling
fixes, among them notable are:

 - git-format-patch and git-commit now handles author names with
   ' (ASCII 0x27, single quote) character in them properly.

 - approxidate parser does not get confused when we say "10 days
   ago" immediately after new year.


The master branch has accumulated enough enhancements, and I
plan to do GIT 1.1.0 (and start 1.1.X maintenance series) over
the weekend.  What will be there are listed here, but those who
have been running the "master" branch must be familiar with most
of them.


Johannes Schindelin:
      git-clone: Support changing the origin branch with -o
      Introduce core.sharedrepository
      git-init-db: initialize shared repositories with --shared

John Ellson:
      Make GIT-VERSION-GEN tolerate missing git describe command

Junio C Hamano:
      Versioning scheme changes.
      merge-recursive: conflicting rename case.
      whatchanged: customize diff-tree output
      rev-parse: --show-cdup
      check_packed_git_idx(): check integrity of the idx file itself.
      checkout: sometimes work from a subdirectory.
      ls-tree: chomp leading directories when run from a subdirectory
      git-clone: do not special case dumb http.
      Tutorial: mention shared repository management.
      git-describe: really prefer tags only.
      git-describe: use find_unique_abbrev()
      git-describe: --tags and --abbrev
      git-describe: still prefer annotated tag under --all and --tags
      git-describe: documentation.
      Makefile: use git-describe to mark the git version.
      send-pack/receive-pack: allow errors to be reported back to pusher.

Linus Torvalds:
      Add a "git-describe" command

Lukas Sandstrom:
      git-pack-redundant: speed and memory usage improvements

YOSHIFUJI Hideaki:
      GIT: Support [address] in URLs


