Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266252AbUHYWtN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266252AbUHYWtN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 18:49:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266220AbUHYWsu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 18:48:50 -0400
Received: from mail.kroah.org ([69.55.234.183]:34203 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266245AbUHYWhB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 18:37:01 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.9-rc1
In-Reply-To: <10934733873951@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Wed, 25 Aug 2004 15:36:28 -0700
Message-Id: <1093473388797@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1803.64.7, 2004/08/24 16:19:31-07:00, dtor_core@ameritech.net

[PATCH] kobject: fix kobject_set_name comment.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 lib/kobject.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/lib/kobject.c b/lib/kobject.c
--- a/lib/kobject.c	2004-08-25 14:55:05 -07:00
+++ b/lib/kobject.c	2004-08-25 14:55:05 -07:00
@@ -343,7 +343,7 @@
  *	@kobj:	object.
  *	@name:	name. 
  *
- *	If strlen(name) < KOBJ_NAME_LEN, then use a dynamically allocated
+ *	If strlen(name) >= KOBJ_NAME_LEN, then use a dynamically allocated
  *	string that @kobj->k_name points to. Otherwise, use the static 
  *	@kobj->name array.
  */

