Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750870AbWGLT1E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750870AbWGLT1E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 15:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750879AbWGLT1E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 15:27:04 -0400
Received: from gepetto.dc.ltu.se ([130.240.42.40]:54685 "EHLO
	gepetto.dc.ltu.se") by vger.kernel.org with ESMTP id S1750870AbWGLT1C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 15:27:02 -0400
Message-ID: <1152732420.44b54d04db5c9@portal.student.luth.se>
Date: Wed, 12 Jul 2006 21:27:00 +0200
From: ricknu-0@student.ltu.se
To: linux-kernel@vger.kernel.org
Subject: [PATCH] add include/linux/utsrelease.h to .gitignore
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
X-Originating-IP: 130.240.42.170
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

include/linux/utsrelease.h is created by Makefile and should be ignored by "git
status".

Signed-off-by: Richard Knutsson <ricknu-0@student.ltu.se>

---

diff --git a/.gitignore b/.gitignore
index 27fd376..2ed86cf 100644
--- a/.gitignore
+++ b/.gitignore
@@ -29,6 +29,7 @@ include/asm-*/asm-offsets.h
 include/config
 include/linux/autoconf.h
 include/linux/compile.h
+include/linux/utsrelease.h
 include/linux/version.h

 # stgit generated dirs

