Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964979AbWFZBLF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964979AbWFZBLF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 21:11:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964981AbWFZA6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 20:58:42 -0400
Received: from terminus.zytor.com ([192.83.249.54]:16783 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S964979AbWFZA62
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 20:58:28 -0400
Date: Sun, 25 Jun 2006 17:58:00 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: linux-kernel@vger.kernel.org, klibc@zytor.com
Subject: [klibc 11/43] Enable KLIBC_ERRLIST
Message-Id: <klibc.200606251757.11@tazenda.hos.anvin.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: H. Peter Anvin <hpa@zytor.com>

---
commit d669be433cc9bc413d958e140f8ec47211498a2a
tree 87c42e923244e280807785bb7dc5719cee7834b7
parent 869206cac1cb04d54582dc4383248ee9721073e8
author H. Peter Anvin <hpa@zytor.com> Tue, 07 Feb 2006 09:21:40 -0800
committer H. Peter Anvin <hpa@zytor.com> Sun, 18 Jun 2006 18:47:25 -0700

 usr/Kconfig |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/usr/Kconfig b/usr/Kconfig
index 07727f3..ea3b520 100644
--- a/usr/Kconfig
+++ b/usr/Kconfig
@@ -44,3 +44,7 @@ config INITRAMFS_ROOT_GID
 	  owned by group root in the initial ramdisk image.
 
 	  If you are not sure, leave it set to "0".
+
+config KLIBC_ERRLIST
+	bool
+	default y
