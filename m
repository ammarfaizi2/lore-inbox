Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262087AbVCNJmE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262087AbVCNJmE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 04:42:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262088AbVCNJid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 04:38:33 -0500
Received: from ozlabs.org ([203.10.76.45]:25226 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262087AbVCNJes (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 04:34:48 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16949.23272.635958.434463@cargo.ozlabs.ibm.com>
Date: Mon, 14 Mar 2005 20:35:36 +1100
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: domen@coderock.org, anton@samba.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PPC64 delete unused file no_initrd.c
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is from Domen Puncer <domen@coderock.org>.

Remove nowhere referenced file. (egrep "filename\." didn't find anything)

Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -L arch/ppc64/boot/no_initrd.c -puN arch/ppc64/boot/no_initrd.c~remove_file-arch_ppc64_boot_no_initrd.c /dev/null
--- kj/arch/ppc64/boot/no_initrd.c
+++ /dev/null	2005-03-02 11:34:59.000000000 +0100
@@ -1,2 +0,0 @@
-char initrd_data[1];
-int initrd_len = 0;
