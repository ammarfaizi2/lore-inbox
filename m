Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268851AbTBZWee>; Wed, 26 Feb 2003 17:34:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268960AbTBZWee>; Wed, 26 Feb 2003 17:34:34 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:17156 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S268851AbTBZWed>; Wed, 26 Feb 2003 17:34:33 -0500
Date: Wed, 26 Feb 2003 23:44:50 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: mem= option for broken bioses
Message-ID: <20030226224450.GD15455@atrey.karlin.mff.cuni.cz>
References: <F760B14C9561B941B89469F59BA3A8471380D7@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F760B14C9561B941B89469F59BA3A8471380D7@orsmsx401.jf.intel.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > From: Pavel Machek [mailto:pavel@ucw.cz] 
> > I've seen broken bios that did not mark acpi tables in e820
> > tables. This allows user to override it. Please apply,
> 
> OK, looks reasonable. Can you also gen up a patch documenting this in
> kernel-parameters.txt?

You can, assuming you took the patch ;-).

								Pavel

--- clean/Documentation/kernel-parameters.txt	2003-02-11 17:40:28.000000000 +0100
+++ linux/Documentation/kernel-parameters.txt	2003-02-26 23:43:21.000000000 +0100
@@ -516,6 +516,10 @@
 			[KNL,BOOT] Force usage of a specific region of memory
 			Region of memory to be used, from ss to ss+nn.
 
+	mem=nn[KMG]#ss[KMG]
+			[KNL,BOOT,ACPI] Mark specific memory as ACPI data.
+			Region of memory to be used, from ss to ss+nn.
+
 	mem=nopentium	[BUGS=IA-32] Disable usage of 4MB pages for kernel
 			memory.
 
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
