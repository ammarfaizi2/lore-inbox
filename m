Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932543AbWCWIxZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932543AbWCWIxZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 03:53:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932580AbWCWIxZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 03:53:25 -0500
Received: from koto.vergenet.net ([210.128.90.7]:13197 "EHLO koto.vergenet.net")
	by vger.kernel.org with ESMTP id S932573AbWCWIxW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 03:53:22 -0500
Date: Thu, 23 Mar 2006 16:40:29 +0900
From: Horms <horms@verge.net.au>
To: linux-kernel@vger.kernel.org, fastboot@osdl.org
Cc: Eric Biederman <ebiederm@xmission.com>,
       Randy Dunlap <rdunlap@xenotime.net>
Subject: [PATCH] kexec: grammar fix for crash_save_this_cpu()
Message-ID: <20060323074027.GA6273@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Cluestick: seven
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kexec: grammar fix for crash_save_this_cpu()

Signed-Off-By: Horms <horms@verge.net.au>

 crash.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

2c8668dabf218fb8b7fddf605898be3b369fc2ea
diff --git a/arch/i386/kernel/crash.c b/arch/i386/kernel/crash.c
index d49dbe8..fa88a0d 100644
--- a/arch/i386/kernel/crash.c
+++ b/arch/i386/kernel/crash.c
@@ -69,7 +69,7 @@ static void crash_save_this_cpu(struct p
 	 * for the data I pass, and I need tags
 	 * on the data to indicate what information I have
 	 * squirrelled away.  ELF notes happen to provide
-	 * all of that that no need to invent something new.
+	 * all of that, so there is no need to invent something new.
 	 */
 	buf = (u32*)per_cpu_ptr(crash_notes, cpu);
 	if (!buf)
