Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269623AbTHETRY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 15:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269628AbTHETRY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 15:17:24 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:12816
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S269623AbTHETRX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 15:17:23 -0400
Date: Tue, 5 Aug 2003 12:17:18 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Oliver Xymoron <oxymoron@waste.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] automate patch names in kernel versions
Message-ID: <20030805191718.GC970@matchmail.com>
Mail-Followup-To: Oliver Xymoron <oxymoron@waste.org>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20030729204419.GE6049@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030729204419.GE6049@waste.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 29, 2003 at 03:44:19PM -0500, Oliver Xymoron wrote:
> Perhaps times have changed enough that I can revive this idea from a
> few years ago:
> 
> http://groups.google.com/groups?q=patchname+oxymoron&hl=en&lr=&ie=UTF-8&selm=fa.jif8l5v.1b049jd%40ifi.uio.no&rnum=1
> 
> <quote year=1999>
> This four-line patch provides a means for listing what patches have
> been built into a kernel. This will help track non-standard kernel
> versions, such as those released by Redhat, or Alan's ac series, etc.
> more easily.
> 
> With this patch in place, each new patch can include a file of the
> form "patchname.[identifier]" in the top level source directory and
> [identifier] will then be added to the kernel version string. For
> instance, Alan's ac patches could include a file named patchdesc.ac2
> (containing a change log, perhaps), and the resulting kernel would be
> identified as 2.2.0-pre6+ac2, both at boot and by uname.
> 
> This may prove especially useful for tracking problems with kernels
> built by distribution packagers and problems reported by automated
> tools.
> </quote>
> 
> The patch now appends patches as -name rather than +name to avoid
> issues that might exist with packaging tools and scripts.

Has anything happened with this patch?

I for one would love it to be merged.
