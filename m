Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262526AbVCCVJ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262526AbVCCVJ5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 16:09:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262595AbVCCVF1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 16:05:27 -0500
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:39063 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262589AbVCCVDA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 16:03:00 -0500
Subject: Re: RFD: Kernel release numbering
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Greg KH <greg@kroah.com>,
       "David S. Miller" <davem@davemloft.net>, akpm@osdl.org,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0503031022100.25732@ppc970.osdl.org>
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
Content-Type: text/plain
Organization: Kihon Technologies
Date: Thu, 03 Mar 2005 16:02:30 -0500
Message-Id: <1109883750.591.47.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A couple of weeks ago I was at LinuxWorldExpo in Boston and was talking
to several people about the stability of the 2.6 kernel.  Every one I
talked to seemed to be nervous about using it.  Some did, and some did
not and stayed with 2.4.  But each one had a different level of faith in
which kernel to use.  The biggest complaint seems that 2.6 had taken up
the MS SP approach to patches.  This patch fixes foo bug but with bar
feature added, could introduce foo2 bug. So those I talked to really
wanted a point where only fixes to real bugs were added with no extra
features.

Although it looks like Linus has decided to go with the 2.6.x.y scheme,
I would like to say that it seems to be the perfect solution to those
that I talked to.  If Linus wants to get as many people to test the
lastest kernel, then this may help in that aspect. Some would choose the
2.6.x.0, with the excitement of the latest (but not so stable) kernel,
others may wait till 2.6.x.>5, or some other number, or more likely,
after some specified time frame.  But this allows different people to
start testing the latest kernel when they feel comfortable with it.

I would even recommend that the 2.6.x.0 be equivalent to the -rc2
kernel. So if there's some feature that you would like, in 2.6.x,
instead of asking for someone to back port it, you could just wait for
2.6.x.y where y is something you are comfortable with.  I'm sure people
will still ask, but the rule would be to tell them NO. 

The problem with 2.4 / 2.5 was that there were features in 2.5 that
people would want in 2.4 but couldn't wait a year for them. This method
would allow that time to be shortened and new features won't take
forever to get to a stable release.

So kudos to Greg. I hope that everyone supports his efforts and fights
against anyone that suggests a non essential bug fix to go into a
2.6.x.y branch. 

I know lots of people (including myself) that only use the vanilla
kernel, and never the kernel that comes from the distributor. So I hope
this helps us.  Unfortunately, I have a NVidia card, which seldom works
with the latest kernels, so I don't get to test as often as I would
like, unless I sacrifice 3D graphics.

Cheers,

-- Steve


