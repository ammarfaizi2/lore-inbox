Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261810AbVBXQac@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261810AbVBXQac (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 11:30:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261708AbVBXQac
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 11:30:32 -0500
Received: from quark.didntduck.org ([69.55.226.66]:49564 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S261810AbVBXQaW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 11:30:22 -0500
Message-ID: <421E011E.6030709@didntduck.org>
Date: Thu, 24 Feb 2005 11:30:22 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla Thunderbird  (X11/20041216)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.11-rc5
References: <Pine.LNX.4.58.0502232014190.18997@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0502232014190.18997@ppc970.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> Hey, I hoped -rc4 was the last one, but we had some laptop resource
> conflicts, various ppc TLB flush issues, some possible stack overflows in
> networking and a number of other details warranting a quick -rc5 before
> the final 2.6.11.
> 
> This time it's really supposed to be a quickie, so people who can, please 
> check it out, and we'll make the real 2.6.11 asap.
> 
> Mostly pretty small changes (the largest is a new SATA driver that crept
> in, our bad). But worth another quick round.
> 
> 		Linus
> 
> ----

It looks like the v2.6.11-rc5 tag is on the same revisions as 2.6.10. 
patch-2.6.11-rc5 is an empty file, and patch-2.6.11-rc4-rc5 indicates 
that 2.6.11-rc5 reverted to 2.6.10:

diff -urN linux-2.6.11-rc4/Makefile linux-2.6.11-rc5/Makefile
--- linux-2.6.11-rc4/Makefile   2005-02-23 20:53:50.707759849 -0800
+++ linux-2.6.11-rc5/Makefile   2004-12-24 13:35:01.000000000 -0800
@@ -1,7 +1,7 @@
  VERSION = 2
  PATCHLEVEL = 6
-SUBLEVEL = 11
-EXTRAVERSION =-rc4
+SUBLEVEL = 10
+EXTRAVERSION =
  NAME=Woozy Numbat

  # *DOCUMENTATION*


--
				Brian Gerst
