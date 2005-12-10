Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161022AbVLJSo2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161022AbVLJSo2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 13:44:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161026AbVLJSo2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 13:44:28 -0500
Received: from mailout05.sul.t-online.com ([194.25.134.82]:18053 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1161022AbVLJSo2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 13:44:28 -0500
Message-ID: <439B2232.9010906@t-online.de>
Date: Sat, 10 Dec 2005 19:45:06 +0100
From: Knut Petersen <Knut_Petersen@t-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.7) Gecko/20050414
X-Accept-Language: de, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: "Antonino A. Daplas" <adaplas@gmail.com>,
       linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] Constant spelling
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-ID: GzwfPEZroedwj2tSs60WnEbNj7ZRWepa-wTslSs6tRypfHEIBc8hYJ@t-dialin.net
X-TOI-MSGID: 0ebe1370-5b5f-4aae-b73b-e6f409f88504
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Obviously constants should be spelled correctly.
Follow-up to fbdev-fixing-switch-to-kd_text-enhanced-version.patch


Signed-off-by: Knut Petersen <Knut_Petersen@t-online.de>


diff -uprN -X linux/Documentation/dontdiff -x '*.bak' -x '*.ctx' linuxorig/drivers/video/console/fbcon.c linuxtmp/drivers/video/console/fbcon.c
--- linuxorig/drivers/video/console/fbcon.c	2005-12-10 19:36:49.000000000 +0100
+++ linuxtmp/drivers/video/console/fbcon.c	2005-12-10 19:36:40.000000000 +0100
@@ -2104,7 +2104,7 @@ static int fbcon_switch(struct vc_data *
  	ops->var = info->var;

  	if (old_info != NULL && (old_info != info ||
-				 info->flags & FBINFO_MISC_ALLWAYS_SETPAR)) {
+				 info->flags & FBINFO_MISC_ALWAYS_SETPAR)) {
  		if (info->fbops->fb_set_par)
  			info->fbops->fb_set_par(info);
  		fbcon_del_cursor_timer(old_info);
diff -uprN -X linux/Documentation/dontdiff -x '*.bak' -x '*.ctx' linuxorig/include/linux/fb.h linuxtmp/include/linux/fb.h
--- linuxorig/include/linux/fb.h	2005-12-10 19:36:49.000000000 +0100
+++ linuxtmp/include/linux/fb.h	2005-12-10 19:36:42.000000000 +0100
@@ -735,7 +735,7 @@ struct fb_tile_ops {
   * code whenever there is a bug report related to switching between X and the
   * framebuffer console.
   */
-#define FBINFO_MISC_ALLWAYS_SETPAR   0x40000
+#define FBINFO_MISC_ALWAYS_SETPAR   0x40000


  struct fb_info {

