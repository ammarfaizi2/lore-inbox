Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267287AbUI0Tyu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267287AbUI0Tyu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 15:54:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267291AbUI0Tyu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 15:54:50 -0400
Received: from peabody.ximian.com ([130.57.169.10]:25255 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S267287AbUI0Tye
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 15:54:34 -0400
Subject: [patch] inotify: doh
From: Robert Love <rml@ximian.com>
To: John McCutchan <ttb@tentacle.dhs.org>
Cc: linux-kernel@vger.kernel.org, gamin-list@gnome.org,
       viro@parcelfarce.linux.theplanet.co.uk, akpm@osdl.org, iggy@gentoo.org
In-Reply-To: <1096250524.18505.2.camel@vertex>
References: <1096250524.18505.2.camel@vertex>
Content-Type: multipart/mixed; boundary="=-RbTXWpANFuUXhdvJR5PM"
Date: Mon, 27 Sep 2004 15:53:11 -0400
Message-Id: <1096314791.30503.102.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.0 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-RbTXWpANFuUXhdvJR5PM
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, 2004-09-26 at 22:02 -0400, John McCutchan wrote:

> Announcing the release of inotify 0.10.0. 
> Attached is a patch to 2.6.8.1.

Don't even ask.

And definitely don't laugh.

	Robert Love


--=-RbTXWpANFuUXhdvJR5PM
Content-Disposition: attachment; filename=inotify-rml-extra-brace-1.patch
Content-Type: text/x-patch; name=inotify-rml-extra-brace-1.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Signed-Off-By: Robert Love <rml@novell.com>

 drivers/char/inotify.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -urN linux-inotify/drivers/char/inotify.c linux/drivers/char/inotify.c
--- linux-inotify/drivers/char/inotify.c	2004-09-27 15:51:08.698929232 -0400
+++ linux/drivers/char/inotify.c	2004-09-27 15:52:22.367729872 -0400
@@ -623,7 +623,7 @@
 {
 	struct inotify_watcher *watcher, *next;
 
-	list_for_each_entry_safe(watcher, next, &inode->watchers, i_list) {
+	list_for_each_entry_safe(watcher, next, &inode->watchers, i_list)
 		ignore_helper(watcher, 0);
 }
 EXPORT_SYMBOL_GPL(inotify_inode_is_dead);

--=-RbTXWpANFuUXhdvJR5PM--

