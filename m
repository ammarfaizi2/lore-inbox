Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262705AbTJYS2r (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Oct 2003 14:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262755AbTJYS2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Oct 2003 14:28:47 -0400
Received: from havoc.gtf.org ([63.247.75.124]:18574 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S262705AbTJYS2q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Oct 2003 14:28:46 -0400
Date: Sat, 25 Oct 2003 14:26:23 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: ak@suse.de, linux-kernel@vger.kernel.org
Subject: [AMD64 3/3] fix bcopy prototype
Message-ID: <20031025182623.GA12029@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


# --------------------------------------------
# 03/10/25	jgarzik@redhat.com	1.1353
# [AMD64] fix bcopy prototype
# 
# Linus recently fixed the version in lib/
# --------------------------------------------

diff -Nru a/arch/x86_64/kernel/x8664_ksyms.c b/arch/x86_64/kernel/x8664_ksyms.c
--- a/arch/x86_64/kernel/x8664_ksyms.c	Sat Oct 25 06:08:28 2003
+++ b/arch/x86_64/kernel/x8664_ksyms.c	Sat Oct 25 06:08:28 2003
@@ -153,7 +153,7 @@
 
 extern void * memset(void *,int,__kernel_size_t);
 extern size_t strlen(const char *);
-extern char * bcopy(const char * src, char * dest, int count);
+extern void bcopy(const char * src, char * dest, int count);
 extern void * memmove(void * dest,const void *src,size_t count);
 extern char * strcpy(char * dest,const char *src);
 extern int strcmp(const char * cs,const char * ct);
