Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265211AbTB0PIu>; Thu, 27 Feb 2003 10:08:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265242AbTB0PIu>; Thu, 27 Feb 2003 10:08:50 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:30736 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S265211AbTB0PIt>; Thu, 27 Feb 2003 10:08:49 -0500
Date: Thu, 27 Feb 2003 16:19:07 +0100
From: Pavel Machek <pavel@suse.cz>
To: Robert Woerle Paceblade/Support <robert@paceblade.com>
Cc: "Grover, Andrew" <andrew.grover@intel.com>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [ACPI] Re: mem= option for broken bioses
Message-ID: <20030227151907.GC12434@atrey.karlin.mff.cuni.cz>
References: <F760B14C9561B941B89469F59BA3A8471380D7@orsmsx401.jf.intel.com> <20030226224450.GD15455@atrey.karlin.mff.cuni.cz> <3E5E2061.2060807@paceblade.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E5E2061.2060807@paceblade.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>OK, looks reasonable. Can you also gen up a patch documenting this in
> >>kernel-parameters.txt?
> >>   
> >>
> >
> >You can, assuming you took the patch ;-).
> > 
> >
> well how can i find the correct value`s to put in ??

Well, similar method to how you use mem=123@456 parameters. You just
guess them. [Given kernel messages, it is actually quite easy.]


> >--- clean/Documentation/kernel-parameters.txt	2003-02-11 
> >17:40:28.000000000 +0100
> >+++ linux/Documentation/kernel-parameters.txt	2003-02-26 
> >23:43:21.000000000 +0100
> >@@ -516,6 +516,10 @@
> >			[KNL,BOOT] Force usage of a specific region of memory
> >			Region of memory to be used, from ss to ss+nn.
> >
> >+	mem=nn[KMG]#ss[KMG]
> >+			[KNL,BOOT,ACPI] Mark specific memory as ACPI data.
> >+			Region of memory to be used, from ss to ss+nn.
> >+
> >	mem=nopentium	[BUGS=IA-32] Disable usage of 4MB pages for kernel
> >			memory.
> >


-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
