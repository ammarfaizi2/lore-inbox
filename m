Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261898AbVFUE3y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261898AbVFUE3y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 00:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261749AbVFUCQt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 22:16:49 -0400
Received: from mail.kroah.org ([69.55.234.183]:33764 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261741AbVFTW7t convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 18:59:49 -0400
Cc: bunk@stusta.de
Subject: [PATCH] fix "make mandocs" after class_simple.c removal
In-Reply-To: <11193083631784@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 20 Jun 2005 15:59:24 -0700
Message-Id: <11193083641656@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] fix "make mandocs" after class_simple.c removal

Due to the removal of class_simple.c, "make mandocs" no longer works.

This patch fixes this issue.

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 733a366c34aea88def75dee478f92233410ab3c4
tree a122298da923d63cad0837b56c51b69391ac6b8d
parent cd987d38cc59053e0bab8150ffaca33b109067f3
author Adrian Bunk <bunk@stusta.de> Thu, 05 May 2005 15:06:38 -0700
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 15:15:12 -0700

 Documentation/DocBook/kernel-api.tmpl |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/Documentation/DocBook/kernel-api.tmpl b/Documentation/DocBook/kernel-api.tmpl
--- a/Documentation/DocBook/kernel-api.tmpl
+++ b/Documentation/DocBook/kernel-api.tmpl
@@ -338,7 +338,6 @@ X!Earch/i386/kernel/mca.c
 X!Iinclude/linux/device.h
 -->
 !Edrivers/base/driver.c
-!Edrivers/base/class_simple.c
 !Edrivers/base/core.c
 !Edrivers/base/firmware_class.c
 !Edrivers/base/transport_class.c

