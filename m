Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755642AbWKQKD4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755642AbWKQKD4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 05:03:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755643AbWKQKD4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 05:03:56 -0500
Received: from mx1.redhat.com ([66.187.233.31]:49088 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1755642AbWKQKDz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 05:03:55 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20061114200621.12943.18023.stgit@warthog.cambridge.redhat.com> 
References: <20061114200621.12943.18023.stgit@warthog.cambridge.redhat.com> 
To: torvalds@osdl.org, akpm@osdl.org, sds@tycho.nsa.gov,
       trond.myklebust@fys.uio.no
Cc: dhowells@redhat.com, selinux@tycho.nsa.gov, linux-kernel@vger.kernel.org,
       aviro@redhat.com, steved@redhat.com
Subject: [PATCH 26/19] CacheFiles: Don't include linux/proc_fs.h
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Fri, 17 Nov 2006 10:01:30 +0000
Message-ID: <4709.1163757690@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Don't include linux/proc_fs.h anymore as we no longer use procfs.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 fs/cachefiles/cf-bind.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/fs/cachefiles/cf-bind.c b/fs/cachefiles/cf-bind.c
index 0c055a9..2c22d35 100644
--- a/fs/cachefiles/cf-bind.c
+++ b/fs/cachefiles/cf-bind.c
@@ -20,7 +20,6 @@ #include <linux/namei.h>
 #include <linux/mount.h>
 #include <linux/namespace.h>
 #include <linux/statfs.h>
-#include <linux/proc_fs.h>
 #include <linux/ctype.h>
 #include "internal.h"
 
