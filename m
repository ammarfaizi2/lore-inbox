Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261674AbUCCNkv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 08:40:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261782AbUCCNkv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 08:40:51 -0500
Received: from everest.2mbit.com ([24.123.221.2]:59550 "EHLO mail.sosdg.org")
	by vger.kernel.org with ESMTP id S261674AbUCCNkt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 08:40:49 -0500
Message-ID: <4045DFC1.2010904@greatcn.org>
Date: Wed, 03 Mar 2004 21:38:09 +0800
From: Coywolf Qi Hunt <coywolf@greatcn.org>
Organization: GreatCN.org & The Summit Open Source Develoment Group
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en, zh
MIME-Version: 1.0
To: David Weinehall <david@southpole.se>
CC: Kernel Mailinglist <linux-kernel@vger.kernel.org>
References: <401417A3.7000206@lovecn.org> <20040125222914.GB20879@khan.acc.umu.se> <1075223456.5219.1.camel@midux> <40172C5E.3090201@lovecn.org> <20040128033755.GC16675@khan.acc.umu.se>
In-Reply-To: <20040128033755.GC16675@khan.acc.umu.se>
X-Scan-Signature: a772fa79f254a9a4d3a3c5c6ceb66bb8
X-SA-Exim-Connect-IP: 218.24.169.178
X-SA-Exim-Mail-From: coywolf@greatcn.org
Subject: [PATCH 2.0.40] Fix comment error of prepare_binprm() in exec.c
Content-Type: multipart/mixed;
 boundary="------------060409070103000503020809"
X-Spam-Report: * -4.9 BAYES_00 BODY: Bayesian spam probability is 0 to 1%
	*      [score: 0.0000]
X-SA-Exim-Version: 3.1+cvs (built Wed, 25 Feb 2004 14:12:50 -0500)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060409070103000503020809
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

David Weinehall wrote:

> My aim for 2.0.41 is to make it a cleanup-release; remove warnings, tidy
> up a little source-code mess, kill dead code, fix typos etc.
> 
> 
> Regards: David Weinehall

Hello, David

In the comment of prepare_binprm() in fs/exec.c, 512 bytes should be 128 
bytes.

	Coywolf


-- 
Coywolf Qi Hunt
Admin of http://GreatCN.org and http://LoveCN.org

--------------060409070103000503020809
Content-Type: text/plain;
 name="patch-cy0403030-2.0.40"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-cy0403030-2.0.40"

--- linux-2.0.40/fs/exec.c	2004-02-27 11:48:20.000000000 +0800
+++ linux-2.0.40-cy/fs/exec.c	2004-03-03 21:14:28.000000000 +0800
@@ -528,7 +528,7 @@
 
 /* 
  * Fill the binprm structure from the inode. 
- * Check permissions, then read the first 512 bytes
+ * Check permissions, then read the first 128 bytes
  */
 int prepare_binprm(struct linux_binprm *bprm)
 {

--------------060409070103000503020809--
