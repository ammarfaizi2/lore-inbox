Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267326AbUH0S5b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267326AbUH0S5b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 14:57:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267287AbUH0S50
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 14:57:26 -0400
Received: from jib.isi.edu ([128.9.128.193]:6791 "EHLO jib.isi.edu")
	by vger.kernel.org with ESMTP id S267313AbUH0Szx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 14:55:53 -0400
Date: Fri, 27 Aug 2004 11:55:41 -0700
From: Craig Milo Rogers <rogers@isi.edu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Xavier Bestel <xavier.bestel@free.fr>,
       Christoph Hellwig <hch@infradead.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       webcam@smcc.demon.nl
Subject: Re: Termination of the Philips Webcam Driver (pwc)
Message-ID: <20040827185541.GC24018@isi.edu>
References: <20040826233244.GA1284@isi.edu> <20040827004757.A26095@infradead.org> <Pine.LNX.4.58.0408261700320.2304@ppc970.osdl.org> <20040827094346.B29407@infradead.org> <Pine.LNX.4.58.0408271027060.14196@ppc970.osdl.org> <1093628254.15313.14.camel@gonzales> <Pine.LNX.4.58.0408271106330.14196@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408271106330.14196@ppc970.osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.08.27, Linus Torvalds wrote:
> But Greg is right - we don't keep hooks that are there purely for binary
> drivers. If somebody wants a binary driver, it had better be a whole
> independent thing - and it won't be distributed with the kernel.

	If you read Nemosoft's final driver release (which has been
reposted, and of which I now have a copy), you can see that he was
rewriting his code to move the proprietary codecs out of the kernel
entirely, and into user-mode libraries to be linked with consenting
applications -- he was quite sensitive to the kernel issues involved.
Of course, this is still nowhere as good as a wholly open source
solution, a position with which I think Nemosoft concurs, based on his
messages.

	Linus, would you adress a moot issue, please?  If Nemosoft (or
someone else) were to release some of the codecs in question as one or
more open-source loadable kernel modules (similar to sound card
support modules in the ALSA system), while other codecs remain
binary-only loadable kernel modules (distributed outside the kernel,
but using the same hook as the open-source loadable modules), would
the pwc driver and codec extension hook be allowable, in your opinion,
please?

					Craig Milo Rogers
