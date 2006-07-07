Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751191AbWGGLsw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191AbWGGLsw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 07:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750767AbWGGLsc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 07:48:32 -0400
Received: from mx1.redhat.com ([66.187.233.31]:56553 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932111AbWGGLru (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 07:47:50 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 3/8] FDPIC: Fix FDPIC compile errors [try #4]
Date: Fri, 07 Jul 2006 12:47:44 +0100
To: torvalds@osdl.org, akpm@osdl.org, bernds_cb1@t-online.de, sam@ravnborg.org
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org
Message-Id: <20060707114744.948.61321.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060707114738.948.76567.stgit@warthog.cambridge.redhat.com>
References: <20060707114738.948.76567.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

The attached patch fixes FDPIC compile errors

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 fs/binfmt_elf_fdpic.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index eba4e23..07624b9 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -459,6 +459,7 @@ #endif
 	 */
 	hwcap = ELF_HWCAP;
 	k_platform = ELF_PLATFORM;
+	u_platform = NULL;
 
 	if (k_platform) {
 		platform_len = strlen(k_platform) + 1;
