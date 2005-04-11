Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261658AbVDKB64@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261658AbVDKB64 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 21:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261660AbVDKB64
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 21:58:56 -0400
Received: from w241.dkm.cz ([62.24.88.241]:12771 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261658AbVDKB6y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 21:58:54 -0400
Date: Mon, 11 Apr 2005 03:58:52 +0200
From: Petr Baudis <pasky@ucw.cz>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Ross Vandegrift <ross@jose.lug.udel.edu>
Subject: [ANNOUNCE] git-pasky-0.2
Message-ID: <20050411015852.GI5902@pasky.ji.cz>
References: <Pine.LNX.4.58.0504091208470.6947@ppc970.osdl.org> <20050409200709.GC3451@pasky.ji.cz> <Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org> <Pine.LNX.4.58.0504091404350.1267@ppc970.osdl.org> <Pine.LNX.4.58.0504091617000.1267@ppc970.osdl.org> <20050410024157.GE3451@pasky.ji.cz> <20050410162723.GC26537@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050410162723.GC26537@pasky.ji.cz>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

  here goes git-pasky-0.2, my set of patches and scripts upon
Linus' git, aimed at human usability and to an extent a SCM-like usage.

  If you already have a previous git-pasky version, just git pull pasky
to get it. Otherwise, you can get it from:

	http://pasky.or.cz/~pasky/dev/git/

  Please see the README there and/or the parent post for detailed
instructions. You can find the changes from the last announcement
in the ChangeLog (releases have separate commits so you can find them
easily; they are also tagged for purpose of diffing etc).

  This is release contains mostly bugfixes, performance enhancements
(especially w.r.t. git diff), and some merges with Linus (except for
diff-tree, where I merged only the new output format). New features
are trivial - support for tagging and short SHA1 ids; you can use
only the start of the SHA1 hash long enough to be unambiguous.

  My immediate plan is implementing git merge, which I will do tommorow,
if noone will do it before that is. ;-)

  Any feedback/opinions/suggestions/patches (especially patches) are
welcome.

  Have fun,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
98% of the time I am right. Why worry about the other 3%.
