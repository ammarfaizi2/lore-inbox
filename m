Return-Path: <SRS0=yVW0=AT=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3291C433E2
	for <io-uring@archiver.kernel.org>; Wed,  8 Jul 2020 21:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE3FF206DF
	for <io-uring@archiver.kernel.org>; Wed,  8 Jul 2020 21:25:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgGHVZv (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 8 Jul 2020 17:25:51 -0400
Received: from sym2.noone.org ([178.63.92.236]:40968 "EHLO sym2.noone.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725787AbgGHVZv (ORCPT <rfc822;io-uring@vger.kernel.org>);
        Wed, 8 Jul 2020 17:25:51 -0400
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 4B2C5p2rfzzvjc1; Wed,  8 Jul 2020 23:25:50 +0200 (CEST)
From:   Tobias Klauser <tklauser@distanz.ch>
To:     io-uring@vger.kernel.org
Subject: [PATCH] configure: fix typos in help/error messages
Date:   Wed,  8 Jul 2020 23:25:50 +0200
Message-Id: <20200708212550.20708-1-tklauser@distanz.ch>
X-Mailer: git-send-email 2.11.0
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 configure | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/configure b/configure
index 223192b8a5f9..518a5b03e8dd 100755
--- a/configure
+++ b/configure
@@ -34,7 +34,7 @@ for opt do
   --cxx=*) cxx="$optarg"
   ;;
   *)
-    echo "ERROR: unkown option $opt"
+    echo "ERROR: unknown option $opt"
     echo "Try '$0 --help' for more information"
     exit 1
   ;;
@@ -75,7 +75,7 @@ Options: [defaults in brackets after descriptions]
   --prefix=PATH            install in PATH [$prefix]
   --includedir=PATH        install headers in PATH [$includedir]
   --libdir=PATH            install runtime libraries in PATH [$libdir]
-  --libdevdir=PATH         install developement libraries in PATH [$libdevdir]
+  --libdevdir=PATH         install development libraries in PATH [$libdevdir]
   --mandir=PATH            install man pages in PATH [$mandir]
   --datadir=PATH           install shared data in PATH [$datadir]
 EOF
-- 
2.27.0

