Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262758AbTJ3Si5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 13:38:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262760AbTJ3Si4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 13:38:56 -0500
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:8458 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262758AbTJ3Siz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 13:38:55 -0500
Date: Thu, 30 Oct 2003 18:38:46 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Ben Collins <bcollins@debian.org>
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [FBDEV UPDATE] Newer patch.
In-Reply-To: <20031023234552.GB554@phunnypharm.org>
Message-ID: <Pine.LNX.4.44.0310301833140.4560-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I noticed one thing, and that is that the mach64 used to use software
> cursor it seems (I remember wondering why atyfb_cursor was never used
> anywhere). It's now using the hw cursor.

Yeap. I'm in the process of getting several driver to use there hardware 
cursors.
 
> Also, I notice with this new code that the random vertical shifting of
> the console doesn't occur anymore like it does with current 2.6.0-test8
> code. For as long as I can remember 2.6.0-test, and way back into
> 2.5.5x, this has been a problem with highly active console programs
> (mutt, vim, etc...). Good to see it's going away :)

:-)

I have fixed the problems you have reported. I have a newer patch. Note 
this is updated with the LCD support. I like to see if the patch works on 
sparc. I has updates from the latest 2.4.X kernels. Please give it a try.

http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz

Let me know the results.




