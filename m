Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422825AbWJZTac@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422825AbWJZTac (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 15:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422886AbWJZTab
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 15:30:31 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:11752 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1422825AbWJZTab (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 15:30:31 -0400
From: Junio C Hamano <junkio@cox.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Add .mailmap at the toplevel.
Date: Thu, 26 Oct 2006 12:30:30 -0700
Message-Id: <11618910300-git-send-email-junkio@cox.net>
X-Mailer: git-send-email 1.4.3.3.gfbe5
Content-type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

git-shortlog has kept this mapping between e-mail addresses and
people's printed names hardcoded in the script, but now it wants
to lose it.  It is project specific data after all, and is better
kept as part of the project.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 .mailmap |   40 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/.mailmap b/.mailmap
new file mode 100644
index 0000000..6a49b9f
--- /dev/null
+++ b/.mailmap
@@ -0,0 +1,40 @@
+#
+# Even with git, we don't always have name translations.
+# So have an email->real name table to translate the
+# (hopefully few) missing names
+#
+Adrian Bunk <bunk@stusta.de>
+Andreas Herrmann <aherrman@de.ibm.com>
+Andrew Morton <akpm@osdl.org>
+Andrew Vasquez <andrew.vasquez@qlogic.com>
+Christoph Hellwig <hch@lst.de>
+Corey Minyard <minyard@acm.org>
+David Woodhouse <dwmw2@shinybook.infradead.org>
+Domen Puncer <domen@coderock.org>
+Douglas Gilbert <dougg@torque.net>
+Ed L Cashin <ecashin@coraid.com>
+Evgeniy Polyakov <johnpol@2ka.mipt.ru>
+Felix Moeller <felix@derklecks.de>
+Frank Zago <fzago@systemfabricworks.com>
+Greg Kroah-Hartman <gregkh@suse.de>
+James Bottomley <jejb@mulgrave.(none)>
+James Bottomley <jejb@titanic.il.steeleye.com>
+Jeff Garzik <jgarzik@pretzel.yyz.us>
+Jens Axboe <axboe@suse.de>
+Kay Sievers <kay.sievers@vrfy.org>
+Mitesh shah <mshah@teja.com>
+Morten Welinder <terra@gnome.org>
+Morten Welinder <welinder@anemone.rentec.com>
+Morten Welinder <welinder@darter.rentec.com>
+Morten Welinder <welinder@troll.com>
+Nguyen Anh Quynh <aquynh@gmail.com>
+Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
+Peter A Jonsson <pj@ludd.ltu.se>
+Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
+Rudolf Marek <R.Marek@sh.cvut.cz>
+Rui Saraiva <rmps@joel.ist.utl.pt>
+Sachin P Sant <ssant@in.ibm.com>
+Santtu Hyrkkö <santtu.hyrkko@gmail.com>
+Simon Kelley <simon@thekelleys.org.uk>
+Tejun Heo <htejun@gmail.com>
+Tony Luck <tony.luck@intel.com>
-- 
1.4.3.3.gfbe5

