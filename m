Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266347AbUHXGQf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266347AbUHXGQf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 02:16:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266511AbUHXGQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 02:16:34 -0400
Received: from smtp813.mail.sc5.yahoo.com ([66.163.170.83]:20074 "HELO
	smtp813.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266347AbUHXGPw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 02:15:52 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH/TRIVIAL] Fix comment in kobject_set_name
Date: Tue, 24 Aug 2004 01:15:42 -0500
User-Agent: KMail/1.6.2
Cc: Greg KH <greg@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200408240115.44395.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

===================================================================


ChangeSet@1.1837.1.35, 2004-08-21 23:07:15-05:00, dtor_core@ameritech.net
  kobject: fix kobject_set_name comment.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 kobject.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


===================================================================



diff -Nru a/lib/kobject.c b/lib/kobject.c
--- a/lib/kobject.c	2004-08-24 01:14:58 -05:00
+++ b/lib/kobject.c	2004-08-24 01:14:58 -05:00
@@ -325,7 +325,7 @@
  *	@kobj:	object.
  *	@name:	name. 
  *
- *	If strlen(name) < KOBJ_NAME_LEN, then use a dynamically allocated
+ *	If strlen(name) >= KOBJ_NAME_LEN, then use a dynamically allocated
  *	string that @kobj->k_name points to. Otherwise, use the static 
  *	@kobj->name array.
  */
