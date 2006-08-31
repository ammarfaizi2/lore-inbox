Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932196AbWHaVgU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932196AbWHaVgU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 17:36:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932338AbWHaVgU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 17:36:20 -0400
Received: from mx1.redhat.com ([66.187.233.31]:1212 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932196AbWHaVfw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 17:35:52 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 4/4] NOMMU: Add docs about shared memory
Date: Thu, 31 Aug 2006 22:35:39 +0100
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org, dhowells@redhat.com
Message-Id: <20060831213539.29363.21990.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060831213530.29363.6372.stgit@warthog.cambridge.redhat.com>
References: <20060831213530.29363.6372.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Add documentation about using shared memory in NOMMU mode.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 Documentation/nommu-mmap.txt |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/Documentation/nommu-mmap.txt b/Documentation/nommu-mmap.txt
index 3ce8906..4db7c18 100644
--- a/Documentation/nommu-mmap.txt
+++ b/Documentation/nommu-mmap.txt
@@ -129,6 +129,15 @@ FURTHER NOTES ON NO-MMU MMAP
      with character device files, pipes, fifos and sockets.
 
 
+==========================
+INTERPROCESS SHARED MEMORY
+==========================
+
+Both SYSV IPC SHM shared memory and POSIX shared memory is supported in NOMMU
+mode.  The former through the usual mechanism, the latter through files created
+on ramfs or tmpfs mounts.
+
+
 =============
 NO-MMU MREMAP
 =============
