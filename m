Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266283AbUBLF1Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 00:27:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266285AbUBLF1Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 00:27:16 -0500
Received: from ozlabs.org ([203.10.76.45]:25047 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S266283AbUBLF1O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 00:27:14 -0500
Subject: PPC64 PowerMac G5 support available
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, benh@ozlabs.org
Content-Type: text/plain
Message-Id: <1076563481.2285.167.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 12 Feb 2004 16:24:41 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus !

You can pull from bk://ppc.bkbits.net/for-linus-ppc

Curious can inspect the patch using the bkbits web interface

If Andrew prefers keeping it into -mm for a while, I can do a big
patch from the bk tree, though this patch is putting other ppc64
stuffs on hold for now, so it shall go in asap (as it would be too
nasty to deal with conflicts if other things went in at this point).

Linus: you will probably need an updated radeonfb anyway as I told
you. I'll start working on it now and will post a patch separately.

Also, there is currently a known build problem with the zImage wrapper
in 2.6.3-rc2, unrelated to this patch, it doesn't prevent the build of
the plain vmlinux which is what yaboot uses on the G5.

Finally, ieee1394 triggers an oops in kobject since 2.6.3-rc2, 100%
reproduceable for me (and apparently x86 users too), so that's also
unrelated to the G5 code.

Ben.


