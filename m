Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262656AbVCCXC2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262656AbVCCXC2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 18:02:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262535AbVCCXBV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 18:01:21 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:23233 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262663AbVCCWMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 17:12:24 -0500
Subject: Re: RFD: Kernel release numbering
From: Steven Rostedt <rostedt@goodmis.org>
To: David Lang <david.lang@digitalinsight.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       Greg KH <greg@kroah.com>, "David S. Miller" <davem@davemloft.net>,
       akpm@osdl.org, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.62.0503031349470.29190@qynat.qvtvafvgr.pbz>
References: <42265A6F.8030609@pobox.com>
	 <20050302165830.0a74b85c.davem@davemloft.net> <422674A4.9080209@pobox.com>
	 <Pine.LNX.4.58.0503021932530.25732@ppc970.osdl.org>
	 <42268749.4010504@pobox.com> <20050302200214.3e4f0015.davem@davemloft.net>
	 <42268F93.6060504@pobox.com> <4226969E.5020101@pobox.com>
	 <20050302205826.523b9144.davem@davemloft.net> <4226C235.1070609@pobox.com>
	 <20050303080459.GA29235@kroah.com> <4226CA7E.4090905@pobox.com>
	 <Pine.LNX.4.58.0503030750420.25732@ppc970.osdl.org>
	 <422751C1.7030607@pobox.com>
	 <Pine.LNX.4.58.0503031022100.25732@ppc970.osdl.org>
	 <1109883750.591.47.camel@localhost.localdomain>
	 <Pine.LNX.4.62.0503031321140.29190@qynat.qvtvafvgr.pbz>
	 <1109886108.591.58.camel@localhost.localdomain>
	 <Pine.LNX.4.62.0503031349470.29190@qynat.qvtvafvgr.pbz>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Thu, 03 Mar 2005 17:12:02 -0500
Message-Id: <1109887922.591.84.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-03-03 at 13:53 -0800, David Lang wrote:

> > Actually, the >5 was pretty pointless anyway.  What I got
> > from talking to people is that they wanted a release that only got fixes
> > that would crash the machine, or cause a root exploit. That's what I
> > thought Linus was trying to say.
> 
> the trouble is that 'crash the machine' can include a HUGE number of the 
> fixes that go into 2.6.x+1 and you just lost stability again

Point taken.

Actually, I believe that you would satisfy a lot of people, just if they
know that trivial, or smaller fixes are included in the release.  If a
large change is needed, then those people waiting for a stable product
would have to wait till the release that included the big change was at
a point that was acceptable to them.

What I've heard is that people are nervous about updating a kernel for a
small fix, but must also get other features that they don't need and may
introduce more bugs.

Some IT folks I've talked to are more concerned about the security of
the system than the stability.  They can feel more comfortable when they
see a machine stay up a long time, but there can be security problems
that they can't see. They don't want anything else but the fix when one
is discovered.  Grant you that these are usually few and far between,
but this is what I've been told. Of course these people stick to a
distributor for the updates, but it would be nice to have this
capability in the kernel, for those like myself (and why I state this)
that like to tinker with the kernel, and don't use the distro's version.

-- Steve


