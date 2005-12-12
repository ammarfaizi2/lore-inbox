Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750965AbVLLBMN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750965AbVLLBMN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 20:12:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750974AbVLLBMN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 20:12:13 -0500
Received: from w241.dkm.cz ([62.24.88.241]:5321 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750965AbVLLBMN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 20:12:13 -0500
Date: Mon, 12 Dec 2005 02:12:10 +0100
From: Petr Baudis <pasky@suse.cz>
To: git@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] Cogito-0.16.1
Message-ID: <20051212011210.GC12373@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

  this is Cogito version 0.16.1, the next stable release of the
human-friendly version control UI for the Linus' GIT tool. Share
and enjoy at:

	http://www.kernel.org/pub/software/scm/cogito/

  This crispy new release gives you a few minor to medium bugfixes and
a significant cg-patch speedup. You can reach it as the "v0.16" branch
of the Cogito repository. Note that this is just the stable branch, more
interesting stuff is happenning (and especially going to happen) on the
master development branch; if everything goes well, I might release
cogito-0.17rc1 at the end of this week).

  So the new stuff since 0.16 is:

Jonas Fonseca:
      cg-merge: Improve the hook description
      cg-status: handle subdirs when listing heads

Petr Baudis:
      Fix cg-admin-setuprepo warning on missing post-update hook
      Initial cg-push to a remote branch wouldn't work properly
      Fix cg-object-id <singleletter>
      Fix unsafe sed usage in scripts
      cg-clean -n will just pretend to remove stuff
      Make cg-clean whitespace-safe
	If you use filenames with spaces _and_ cg-clean (or cg-clean
	at all, after all), you should certainly upgrade!
      bash-3.1-related fixes
      Fix broken cg-log FILE in subdirectory
      Drastically speed up cg-patch
      cogito-0.16.1

  Happy hacking,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
