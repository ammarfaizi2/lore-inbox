Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264098AbUHaQln@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264098AbUHaQln (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 12:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263893AbUHaQlm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 12:41:42 -0400
Received: from canuck.infradead.org ([205.233.218.70]:59400 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S264299AbUHaQlW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 12:41:22 -0400
Subject: Re: [DOC] Linux kernel patch submission format
From: David Woodhouse <dwmw2@infradead.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Jeremy Higdon <jeremy@sgi.com>
In-Reply-To: <413431F5.9000704@pobox.com>
References: <413431F5.9000704@pobox.com>
Content-Type: text/plain
Date: Tue, 31 Aug 2004 17:37:41 +0100
Message-Id: <1093970261.6200.45.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.93 (1.5.93-2) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-31 at 04:08 -0400, Jeff Garzik wrote:
> I tried to keep it as short as possible:  here is a page describing the 
> most optimal format for sending patches to Linux kernel developers.
> 
> 	http://linux.yyz.us/patch-format.html

--- patch-format.html.orig
+++ patch-format.html
@@ -83,6 +83,15 @@
 for the 5th time, resist the urge to attach 20 patches to a single
 email.
 
+</li><li><h2>One thread per set of patches</h2>
+
+The corollary to the above rule: when sending more than one patch in
+separate emails, make sure they stay together. Send the second and
+subsequent mails as <em>replies</em> to the first mail, rather than
+having each one start its own thread. (You should also ensure that
+your mail client obeys RFC2822 by including correct
+<TT>References:</TT> headers in replies.)
+
 </li><li><h2>Sign your work</h2>
 
 The sign-off is a simple line at the end of the explanation for the

-- 
dwmw2

