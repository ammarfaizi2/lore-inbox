Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261583AbVCCKuJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261583AbVCCKuJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 05:50:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261560AbVCCKq0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 05:46:26 -0500
Received: from faui3es.informatik.uni-erlangen.de ([131.188.33.16]:13748 "EHLO
	faui3es.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261554AbVCCKnT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 05:43:19 -0500
Date: Thu, 3 Mar 2005 11:43:08 +0100
Message-Id: <200503031043.j23Ah8vP020779@faui31y.informatik.uni-erlangen.de>
From: Martin Waitz <tali@admingilde.org>
To: tali@admingilde.org
Cc: linux-kernel@vger.kernel.org
References: <20050303102852.GG8617@admingilde.org>
Subject: [PATCH 14/16] [DocBook] add kfifo to kernel-api docs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[DocBook] add kfifo to kernel-api docs
Signed-off-by: Martin Waitz <tali@admingilde.org>


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.2038  -> 1.2039 
#	Documentation/DocBook/kernel-api.tmpl	1.34    -> 1.35   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 05/03/02	tali@admingilde.org	1.2039
# [DocBook] add kfifo to kernel-api docs
# 
# Signed-off-by: Martin Waitz <tali@admingilde.org>
# --------------------------------------------
#
diff -Nru a/Documentation/DocBook/kernel-api.tmpl b/Documentation/DocBook/kernel-api.tmpl
--- a/Documentation/DocBook/kernel-api.tmpl	Thu Mar  3 11:43:12 2005
+++ b/Documentation/DocBook/kernel-api.tmpl	Thu Mar  3 11:43:12 2005
@@ -100,6 +100,14 @@
      </sect1>
   </chapter>
 
+  <chapter id="kfifo">
+     <title>FIFO Buffer</title>
+     <sect1><title>kfifo interface</title>
+!Iinclude/linux/kfifo.h
+!Ekernel/kfifo.c
+     </sect1>
+  </chapter>
+
   <chapter id="proc">
      <title>The proc filesystem</title>
  
