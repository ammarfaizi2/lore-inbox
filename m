Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268765AbUHaRYR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268765AbUHaRYR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 13:24:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265697AbUHaRYO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 13:24:14 -0400
Received: from canuck.infradead.org ([205.233.218.70]:60684 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S265287AbUHaRUw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 13:20:52 -0400
Subject: Re: [DOC] Linux kernel patch submission format
From: David Woodhouse <dwmw2@infradead.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Jeremy Higdon <jeremy@sgi.com>
In-Reply-To: <4134B221.9070203@pobox.com>
References: <413431F5.9000704@pobox.com>
	 <1093970261.6200.45.camel@localhost.localdomain>
	 <4134B221.9070203@pobox.com>
Content-Type: text/plain
Date: Tue, 31 Aug 2004 18:17:12 +0100
Message-Id: <1093972632.6200.50.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.93 (1.5.93-2) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-31 at 13:15 -0400, Jeff Garzik wrote:
> hmmmm.  While I do agree with the content, I'm trying to avoid 
> lengthening this page.  If we describe every little detail, then it 
> becomes long -- just like SubmittingPatches -- and everybody will skip 
> reading it.

Good point. How about cutting it down to this then:

--- patch-format.html.orig      2004-08-31 17:30:55.867029816 +0100
+++ patch-format.html   2004-08-31 18:16:14.042804288 +0100
@@ -81,7 +81,9 @@

 This cannot be stressed enough.  Even when you are resending a change
 for the 5th time, resist the urge to attach 20 patches to a single
-email.
+email. If you do send multiple emails though, make sure the second
+and subsequent emails are sent as replies to the first, to keep them
+all together in a thread.

 </li><li><h2>Sign your work</h2>


-- 
dwmw2

