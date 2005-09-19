Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932284AbVISBOb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932284AbVISBOb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 21:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932286AbVISBOb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 21:14:31 -0400
Received: from w241.dkm.cz ([62.24.88.241]:29588 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932283AbVISBOa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 21:14:30 -0400
Date: Mon, 19 Sep 2005 03:14:28 +0200
From: Petr Baudis <pasky@suse.cz>
To: Junio C Hamano <junkio@cox.net>
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] Cogito-0.15
Message-ID: <20050919011428.GF22391@pasky.or.cz>
References: <7vr7c02zgg.fsf@assigned-by-dhcp.cox.net> <7vwtleyml5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7vwtleyml5.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

  this is the release of Cogito-0.15. It fixes several minor bugs, and
adds a feature or two. The most important thing though is that this
depends on Git-core-0.99.7 and uses the new command names. Everyone is
encouraged to upgrade at least to this Cogito version in the next few
days, since the older Cogito versions likely won't work with the future
Git-core releases.

  To stay in sync with the Git terminology, Cogito also renames its
cg-pull to cg-fetch. Since this is a major naming change (I'm not too
happy about it, personally), cg-pull will stay aliased to cg-fetch for
at least one (likely two) next major Cogito releases (it also produces a
warning when invoked as cg-pull). In the more distant future, cg-pull
will slowly become the new name of cg-update, to make it confusing.

  While at it, we also renamed the *-id scriptlets to cg-*-id. Other
notable stuff is cg-init respecting the ignore rules, and better UI for
cg-add wrt. directories (including cg-add -r support).

  Now let's see what the usual bug-right-after-release (major release,
so a major bug?) will be this time.

  Happy hacking,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
