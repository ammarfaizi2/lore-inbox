Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266128AbUGZTyL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266128AbUGZTyL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 15:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265784AbUGZTpk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 15:45:40 -0400
Received: from mx1.redhat.com ([66.187.233.31]:485 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265931AbUGZSqI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 14:46:08 -0400
Date: Mon, 26 Jul 2004 14:46:03 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@dhcp83-76.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: Stephen Smalley <sds@epoch.ncsc.mil>, <linux-kernel@vger.kernel.org>
Subject: [PATCH][SELINUX] Fix compilation problem.
Message-ID: <Xine.LNX.4.44.0407261440490.3049-100000@dhcp83-76.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please apply.

Author:  Pawel Sikora <pluto@pld-linux.org>


--- linux-2.6.8-rc2/security/selinux/hooks.c.orig	2004-07-18 11:56:07.000000000 +0200
+++ linux-2.6.8-rc2/security/selinux/hooks.c	2004-07-18 14:21:27.429622416 +0200
@@ -63,6 +63,7 @@
 #include <net/ipv6.h>
 #include <linux/hugetlb.h>
 #include <linux/major.h>
+#include <linux/personality.h>
 
 #include "avc.h"
 #include "objsec.h"

