Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270109AbTGPD4v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 23:56:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270110AbTGPD4v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 23:56:51 -0400
Received: from 216-239-45-4.google.com ([216.239.45.4]:33820 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S270109AbTGPD4v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 23:56:51 -0400
Date: Tue, 15 Jul 2003 21:11:39 -0700
From: Frank Cusack <fcusack@fcusack.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] [RESEND] fs/nfs/nfs3xdr.c trivial comment fix
Message-ID: <20030715211139.B9016@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	2.5 VFS does care for fractional times

--- linux-2.5.69/fs/nfs/nfs3xdr.c.orig	Mon May 19 21:05:20 2003
+++ linux-2.5.69/fs/nfs/nfs3xdr.c	Mon May 19 21:05:37 2003
@@ -124,8 +124,6 @@
 
 /*
  * Encode/decode time.
- * Since the VFS doesn't care for fractional times, we ignore the
- * nanosecond field.
  */
 static inline u32 *
 xdr_encode_time3(u32 *p, struct timespec *timep)
