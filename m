Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268540AbUHYACN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268540AbUHYACN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 20:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268719AbUHYACN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 20:02:13 -0400
Received: from mail8.fw-bc.sony.com ([160.33.98.75]:9377 "EHLO
	mail8.fw-bc.sony.com") by vger.kernel.org with ESMTP
	id S268540AbUHYAAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 20:00:46 -0400
Message-ID: <412BD812.9020005@am.sony.com>
Date: Tue, 24 Aug 2004 17:06:42 -0700
From: Tim Bird <tim.bird@am.sony.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] advice to use good patch subject, for SubmittingPatches
References: <20040822013402.5917b991.akpm@osdl.org>	<20040823202158.GJ4418@holomorphy.com> <20040823231454.62734afb.akpm@osdl.org>
In-Reply-To: <20040823231454.62734afb.akpm@osdl.org>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> I'd prefer it if you (and everyone else) could give a meaningful
> English-language Subject: to patches, please.
> 
> A well-chosen patch Subject: becomes a sort of globally-unique key by which
> the patch is tracked - I munge it into a patch filename and it propagates
> all the way into bitkeeper.  It can be used for searching email folders,
> googling, inter-developer discussion, etc, etc.

I think this is great advice that should be canonized... :-)

diffstat good-subject-advice.patch:
  Documentation/SubmittingPatches |   11 ++++++++++-


diff -u -X /home/tbird/dontdiff -pruN alp1.orig/Documentation/SubmittingPatches alp1/Documentation/SubmittingPatches
--- alp1.orig/Documentation/SubmittingPatches	2004-08-14 03:54:47.000000000 -0700
+++ alp1/Documentation/SubmittingPatches	2004-08-24 16:52:32.957986032 -0700
@@ -77,7 +80,7 @@
  http://developer.osdl.org/rddunlap/scripts/patching-scripts.tgz

  Andrew Morton's patch scripts:
-http://www.zip.com.au/~akpm/linux/patches/patch-scripts-0.16
+http://www.zip.com.au/~akpm/linux/patches/patch-scripts-0.18

  2) Describe your changes.

@@ -257,7 +260,16 @@
  and other kernel developers more easily distinguish patches from other
  e-mail discussions.

+Also, provide a useful (but short) description in the subject line:
+Andrew Morton once said:

+"I'd prefer it if [everyone] could give a meaningful
+English-language Subject: to patches, please.
+
+A well-chosen patch Subject: becomes a sort of globally-unique key by which
+the patch is tracked - I munge it into a patch filename and it propagates
+all the way into bitkeeper.  It can be used for searching email folders,
+googling, inter-developer discussion, etc, etc."

  11) Sign your work


=============================
Tim Bird
Architecture Group Co-Chair, CE Linux Forum
Senior Staff Engineer, Sony Electronics
E-mail: tim.bird@am.sony.com
=============================
