Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932332AbWDGORN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932332AbWDGORN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 10:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932342AbWDGORN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 10:17:13 -0400
Received: from [151.97.230.9] ([151.97.230.9]:410 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S932332AbWDGORM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 10:17:12 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH] Fix mode of checkstack.pl and other files.
Date: Fri, 07 Apr 2006 16:16:40 +0200
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Message-Id: <20060407141639.15204.34538.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Make it executable like it should be. Do the same for other files intended to be
executed by the user - the ones called by the build process needn't be
executable as they already work (as argument to their interpreter).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 scripts/bloat-o-meter |    0 
 scripts/checkstack.pl |    0 
 scripts/namespace.pl  |    0 
 scripts/show_delta    |    0 
 4 files changed, 0 insertions(+), 0 deletions(-)

diff --git a/scripts/bloat-o-meter b/scripts/bloat-o-meter
old mode 100644
new mode 100755
diff --git a/scripts/checkstack.pl b/scripts/checkstack.pl
old mode 100644
new mode 100755
diff --git a/scripts/namespace.pl b/scripts/namespace.pl
old mode 100644
new mode 100755
diff --git a/scripts/show_delta b/scripts/show_delta
old mode 100644
new mode 100755
