Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262689AbVA0T2l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262689AbVA0T2l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 14:28:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262695AbVA0T2l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 14:28:41 -0500
Received: from waste.org ([216.27.176.166]:43935 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262689AbVA0T2f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 14:28:35 -0500
Date: Thu, 27 Jan 2005 11:28:15 -0800
From: Matt Mackall <mpm@selenic.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Andrew Morton <akpm@osdl.org>, "Theodore Ts'o" <tytso@mit.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SHA1 clarify kerneldoc
Message-ID: <20050127192815.GF4573@waste.org>
References: <20050125215015.GQ12076@waste.org> <41F93164.9000508@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41F93164.9000508@tmr.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2005 at 01:22:28PM -0500, Bill Davidsen wrote:
> >  *
> >  * This function generates a SHA1 digest for a single. Be warned, it
>                                                   ^^^^^^
> Is this a term I don't know, "single" as a noun, or should "512 bit 
> block" follow, as it does in crypto/sha1 from rc1-bk1 which is what I 
> have handy?

That'll teach me to add comments.

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: rc2mm1/lib/sha1.c
===================================================================
--- rc2mm1.orig/lib/sha1.c	2005-01-27 11:24:23.000000000 -0800
+++ rc2mm1/lib/sha1.c	2005-01-27 11:25:19.000000000 -0800
@@ -27,9 +27,10 @@
  * @data:   512 bits of data to hash
  * @W:      80 words of workspace (see note)
  *
- * This function generates a SHA1 digest for a single. Be warned, it
- * does not handle padding and message digest, do not confuse it with
- * the full FIPS 180-1 digest algorithm for variable length messages.
+ * This function generates a SHA1 digest for a single 512-bit block.
+ * Be warned, it does not handle padding and message digest, do not
+ * confuse it with the full FIPS 180-1 digest algorithm for variable
+ * length messages.
  *
  * Note: If the hash is security sensitive, the caller should be sure
  * to clear the workspace. This is left to the caller to avoid


-- 
Mathematics is the supreme nostalgia of our time.
