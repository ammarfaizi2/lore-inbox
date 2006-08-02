Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751213AbWHBPdS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213AbWHBPdS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 11:33:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751218AbWHBPdS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 11:33:18 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:7955 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751213AbWHBPdS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 11:33:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=JIiUPe2t0NGmF2pcTMn4k6+tpwahjGUf+GzRQjQgJOi8NFLnc6lGOuSzHlOeICO6K8fMGId1OjccHg9oXGOe21hK+ld2YrVCM3albgiNaQ43E+3oYn6EAzO7fLyZW/YrYfpUgKh9tl48RXJc20z080SWGNBb81shxtAfQEuZm+0=
Date: Wed, 2 Aug 2006 19:33:12 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] debug_locks.h: add "struct task_struct;"
Message-ID: <20060802153312.GC6827@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Removes many, many "declared inside parameter list" warnings on parisc.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 include/linux/debug_locks.h |    2 ++
 1 file changed, 2 insertions(+)

--- a/include/linux/debug_locks.h
+++ b/include/linux/debug_locks.h
@@ -1,6 +1,8 @@
 #ifndef __LINUX_DEBUG_LOCKING_H
 #define __LINUX_DEBUG_LOCKING_H
 
+struct task_struct;
+
 extern int debug_locks;
 extern int debug_locks_silent;
 

