Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261435AbTCJUqB>; Mon, 10 Mar 2003 15:46:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261442AbTCJUqB>; Mon, 10 Mar 2003 15:46:01 -0500
Received: from ns.splentec.com ([209.47.35.194]:57350 "EHLO pepsi.splentec.com")
	by vger.kernel.org with ESMTP id <S261435AbTCJUqA>;
	Mon, 10 Mar 2003 15:46:00 -0500
Message-ID: <3E6CFC04.7000401@splentec.com>
Date: Mon, 10 Mar 2003 15:56:36 -0500
From: Luben Tuikov <luben@splentec.com>
Organization: Splentec Ltd.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] coding style addendum
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Someone may find this helpful and descriptive of how kernel code
should be developed.

--- linux-2.5.64/Documentation/CodingStyle.orig	2003-03-10 11:23:46.000000000 -0500
+++ linux-2.5.64/Documentation/CodingStyle	2003-03-10 11:37:18.000000000 -0500
@@ -1,3 +1,4 @@
+Updated: Mon Mar 10 16:34:35 UTC 2003

  		Linux kernel coding style

@@ -264,3 +265,26 @@

  Remember: if another thread can find your data structure, and you don't
  have a reference count on it, you almost certainly have a bug.
+
+
+		Chapter 9: Organization
+
+Writing efficient code is important in both complexity and
+implementation.  In other words your code organization should NOT be
+too complex to understand.  Complexity directly depends on the choice
+of data representation and code organization.  To help you stay in
+line, here are a few guidelines to follow:
+
+      Modularize.
+      Use subroutines.
+      Each subroutine/module should do one thing well.
+      Make sure every module/subroutine hides something.
+      Localize input and output in subroutines.
+
+And the most important:
+
+    Choose the data representation that makes the program simple.
+
+
+			      ----------
+

