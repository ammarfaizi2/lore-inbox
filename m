Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261434AbVBNNoH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261434AbVBNNoH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 08:44:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261435AbVBNNoH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 08:44:07 -0500
Received: from news.suse.de ([195.135.220.2]:58595 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261434AbVBNNoE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 08:44:04 -0500
Date: Mon, 14 Feb 2005 14:44:02 +0100
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] remove obsolete linux/resource.h inclusion from asm-generic/siginfo.h
Message-ID: <20050214134402.GA19590@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Roland added this include with his 'waitid system call' patch, which
was removed again after a while. Just the header inclusion was not
removed.

http://linux.bkbits.net:8080/linux-2.5/cset@4134b6dd1rY3qnaq7YABrXPXGvzzpw
http://linux.bkbits.net:8080/linux-2.5/cset@41499f66EDHON_8B1FYGEzLZQ2u13Q


diff -purNx tags ../linux-2.6.11-rc4.orig/include/asm-generic/siginfo.h ./include/asm-generic/siginfo.h
--- ../linux-2.6.11-rc4.orig/include/asm-generic/siginfo.h	2005-02-13 04:05:50.000000000 +0100
+++ ./include/asm-generic/siginfo.h	2005-02-14 14:40:46.846725239 +0100
@@ -3,7 +3,6 @@
 
 #include <linux/compiler.h>
 #include <linux/types.h>
-#include <linux/resource.h>
 
 typedef union sigval {
 	int sival_int;
