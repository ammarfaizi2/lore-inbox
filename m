Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264286AbUFCUza@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264286AbUFCUza (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 16:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264295AbUFCUza
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 16:55:30 -0400
Received: from poros.telenet-ops.be ([195.130.132.44]:57830 "EHLO
	poros.telenet-ops.be") by vger.kernel.org with ESMTP
	id S264286AbUFCUz3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 16:55:29 -0400
To: sam@ravnborg.org
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [PATCH] Typo in Makefile
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Thu, 03 Jun 2004 22:55:48 +0200
Message-ID: <874qps5pkb.fsf@p4.48ers.dk>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

A little patch to fix a trivial typo in Makefile.


--- Makefile.orig       2004-06-03 22:41:56.000000000 +0200
+++ Makefile    2004-06-03 22:41:39.000000000 +0200
@@ -53,7 +53,7 @@ ifndef KBUILD_CHECKSRC
   KBUILD_CHECKSRC = 0
 endif
 
-# Use make M=dir to specify direcotry of external module to build
+# Use make M=dir to specify directory of external module to build
 # Old syntax make ... SUBDIRS=$PWD is still supported
 # Setting the environment variable KBUILD_EXTMOD take precedence
 ifdef SUBDIRS

-- 
Bye, Peter Korsgaard
