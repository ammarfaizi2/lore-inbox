Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266115AbUJRJoi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266115AbUJRJoi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 05:44:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265970AbUJRJnm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 05:43:42 -0400
Received: from out012pub.verizon.net ([206.46.170.137]:13750 "EHLO
	out012.verizon.net") by vger.kernel.org with ESMTP id S265800AbUJRJll
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 05:41:41 -0400
Message-ID: <41738FD4.5020008@verizon.net>
Date: Mon, 18 Oct 2004 05:41:40 -0400
From: Jim Nelson <james4765@verizon.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: More patches to arch/sparc/Kconfig [2 of 5]
Content-Type: multipart/mixed;
 boundary="------------020101080801070500040707"
X-Authentication-Info: Submitted using SMTP AUTH at out012.verizon.net from [209.158.211.53] at Mon, 18 Oct 2004 04:41:41 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020101080801070500040707
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Fixes typo in help in openpromfs.

Apply against 2.6.9-rc4.

diff -u  arch/sparc/Kconfig.orig arch/sparc/Kconfig


--------------020101080801070500040707
Content-Type: text/x-patch;
 name="arch_sparc_kconfig-fix-openpromfs-help.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="arch_sparc_kconfig-fix-openpromfs-help.patch"

--- ./arch/sparc/Kconfig.orig	2004-10-16 09:53:49.626021592 -0400
+++ ./arch/sparc/Kconfig	2004-10-16 10:13:17.660148269 -0400
@@ -248,7 +248,7 @@
 	  -t openpromfs none /proc/openprom".
 
 	  To compile the /proc/openprom support as a module, choose M here: the
-	  module will be called openpromfs.  If unsure, choose M.
+	  module will be called openpromfs.  If unsure, choose N.
 
 source "fs/Kconfig.binfmt"
 


--------------020101080801070500040707--
