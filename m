Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264255AbTEZEPc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 00:15:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264254AbTEZEOd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 00:14:33 -0400
Received: from serenity.mcc.ac.uk ([130.88.200.93]:24069 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP id S264255AbTEZEOT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 00:14:19 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10539232503071@movementarian.org>
Subject: [PATCH 4/5] OProfile update
In-Reply-To: <10539232501791@movementarian.org>
From: John Levon <levon@movementarian.org>
X-Mailer: gregkh_patchbomb
Date: Mon, 26 May 2003 05:27:30 +0100
Content-Transfer-Encoding: 7BIT
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19K9a6-000OE7-Md*5jk2SYvsMPA*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fix a stale comment.

diff -Naur -X dontdiff linux-cvs/drivers/oprofile/cpu_buffer.c linux-me/drivers/oprofile/cpu_buffer.c
--- linux-cvs/drivers/oprofile/cpu_buffer.c	2003-05-26 03:20:20.000000000 +0100
+++ linux-me/drivers/oprofile/cpu_buffer.c	2003-05-26 03:24:38.000000000 +0100
@@ -168,10 +168,8 @@
 }
 
 
-/* resets the cpu buffer to a sane state - should be called with 
- * cpu_buf->int_lock held
- */
-void cpu_buffer_reset(struct oprofile_cpu_buffer *cpu_buf)
+/* Resets the cpu buffer to a sane state. */
+void cpu_buffer_reset(struct oprofile_cpu_buffer * cpu_buf)
 {
 	/* reset these to invalid values; the next sample
 	 * collected will populate the buffer with proper

