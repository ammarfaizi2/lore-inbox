Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262035AbUCaQIh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 11:08:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262043AbUCaQIh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 11:08:37 -0500
Received: from gprs212-18.eurotel.cz ([160.218.212.18]:9856 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262035AbUCaQIf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 11:08:35 -0500
Date: Wed, 31 Mar 2004 18:08:06 +0200
From: Pavel Machek <pavel@suse.cz>
To: Tom Rini <trini@kernel.crashing.org>
Cc: "Amit S. Kale" <amitkale@emsyssoft.com>,
       kgdb-bugreport@lists.sourceforge.net,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Latest kgdb?
Message-ID: <20040331160806.GG220@elf.ucw.cz>
References: <20040319162009.GE4569@smtp.west.cox.net> <200403242011.26314.amitkale@emsyssoft.com> <20040324154355.GD7126@smtp.west.cox.net> <200403251022.39704.amitkale@emsyssoft.com> <20040325151444.GC13366@smtp.west.cox.net> <20040331152925.GA6205@elf.ucw.cz> <20040331154541.GH13819@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040331154541.GH13819@smtp.west.cox.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Where can I get latest kgdb? The version on kgdb.sf.net is still
> > against 2.6.3, afaics. Or should I forward port it?
> 
> CVS is against 2.6.4.  Once 2.6.5 comes out, I'll move it forward again.
> Locally, I've got a series of patches vs 2.6.5-rc3 + some -mm bits for
> Andrew which I hope to post today, but might not make it until tomorrow.

Okay, CVS *is* against 2.6.4, but it says it is against 2.6.3. Okay to
commit?
								Pavel
Index: README
===================================================================
RCS file: /cvsroot/kgdb/kgdb-2/README,v
retrieving revision 1.5
diff -u -u -r1.5 README
--- README	2 Mar 2004 11:10:36 -0000	1.5
+++ README	31 Mar 2004 15:52:54 -0000
@@ -1,4 +1,4 @@
-Base Kernel version: 2.6.3
+Base Kernel version: 2.6.4
 
 Patch:
 ------
@@ -39,8 +39,8 @@
 Supply command line options kgdbwait and kgdb8250 to the kernel.
 Example:  kgdbwait kgdb8250=0,115200
 (for ttyS0), then
-   % stty 115200 < /dev/ttyS0
    % gdb ./vmlinux
+   (gdb) set remotebaud 115200
    (gdb) target remote /dev/ttyS0
 
 Example for kgdb ethernet interface


-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
