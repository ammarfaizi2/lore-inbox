Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264318AbTLFAIb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 19:08:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264368AbTLFAIb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 19:08:31 -0500
Received: from slider.rack66.net ([212.3.252.135]:21417 "EHLO
	slider.rack66.net") by vger.kernel.org with ESMTP id S264318AbTLFAIV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 19:08:21 -0500
Date: Sat, 6 Dec 2003 01:08:19 +0100
From: Filip Van Raemdonck <filipvr@xs4all.be>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux GPL and binary module exception clause?
Message-ID: <20031206000819.GA6757@debian>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20031205195609.GA30309@debian> <000301c3bb6e$16cf8000$d43147ab@amer.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000301c3bb6e$16cf8000$d43147ab@amer.cisco.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 05, 2003 at 12:26:39PM -0800, Hua Zhong wrote:
> > 
> > "Once you build a binary module, it contains our (inlined) 
> > code and thus the binary module is a derived work."
> 
> Understood and that's what we disagree.
> 
> By the way, what's so different between code and data, anyway?

For one, as long as it's code, you are clearly the only copyright holder
and you can more or less do what you want (including distributing).[1]
Once compiled it includes object code to which others have copyright, so
you must take care not to violate their rights.

> > > Otherwise, since SCO found a few lines of code copied from 
> > Unix in Linux
> > > source, are we saying the whole million lines of code is 
> > derived from
> > > Unix?
> > 
> > We have yet to see if they actually found code.
> 
> We have. Some malloc function as I remember, and has been removed from
> current Linux sources.

Which was OK to include as it was released previously under a BSD license.

But, to answer the "million lines of code" question: most of that code was
written before that inclusion. And may not even have had anything to do
with the included lines, afterward. So, no, that does not make all of it
(in code form) a derived work.

There may or may not have been developed code related to these lines
afterwards, for which one might argue that that part of the code is a
derived work. It mostly depends on how badly the later code needs the
included lines - but not much I guess since these lines are not even there
anymore.

> > And no; we're not saying all code is a derived work. We're 
> > saying that if there is a few lines of copied code, then the 
> > compiled kernel which contains object code coming from 
> > these lines is a derived work. If. 
> 
> Binary modules do not _contain_ copyrighted (GPL'ed) code, they merely
> _include_ it (by #inlucde), but the _compiled_ binary modules contain
> compiled copyrighted (GPL'ed) code.
> 
> So you are saying, binary modules contain compiled GPL'ed code, so it's
> derived work of GPL'ed code. But kernel sources contained copyrighted
> (non-GPL'ed) code, but the sources were not derived work of that code,
> only the compiled form was?

Binary modules are by their very nature already compiled, so they already
include the GPLed object code.

And the aggregate kernel sources with the ancient unix code included is
indeed a derived work. But the kernel source, apart from that ancient
unix code and which does not need it, is not.

Neither is the source code for binary modules, as long as it doesn't
actually contain kernel code itself. But once compiled, the rules of the
game are set.


Regards,

Filip

[1] Depending on how the code looks. For example, if it needs to patch
    kernel source code it is modifying GPLed code, and in that case it is
    a derived work even in source code form.

-- 
Hardware, n.:
	The parts of a computer system that can be kicked.
