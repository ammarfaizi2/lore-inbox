Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261474AbUH0JsX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbUH0JsX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 05:48:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261451AbUH0JsX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 05:48:23 -0400
Received: from jib.isi.edu ([128.9.128.193]:63108 "EHLO jib.isi.edu")
	by vger.kernel.org with ESMTP id S261474AbUH0JsV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 05:48:21 -0400
Date: Fri, 27 Aug 2004 02:48:09 -0700
From: Craig Milo Rogers <rogers@isi.edu>
To: Christoph Hellwig <hch@infradead.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Termination of the Philips Webcam Driver (pwc)
Message-ID: <20040827094809.GL1284@isi.edu>
References: <20040826233244.GA1284@isi.edu> <20040827004757.A26095@infradead.org> <Pine.LNX.4.58.0408261700320.2304@ppc970.osdl.org> <20040827094346.B29407@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040827094346.B29407@infradead.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.08.27, Christoph Hellwig wrote:
> On Thu, Aug 26, 2004 at 05:03:42PM -0700, Linus Torvalds wrote:
> > Of course if some new maintainer shows up and decides to infer how the 
> > device worked by looking at the original open-source code, that's also 
> > clearly fine.
> > 
> > I don't want people to play lawyer. Honoring peoples rights to the code 
> > they write is more important than just the law.
> 
> Umm, just because he's piised off we shouldn't removed support for hardware.
> it's not like the driver suddenly stops from working because it's unmaintained.

	Bit rot does occur in unmaintained Linux kernel drivers; I
believe I've seen it happen.  More immediately, though, is that the
driver suddenly stops working (in effect) for new users who can no
acquire a copy of the proprietary codec module, pwcx.  Without pcwx,
my brand new Logitech Web cameras are likely to be seriously crippled.
I didn't get a copy of pcwx before the website that distributed it
shut off access.

	I'm seriously considering offering Nemosoft money for a
licence for pwcx.  Of course, I'd need seperate copies for x86 and
x86_64 architectures...  Economic rationality rears its ugly head:
the overhead costs might be too high.

					Craig Milo Rogers
