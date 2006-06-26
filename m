Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965244AbWFZBJQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965244AbWFZBJQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 21:09:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964990AbWFZBIt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 21:08:49 -0400
Received: from terminus.zytor.com ([192.83.249.54]:19343 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S964987AbWFZA6r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 20:58:47 -0400
Date: Sun, 25 Jun 2006 17:58:02 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: linux-kernel@vger.kernel.org, klibc@zytor.com
Subject: [klibc 15/43] Default KLIBCARCH ?= $(ARCH)
Message-Id: <klibc.200606251757.15@tazenda.hos.anvin.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Special cases, like powerpc, can be handled in arch/*/Makefile.

Signed-off-by: H. Peter Anvin <hpa@zytor.com>

---
commit 060ee84166196f97abcb34bd6af7df1cfc677578
tree 2863d14dc1c27d4ab152a1b0eae96c956b97e1ea
parent 161e1dc16ec1129b30b634a2a8dcbbd1937800c5
author H. Peter Anvin <hpa@zytor.com> Mon, 22 May 2006 14:39:39 -0700
committer H. Peter Anvin <hpa@zytor.com> Sun, 18 Jun 2006 18:52:08 -0700

 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index ea1bae0..c550270 100644
--- a/Makefile
+++ b/Makefile
@@ -179,7 +179,7 @@ # Architecture as present in compile.h
 UTS_MACHINE	:= $(ARCH)
 
 # Architecture used to compile user-space code
-KLIBCARCH	?= $(subst powerpc,ppc,$(ARCH))
+KLIBCARCH	?= $(ARCH)
 
 # klibc definitions
 export KLIBCINC := usr/include
