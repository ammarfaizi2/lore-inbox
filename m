Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262927AbVDHS0S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262927AbVDHS0S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 14:26:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262923AbVDHS0R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 14:26:17 -0400
Received: from coderock.org ([193.77.147.115]:16610 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262927AbVDHSZt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 14:25:49 -0400
Date: Fri, 8 Apr 2005 20:25:38 +0200
From: Domen Puncer <domen@coderock.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, wharms@bfs.de
Subject: Re: [patch 3/8] lib/c: documentation strncpy()
Message-ID: <20050408182538.GA26061@nd47.coderock.org>
References: <20050408075057.3C9EE1EE91@trashy.coderock.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050408075057.3C9EE1EE91@trashy.coderock.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

this clarifys the documentation on the behavier of strncpy().

From: walter harms <wharms@bfs.de>
Signed-off-by: Domen Puncer <domen@coderock.org>
---
[Geez, again, next time i'll send them to myself first]


 kj-domen/lib/string.c |    4 ++++
 1 files changed, 4 insertions(+)

diff -puN lib/string.c~comment-lib_string lib/string.c
--- kj/lib/string.c~comment-lib_string	2005-04-05 12:57:42.000000000 +0200
+++ kj-domen/lib/string.c	2005-04-05 12:57:42.000000000 +0200
@@ -85,6 +85,10 @@ EXPORT_SYMBOL(strcpy);
  *
  * The result is not %NUL-terminated if the source exceeds
  * @count bytes.
+ *
+ * In the case where the length of @src is less than  that  of
+ * count, the remainder of @dest will be padded with %NUL.
+ *
  */
 char * strncpy(char * dest,const char *src,size_t count)
 {
_
