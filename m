Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262765AbVDAPeJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262765AbVDAPeJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 10:34:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262759AbVDAPcC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 10:32:02 -0500
Received: from mailwasher.lanl.gov ([192.65.95.54]:53124 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S262771AbVDAPb3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 10:31:29 -0500
Message-ID: <424D6948.4000500@mesatop.com>
Date: Fri, 01 Apr 2005 08:31:20 -0700
From: Steven Cole <elenstev@mesatop.com>
User-Agent: Thunderbird 1.0 (Multics)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
CC: Andrew Morton <akpm@osdl.org>, Dave Jones <davej@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] Clarify -rc definition in Documentation/feature-list-2.6.txt
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-PMX-Version: 4.7.0.111621
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gentlehackers,

The day to clarify the real definition of "-rc" is finally here.

Steven

--- linux-2.6.12-rc1-mm4/Documentation/feature-list-2.6.txt.orig        2005-04-01 07:56:23.000000000 -0700
+++ linux-2.6.12-rc1-mm4/Documentation/feature-list-2.6.txt     2005-04-01 07:59:21.000000000 -0700
@@ -23,16 +23,21 @@
  Applying patches.
  ~~~~~~~~~~~~~~~~~
  - In 2.4 and previous kernels, the recommended way to apply patches was
    to use a command line such as ...
    gzip -cd patchXX.gz | patch -p0
    In 2.6, Linus started adding an extra path element to the diffs,
    so using -p1 in the untarred 'to be patched' directory is necessary.

+Release Candidates
+~~~~~~~~~~~~~~~~~
+- In 2.4 and previous kernels, -rc meant "release candidate".
+  In 2.6, -rc means "really churning", so even more testing is desired.
+
  Known gotchas.
  ~~~~~~~~~~~~~~
  Certain known bugs are being reported over and over. Here are the
  workarounds.
  - Blank screen after decompressing kernel?
    Make sure your .config has
     CONFIG_INPUT=y
     CONFIG_VT=y
