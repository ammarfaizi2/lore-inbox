Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261845AbTEKSgO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 14:36:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261849AbTEKSgO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 14:36:14 -0400
Received: from havoc.daloft.com ([64.213.145.173]:12710 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S261845AbTEKSgN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 14:36:13 -0400
Date: Sun, 11 May 2003 14:48:55 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [BK+PATCH] mention useful BK tip
Message-ID: <20030511184855.GA14317@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus, please do a

	bk pull bk://kernel.bkbits.net/jgarzik/misc-2.5

This will update the following files:

 Documentation/BK-usage/bk-kernel-howto.txt |    8 ++++++++
 1 files changed, 8 insertions(+)

through these ChangeSets:

<jgarzik@redhat.com> (03/05/11 1.1105)
   [bk] add useful tip to bk kernel howto
   
   Kudos to Wayne Scott @ BitMover for this.



diff -Nru a/Documentation/BK-usage/bk-kernel-howto.txt b/Documentation/BK-usage/bk-kernel-howto.txt
--- a/Documentation/BK-usage/bk-kernel-howto.txt	Sun May 11 14:48:13 2003
+++ b/Documentation/BK-usage/bk-kernel-howto.txt	Sun May 11 14:48:13 2003
@@ -273,3 +273,11 @@
 A tag is just an alias for a specific changeset... and since changesets
 are ordered, a tag is thus a marker for a specific point in time (or
 specific state of the tree).
+
+
+3) Is there an easy way to generate One Big Patch versus mainline,
+   for my long-lived kernel branch?
+A. Yes.  This requires BK 3.x, though.
+
+	bk export -tpatch -r`bk repogca bk://linux.bkbits.net/linux-2.5`,+
+
