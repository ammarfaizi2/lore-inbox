Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263667AbTKXJG0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 04:06:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263675AbTKXJG0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 04:06:26 -0500
Received: from [202.181.197.10] ([202.181.197.10]:14860 "EHLO
	gandalf.gnupilgrims.org") by vger.kernel.org with ESMTP
	id S263667AbTKXJGY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 04:06:24 -0500
Date: Mon, 24 Nov 2003 17:05:07 +0800
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.0-test10 - BINFMT_ELF
Message-ID: <20031124090507.GB3391@gandalf.chinesecodefoo.org>
References: <Pine.LNX.4.44.0311231804170.17378-100000@home.osdl.org> <3FC1BBF1.A4D05AD@eyal.emu.id.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
In-Reply-To: <3FC1BBF1.A4D05AD@eyal.emu.id.au>
User-Agent: Mutt/1.3.28i
From: glee@gnupilgrims.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 24, 2003 at 07:06:09PM +1100, Eyal Lebedinsky wrote:
> It is unusual that a Y/n option includes M in the help text:
> ...
> To compile this as a module, choose M here: the module will be called
> binfmt_elf. Saying M or N here is dangerous because some crucial
> programs on your system might be in ELF format.
> 
> Kernel support for ELF binaries (BINFMT_ELF) [Y/n/?] (NEW) y

I think Adrian had forgotten to update the help text.

	- g.



--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="Kconfig.binfmt.patch"

--- linux-2.6.0-test10/fs/Kconfig.binfmt.orig	2003-11-24 16:44:36.000000000 +0800
+++ linux-2.6.0-test10/fs/Kconfig.binfmt	2003-11-24 16:45:10.000000000 +0800
@@ -23,10 +23,6 @@
 	  ld.so (check the file <file:Documentation/Changes> for location and
 	  latest version).
 
-	  To compile this as a module, choose M here: the module will be called
-	  binfmt_elf. Saying M or N here is dangerous because some crucial
-	  programs on your system might be in ELF format.
-
 config BINFMT_FLAT
 	tristate "Kernel support for flat binaries"
 	depends on !MMU || SUPERH

--/04w6evG8XlLl3ft--
