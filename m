Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263442AbTIASUg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 14:20:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263453AbTIASUg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 14:20:36 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:15785 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S263442AbTIASUY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 14:20:24 -0400
Subject: Re: bitkeeper comments
From: Albert Cahalan <albert@users.sf.net>
To: Larry McVoy <lm@bitmover.com>
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, ak@suse.de
In-Reply-To: <20030901154646.GB1327@work.bitmover.com>
References: <1062389729.314.31.camel@cube>
	 <20030901140706.GG18458@work.bitmover.com> <1062430014.314.59.camel@cube>
	 <20030901154646.GB1327@work.bitmover.com>
Content-Type: text/plain
Organization: 
Message-Id: <1062439679.845.111.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 01 Sep 2003 14:08:00 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-09-01 at 11:46, Larry McVoy wrote:
> On Mon, Sep 01, 2003 at 11:26:55AM -0400, Albert Cahalan wrote:
> > I'm OK with whatever ensures that somebody looking back
> > through the BitKeeper logs isn't going to come to the
> > conclusion that I broke something.
> > 
> > Um, not everybody will grab updates from bkbits.net,
> > right? Pardon me for being clueless about BitKeeper,
> > but is there some command Andi or Linus could run?
> 
> Unfortunately the checkin comments themselves are not revision controlled.
> You have to run a command on each repository that needs to be fixed,
> if you send me the desired comments I'll post the command.  Then if
> Linus or Marcelo says do it I'll do it on bkbits.net.  That should be good
> enough, the logs there are what people tend to browse.

============ as a patch =============
--- old  2003-09-01 14:04:46.000000000 -0400
+++ new  2003-09-01 14:05:18.000000000 -0400
@@ -2,13 +2,9 @@
 
 Make everything compile and boot again.
 
-The earlier third party ioport.c changes unfortunately didn't even
-compile, fix that too.
-
  - Update defconfig
  - Some minor cleanup
  - Introduce physid_t for APIC masks (fixes UP kernels)
- - Finish ioport.c merge and fix compilation
  - Add bandaid for CardBus bridges and broken BIOS (Vojtech)
  - Add bandaid for unsynchronized TSCs  (Vojtech)
  - Fix ffs(0) return value (fixes XFS) 

=========== old content ============
[PATCH] x86-64 update

Make everything compile and boot again.

The earlier third party ioport.c changes unfortunately didn't even
compile, fix that too.

 - Update defconfig
 - Some minor cleanup
 - Introduce physid_t for APIC masks (fixes UP kernels)
 - Finish ioport.c merge and fix compilation
 - Add bandaid for CardBus bridges and broken BIOS (Vojtech)
 - Add bandaid for unsynchronized TSCs  (Vojtech)
 - Fix ffs(0) return value (fixes XFS) 
 - Fix compilation with software suspend

=========== new content ============
[PATCH] x86-64 update

Make everything compile and boot again.

 - Update defconfig
 - Some minor cleanup
 - Introduce physid_t for APIC masks (fixes UP kernels)
 - Add bandaid for CardBus bridges and broken BIOS (Vojtech)
 - Add bandaid for unsynchronized TSCs  (Vojtech)
 - Fix ffs(0) return value (fixes XFS) 
 - Fix compilation with software suspend


