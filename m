Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262954AbVCDSqO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262954AbVCDSqO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 13:46:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262996AbVCDSm4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 13:42:56 -0500
Received: from [81.2.110.250] ([81.2.110.250]:41692 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S262972AbVCDSfq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 13:35:46 -0500
Subject: Re: RFD: Kernel release numbering
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, greg@kroah.com, jgarzik@pobox.com,
       davem@davemloft.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0503040959030.25732@ppc970.osdl.org>
References: <42268749.4010504@pobox.com>
	 <20050302200214.3e4f0015.davem@davemloft.net> <42268F93.6060504@pobox.com>
	 <4226969E.5020101@pobox.com> <20050302205826.523b9144.davem@davemloft.net>
	 <4226C235.1070609@pobox.com> <20050303080459.GA29235@kroah.com>
	 <4226CA7E.4090905@pobox.com>
	 <Pine.LNX.4.58.0503030750420.25732@ppc970.osdl.org>
	 <422751C1.7030607@pobox.com> <20050303181122.GB12103@kroah.com>
	 <20050303151752.00527ae7.akpm@osdl.org>
	 <1109894511.21781.73.camel@localhost.localdomain>
	 <20050303182820.46bd07a5.akpm@osdl.org>
	 <1109933804.26799.11.camel@localhost.localdomain>
	 <20050304032820.7e3cb06c.akpm@osdl.org>
	 <1109940685.26799.18.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0503040959030.25732@ppc970.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1109961228.29932.36.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 04 Mar 2005 18:33:52 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-03-04 at 18:18, Linus Torvalds wrote:
> Alan, I think your problem is that you really think that the tree _I_ want 
> is what _you_ want.

No I think you just misunderstood the point I was trying to make. They
are different trees and the difference is what stops you just doing the
layering Andrew seemed to think would work.

> I look at this from a _layering_ standpoint. Not from a "stable tree"  
> standpoint at all.

>From a layering perspective the .x.y.z kernel is a dead end fork each
2.x.y and that means it can and should make use of the ugly short term
fixes that solve problems.

> And that means that such a kernel would not get all patches that you'd 
> want. That's fine. That was never the aim of it. The _only_ point of this 
> kernel would be to have a baseline that nobody can disagree with.

Thats fine. It's a useful check, although it means we now have another
layer of obfuscation.

> In other words, it's not a "let's fix all serious bugs we can fix", but a 
> "this is the least common denominator that is basically acceptable to 
> everybody, regardless of what their objectives are".

Acceptable to whom ? Users want all the security issues fixed.

> So if you want to fix a security issue, and the fix is too big or invasive 
> or ugly for the "least common denominator" thing, then it simply does not 
> _go_ into that kernel. At that point, it goes into an -ac kernel, or into 
> my kernel, or into a vendor kernel. See?

If you put the corresponding "ugghh" fix into the 2.6.x.y sure. Thats
what I'm trying to say.

> So think of it as a piece in the puzzle, not the whole picture.

I think a lot of the folks who are using the 2.6 kernels and not using
vendor kernels have enough puzzles already 8)

Alan

