Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965099AbVJ1GbE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965099AbVJ1GbE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 02:31:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965109AbVJ1GbE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 02:31:04 -0400
Received: from mail.kroah.org ([69.55.234.183]:18922 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965099AbVJ1GbD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 02:31:03 -0400
Cc: erik@hovland.org
Subject: [PATCH] kobject_uevent.c has a typo in a comment
In-Reply-To: <11304810214168@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 27 Oct 2005 23:30:21 -0700
Message-Id: <11304810213311@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] kobject_uevent.c has a typo in a comment

This patch changes trough to through in a comment in kobject_uevent.c.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 3ab05c2cd849f4fdee6e79cc9f63d11de6ad63d9
tree 4b60b003d447d63a370564a7059ed2b91b7f119f
parent e801e49d1ca90da1ab0286a3688f2465cb1e45e4
author Erik Hovland <erik@hovland.org> Thu, 06 Oct 2005 10:45:30 -0700
committer Greg Kroah-Hartman <gregkh@suse.de> Thu, 27 Oct 2005 22:47:59 -0700

 lib/kobject_uevent.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
index 04ca442..a318330 100644
--- a/lib/kobject_uevent.c
+++ b/lib/kobject_uevent.c
@@ -54,7 +54,7 @@ static char *action_to_string(enum kobje
 static struct sock *uevent_sock;
 
 /**
- * send_uevent - notify userspace by sending event trough netlink socket
+ * send_uevent - notify userspace by sending event through netlink socket
  *
  * @signal: signal name
  * @obj: object path (kobject)

