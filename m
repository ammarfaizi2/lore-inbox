Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262724AbVFVGQL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262724AbVFVGQL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 02:16:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262713AbVFVGQK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 02:16:10 -0400
Received: from mail.kroah.org ([69.55.234.183]:55196 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262819AbVFVFWS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 01:22:18 -0400
Cc: tklauser@nuerscht.ch
Subject: [PATCH] I2C: Spelling fixes for drivers/i2c/i2c-core.c
In-Reply-To: <1119417465101@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 21 Jun 2005 22:17:46 -0700
Message-Id: <11194174661220@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] I2C: Spelling fixes for drivers/i2c/i2c-core.c

This patch fixes a misspelling in a comment section.

Signed-off-by: Tobias Klauser <tklauser@nuerscht.ch>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit a551acc2cb1f13a9bd728b8cf86f9adafefdcfb2
tree 2ee02935a9df422b733969affbdcca3a873479c1
parent 614e24be139c0ae70378349e6c6f0e21751e56bf
author Tobias Klauser <tklauser@nuerscht.ch> Thu, 19 May 2005 21:40:38 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Tue, 21 Jun 2005 21:52:00 -0700

 drivers/i2c/i2c-core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -238,7 +238,7 @@ int i2c_del_adapter(struct i2c_adapter *
 	}
 
 	/* detach any active clients. This must be done first, because
-	 * it can fail; in which case we give upp. */
+	 * it can fail; in which case we give up. */
 	list_for_each_safe(item, _n, &adap->clients) {
 		client = list_entry(item, struct i2c_client, list);
 

