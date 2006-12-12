Return-Path: <linux-kernel-owner+w=401wt.eu-S1751266AbWLLMja@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751266AbWLLMja (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 07:39:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbWLLMja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 07:39:30 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:55066 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751266AbWLLMj3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 07:39:29 -0500
Message-ID: <457EA2FE.3050206@garzik.org>
Date: Tue, 12 Dec 2006 07:39:26 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org
CC: Andrew Morton <akpm@osdl.org>, jffs-dev@axis.com,
       David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH/RFC] Delete JFFS (version 1)
Content-Type: multipart/mixed;
 boundary="------------020204040401010400040001"
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020204040401010400040001
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I have created the 'kill-jffs' branch of 
git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/misc-2.6.git that 
removes fs/jffs.

I argue that you can count the users (who aren't on 2.4) on one hand, 
and developers don't seem to have cared for it in ages.

People are already talking about jffs2 replacements, so I propose we zap 
jffs in 2.6.21.

	Jeff




--------------020204040401010400040001
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff --git a/Documentation/feature-removal-schedule.txt b/Documentation/feature-removal-schedule.txt
index 46f2a55..c008303 100644
--- a/Documentation/feature-removal-schedule.txt
+++ b/Documentation/feature-removal-schedule.txt
@@ -270,3 +270,10 @@ Why:	The new layer 3 independant connection tracking replaces the old
 Who:	Patrick McHardy <kaber@trash.net>
 
 ---------------------------
+
+What:	JFFS (version 1) filesystem
+When:	2.6.21
+Why:	No users or developers
+Who:	Jeff Garzik <jeff@garzik.org>
+
+---------------------------

--------------020204040401010400040001--
