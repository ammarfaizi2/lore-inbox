Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262790AbVBYWsw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262790AbVBYWsw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 17:48:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262791AbVBYWsv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 17:48:51 -0500
Received: from fire.osdl.org ([65.172.181.4]:63915 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262790AbVBYWsd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 17:48:33 -0500
Date: Fri, 25 Feb 2005 14:49:05 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Paulo Marques <pmarques@grupopie.com>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       Sam Ravnborg <sam@ravnborg.org>
Subject: Re: ARM undefined symbols.  Again.
In-Reply-To: <20050225222720.D27842@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.58.0502251444590.9237@ppc970.osdl.org>
References: <20050207114359.A32277@flint.arm.linux.org.uk>
 <20050208194243.GA8505@mars.ravnborg.org> <20050208200501.B3544@flint.arm.linux.org.uk>
 <20050209104053.A31869@flint.arm.linux.org.uk> <20050213172940.A12469@flint.arm.linux.org.uk>
 <4210A345.6030304@grupopie.com> <20050225194823.A27842@flint.arm.linux.org.uk>
 <Pine.LNX.4.58.0502251158280.9237@ppc970.osdl.org> <20050225202349.C27842@flint.arm.linux.org.uk>
 <Pine.LNX.4.58.0502251227480.9237@ppc970.osdl.org> <20050225222720.D27842@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 25 Feb 2005, Russell King wrote:
> 
> That's fine until you consider the wide number of machines for ARM,
> any of which could have this problem.

Fair enough. "ARM" doesn't end up being just one architecture, and that's 
a good point.

> Unless of course, you believe that one person should carry everything,
> which is what I feel your above comment is effectively saying.

No, let me be the last to argue for centralized Q&A. Doesn't work. I'd
rather argue that it's not an issue of trying to get everybody to upgrade
and making old versions "not supported". It seems more benign than that,
in that it should be sufficient if there were just enough new versions out
there, for some arbitrary value of "enough".

In particular, it seems downright _wrong_ that an issue like this has been 
around forever, and nothing has actually been done about the fundamental 
problem. At some point, "kernel build bandages" are just not worth it any 
more, if people aren't even trying to actually fix the real issue.

And one year of apparently "no progress" smells. Bad.

		Linus
