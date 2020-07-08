Return-Path: <SRS0=yVW0=AT=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66846C433DF
	for <io-uring@archiver.kernel.org>; Wed,  8 Jul 2020 21:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AF20206E2
	for <io-uring@archiver.kernel.org>; Wed,  8 Jul 2020 21:16:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725903AbgGHVQu (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 8 Jul 2020 17:16:50 -0400
Received: from sym2.noone.org ([178.63.92.236]:39980 "EHLO sym2.noone.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbgGHVQt (ORCPT <rfc822;io-uring@vger.kernel.org>);
        Wed, 8 Jul 2020 17:16:49 -0400
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 4B2BvN3sszzvjc1; Wed,  8 Jul 2020 23:16:48 +0200 (CEST)
From:   Tobias Klauser <tklauser@distanz.ch>
To:     io-uring@vger.kernel.org
Subject: [PATCH] .gitignore: add new test binaries
Date:   Wed,  8 Jul 2020 23:16:48 +0200
Message-Id: <20200708211648.19189-1-tklauser@distanz.ch>
X-Mailer: git-send-email 2.11.0
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 .gitignore | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/.gitignore b/.gitignore
index 2e99b03d0ed9..7c44e082fe2c 100644
--- a/.gitignore
+++ b/.gitignore
@@ -30,12 +30,15 @@
 /test/across-fork
 /test/b19062a56726-test
 /test/b5837bd5311d-test
+/test/ce593a6c480a-test
 /test/connect
+/test/close-opath
 /test/cq-full
 /test/cq-overflow
 /test/cq-peek-batch
 /test/cq-ready
 /test/cq-size
+/test/d4ae271dfaae-test
 /test/d77a67ed5f27-test
 /test/defer
 /test/eeed8b54e0df-test
@@ -79,6 +82,7 @@
 /test/socket-rw
 /test/splice
 /test/sq-full
+/test/sq-full-cpp
 /test/sq-poll-kthread
 /test/sq-space_left
 /test/statx
-- 
2.27.0

