Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270013AbTHEThm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 15:37:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270609AbTHEThl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 15:37:41 -0400
Received: from fw.osdl.org ([65.172.181.6]:27864 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270013AbTHEThj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 15:37:39 -0400
Date: Tue, 5 Aug 2003 12:33:49 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: oxymoron@waste.org, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] automate patch names in kernel versions
Message-Id: <20030805123349.6a3db1f9.rddunlap@osdl.org>
In-Reply-To: <20030805191718.GC970@matchmail.com>
References: <20030729204419.GE6049@waste.org>
	<20030805191718.GC970@matchmail.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Aug 2003 12:17:18 -0700 Mike Fedyk <mfedyk@matchmail.com> wrote:

| On Tue, Jul 29, 2003 at 03:44:19PM -0500, Oliver Xymoron wrote:
| > Perhaps times have changed enough that I can revive this idea from a
| > few years ago:
| > 
| > http://groups.google.com/groups?q=patchname+oxymoron&hl=en&lr=&ie=UTF-8&selm=fa.jif8l5v.1b049jd%40ifi.uio.no&rnum=1
| > 
| > <quote year=1999>
| > This four-line patch provides a means for listing what patches have
| > been built into a kernel. This will help track non-standard kernel
| > versions, such as those released by Redhat, or Alan's ac series, etc.
| > more easily.
| > 
| > With this patch in place, each new patch can include a file of the
| > form "patchname.[identifier]" in the top level source directory and
| > [identifier] will then be added to the kernel version string. For
| > instance, Alan's ac patches could include a file named patchdesc.ac2
| > (containing a change log, perhaps), and the resulting kernel would be
| > identified as 2.2.0-pre6+ac2, both at boot and by uname.
| > 
| > This may prove especially useful for tracking problems with kernels
| > built by distribution packagers and problems reported by automated
| > tools.
| > </quote>
| > 
| > The patch now appends patches as -name rather than +name to avoid
| > issues that might exist with packaging tools and scripts.
| 
| Has anything happened with this patch?
| 
| I for one would love it to be merged.

I saved it, as you did too apparently.
Looks nice to me as well.

--
~Randy
