Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262372AbUKVVB7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262372AbUKVVB7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 16:01:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262388AbUKVVBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 16:01:51 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:59246 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S262372AbUKVUtc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 15:49:32 -0500
Date: Mon, 22 Nov 2004 21:49:36 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: init/Kconfig: Spelling fix
Message-ID: <20041122204936.GC7108@mars.ravnborg.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20041122204653.GA7108@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041122204653.GA7108@mars.ravnborg.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fix typo in init/Kconfig
  
Patch below fixes a typo in init/Kconfig for option CC_ALIGN_FUNCTIONS.
  
Signed-off-by: Cal Peake <cp@absolutedigital.net>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

diff -Nru a/init/Kconfig b/init/Kconfig
--- a/init/Kconfig	2004-11-22 21:46:04 +01:00
+++ b/init/Kconfig	2004-11-22 21:46:04 +01:00
@@ -326,7 +326,7 @@
 	  which may be appropriate on small systems without swap.
 
 config CC_ALIGN_FUNCTIONS
-	int "Function alignment" if EMBDEDDED
+	int "Function alignment" if EMBEDDED
 	default 0
 	help
 	  Align the start of functions to the next power-of-two greater than n,
