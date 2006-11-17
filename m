Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424825AbWKQAtf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424825AbWKQAtf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 19:49:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424826AbWKQAtd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 19:49:33 -0500
Received: from w241.dkm.cz ([62.24.88.241]:15049 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1424825AbWKQAtc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 19:49:32 -0500
Date: Fri, 17 Nov 2006 01:49:30 +0100
From: Petr Baudis <pasky@suse.cz>
To: git@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] Cogito-0.18.2
Message-ID: <20061117004930.GC7201@pasky.or.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

  I've released cogito-0.18.2, bringing a couple of bugfixes and a trivial new
feature to cogito-0.18.1. Still nothing too groundshattering.

* cg-log does not follow history across renames anymore; it never really
  actually worked and was instead causing problems and random error
  messages. There needs to be git-core support for this funcionality,
  hacking it with a perl filter is bad design, so I'm not going to fix
  the filter (but I'd take patches if someone else did ;).

* Fix cg-init not letting you edit the initial commit message by default
* Fix cg-clone -l which would not setup alternates properly in some cases
* Fix cg-merge not picking the right base when following volatile branches
* Fix cg-log -d sometimes showing "% @" in diff output
* Some other minor fixes

* New cg-object-id -b to print the current branch name

* Documentation improvements (better documented ignoring mechanism,
  ~/.gitconfig mentioned, GIT_COMMITTER_* bogus information fixed, ...)
* Some testsuite fixes

  Happy hacking,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Of the 3 great composers Mozart tells us what it's like to be human,
Beethoven tells us what it's like to be Beethoven and Bach tells us
what it's like to be the universe.  -- Douglas Adams
