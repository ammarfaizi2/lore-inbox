Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965152AbVIOGuI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965152AbVIOGuI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 02:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932586AbVIOGuI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 02:50:08 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:4782 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932527AbVIOGuH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 02:50:07 -0400
Date: Thu, 15 Sep 2005 08:49:29 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>
Subject: kill useless comment in tipar.c
Message-ID: <20050915064929.GB2726@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kill useless comment in tipar.c.

Signed-off-by: Pavel Machek <pavel@suse.cz>

---
commit ec2999be998bb1981287b20dd656214956e45be8
tree bc713394190bebf63d25306d27281594b30f9405
parent 174567894d7e3522de7bb92406bee3ea68091b33
author <pavel@amd.(none)> Thu, 15 Sep 2005 08:48:59 +0200
committer <pavel@amd.(none)> Thu, 15 Sep 2005 08:48:59 +0200

 drivers/char/tipar.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/char/tipar.c b/drivers/char/tipar.c
--- a/drivers/char/tipar.c
+++ b/drivers/char/tipar.c
@@ -360,7 +360,7 @@ tipar_ioctl(struct inode *inode, struct 
 
 	switch (cmd) {
 	case IOCTL_TIPAR_DELAY:
-		delay = (int)arg;    //get_user(delay, &arg);
+		delay = (int)arg;
 		break;
 	case IOCTL_TIPAR_TIMEOUT:
 		if (arg != 0)

-- 
if you have sharp zaurus hardware you don't need... you know my address
