Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261939AbTFBGVg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 02:21:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261944AbTFBGVg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 02:21:36 -0400
Received: from 216-239-45-4.google.com ([216.239.45.4]:14669 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S261939AbTFBGVf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 02:21:35 -0400
Date: Sun, 1 Jun 2003 23:34:57 -0700
From: Frank Cusack <fcusack@fcusack.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       trond.myklebust@fys.uio.no
Subject: Re: [PATCH] fs/nfs/nfs3xdr.c trivial comment fix
Message-ID: <20030601233457.A17979@google.com>
References: <20030519211221.A24172@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030519211221.A24172@google.com>; from fcusack@fcusack.com on Mon, May 19, 2003 at 09:12:21PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

resending ... 2.5 does not ignore the nanosecond field

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
