Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268435AbTCFV7I>; Thu, 6 Mar 2003 16:59:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268438AbTCFV7I>; Thu, 6 Mar 2003 16:59:08 -0500
Received: from [24.77.48.240] ([24.77.48.240]:14685 "EHLO aiinc.aiinc.ca")
	by vger.kernel.org with ESMTP id <S268435AbTCFV7H>;
	Thu, 6 Mar 2003 16:59:07 -0500
Date: Thu, 6 Mar 2003 14:09:44 -0800
From: Michael Hayes <mike@aiinc.ca>
Message-Id: <200303062209.h26M9i320362@aiinc.aiinc.ca>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix breakage caused by spelling 'fix'
Cc: torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Mar 2003, Linus Torvalds wrote:
> On Thu, 6 Mar 2003, Michael Hayes wrote:
> >
> > This fixes a spelling "fix" that resulted in a compile error.
> > 
> > With apologies to Russell King.
>
> Ugh, please make things like this just write out the full non-contracted
> thing. Ie "cannot" is a perfectly fine word, we don't need to force
> spelling errors.

Nice to see that _someone_ cares :-)

Okay, here it is again with "cannot".

diff -ur a/include/asm-arm/proc-fns.h b/include/asm-arm/proc-fns.h
--- a/include/asm-arm/proc-fns.h	Tue Mar  4 19:29:20 2003
+++ b/include/asm-arm/proc-fns.h	Thu Mar  6 14:03:14 2003
@@ -125,7 +125,7 @@
 
 #if 0
  * The following is to fool mkdep into generating the correct
- * dependencies.  Without this, it can't figure out that this
+ * dependencies.  Without this, it cannot figure out that this
  * file does indeed depend on the cpu-*.h files.
 #include <asm/cpu-single.h>
 #include <asm/cpu-multi26.h>
