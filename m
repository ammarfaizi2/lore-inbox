Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751114AbVKNVwq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114AbVKNVwq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 16:52:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751274AbVKNVwq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 16:52:46 -0500
Received: from mx1.redhat.com ([66.187.233.31]:36243 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751271AbVKNVwo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 16:52:44 -0500
Date: Mon, 14 Nov 2005 16:52:29 -0500
From: Dave Jones <davej@redhat.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] oops-tracing: mention digital photos
Message-ID: <20051114215229.GA9043@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
References: <200511140302.jAE32voh027313@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511140302.jAE32voh027313@hera.kernel.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 13, 2005 at 07:02:57PM -0800, Linux Kernel wrote:
 > tree 849707fda27c41466eabae0119d6386826ddb7dc
 > parent 113fab1386f0093602d9f48b424b945cafd3db23
 > author Diego Calleja <diegocg@gmail.com> Mon, 14 Nov 2005 08:07:40 -0800
 > committer Linus Torvalds <torvalds@g5.osdl.org> Mon, 14 Nov 2005 10:14:17 -0800
 > 
 > [PATCH] oops-tracing: mention digital photos
 > 
 > Signed-off-by: Andrew Morton <akpm@osdl.org>
 > Signed-off-by: Linus Torvalds <torvalds@osdl.org>

Something I've found handy countless times when users do this..

Signed-off-by: Dave Jones <davej@redhat.com>

--- linus/Documentation/oops-tracing.txt~	2005-11-14 16:47:54.000000000 -0500
+++ linus/Documentation/oops-tracing.txt	2005-11-14 16:51:02.000000000 -0500
@@ -32,7 +32,10 @@ the disk is not available then you have 
     has restarted.  Messy but it is the only option if you have not
     planned for a crash. Alternatively, you can take a picture of
     the screen with a digital camera - not nice, but better than
-    nothing.
+    nothing.  If the messages scroll off the top of the console, you
+    may find that booting with a higher resolution (eg, vga=791)
+    will allow you to read more of the text. (Caveat: This needs vesafb,
+    so won't help for 'early' oopses)
 
 (2) Boot with a serial console (see Documentation/serial-console.txt),
     run a null modem to a second machine and capture the output there
