Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932221AbWEPW0X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932221AbWEPW0X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 18:26:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932222AbWEPW0X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 18:26:23 -0400
Received: from thunk.org ([69.25.196.29]:22974 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S932221AbWEPW0W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 18:26:22 -0400
Date: Tue, 16 May 2006 18:26:13 -0400
From: Theodore Tso <tytso@mit.edu>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] Update ext2/ext3/jbd MAINTAINERS entries
Message-ID: <20060516222613.GA8368@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20060516174413.GI10077@stusta.de> <20060516122731.6ecbdeeb.akpm@osdl.org> <20060516193956.GS10077@stusta.de> <20060516211430.GA9571@thunk.org> <20060516213344.GT10077@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060516213344.GT10077@stusta.de>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2006 at 11:33:44PM +0200, Adrian Bunk wrote:
> What about getting a MAINTAINERS entry for jbd?
> 
> The only current entry listing ext2-devel@lists.sourceforge.net is for 
> ext2 which doesn't use jbd...

Ext2-devel is the list where all ext2/ext3/jbd development discussions
have been happening.  So it's a better list than
ext3-users@redhat.com, which is mainly for user questions/support.

Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>

diff --git a/MAINTAINERS b/MAINTAINERS
index d6a8e5b..b24cf8b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -969,7 +969,7 @@ S:	Maintained
 EXT3 FILE SYSTEM
 P:	Stephen Tweedie, Andrew Morton
 M:	sct@redhat.com, akpm@osdl.org, adilger@clusterfs.com
-L:	ext3-users@redhat.com
+L:	ext2-devel@lists.sourceforge.net
 S:	Maintained
 
 F71805F HARDWARE MONITORING DRIVER
@@ -1529,6 +1529,12 @@ W:	http://jfs.sourceforge.net/
 T:	git kernel.org:/pub/scm/linux/kernel/git/shaggy/jfs-2.6.git
 S:	Supported
 
+JOURNALLING LAYER FOR BLOCK DEVICS (JBD)
+P:	Stephen Tweedie, Andrew Morton
+M:	sct@redhat.com, akpm@osdl.org
+L:	ext2-devel@lists.sourceforge.net
+S:	Maintained
+
 KCONFIG
 P:	Roman Zippel
 M:	zippel@linux-m68k.org
