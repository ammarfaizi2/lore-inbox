Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262449AbVCCVcO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262449AbVCCVcO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 16:32:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262403AbVCCVay
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 16:30:54 -0500
Received: from warden3-p.diginsite.com ([208.147.64.186]:53157 "HELO
	warden3.diginsite.com") by vger.kernel.org with SMTP
	id S262525AbVCCVZa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 16:25:30 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       Greg KH <greg@kroah.com>, "David S. Miller" <davem@davemloft.net>,
       akpm@osdl.org, LKML <linux-kernel@vger.kernel.org>
Date: Thu, 3 Mar 2005 13:24:53 -0800 (PST)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: RFD: Kernel release numbering
In-Reply-To: <1109883750.591.47.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.62.0503031321140.29190@qynat.qvtvafvgr.pbz>
References: <42265A6F.8030609@pobox.com><20050302165830.0a74b85c.davem@davemloft.net>
 <422674A4.9080209@pobox.com><Pine.LNX.4.58.0503021932530.25732@ppc970.osdl.org><42268749.4010504@pobox.com>
 <20050302200214.3e4f0015.davem@davemloft.net><42268F93.6060504@pobox.com>
 <4226969E.5020101@pobox.com><20050302205826.523b9144.davem@davemloft.net>
 <4226C235.1070609@pobox.com><20050303080459.GA29235@kroah.com>
 <4226CA7E.4090905@pobox.com><Pine.LNX.4.58.0503030750420.25732@ppc970.osdl.org><422751C1.7030607@pobox.com><Pine.LNX.4.58.0503031022100.25732@ppc970.osdl.org>
 <1109883750.591.47.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Mar 2005, Steven Rostedt wrote:

> A couple of weeks ago I was at LinuxWorldExpo in Boston and was talking
> to several people about the stability of the 2.6 kernel.  Every one I
> talked to seemed to be nervous about using it.  Some did, and some did
> not and stayed with 2.4.  But each one had a different level of faith in
> which kernel to use.  The biggest complaint seems that 2.6 had taken up
> the MS SP approach to patches.  This patch fixes foo bug but with bar
> feature added, could introduce foo2 bug. So those I talked to really
> wanted a point where only fixes to real bugs were added with no extra
> features.
>
> Although it looks like Linus has decided to go with the 2.6.x.y scheme,
> I would like to say that it seems to be the perfect solution to those
> that I talked to.  If Linus wants to get as many people to test the
> lastest kernel, then this may help in that aspect. Some would choose the
> 2.6.x.0, with the excitement of the latest (but not so stable) kernel,
> others may wait till 2.6.x.>5, or some other number, or more likely,
> after some specified time frame.  But this allows different people to
> start testing the latest kernel when they feel comfortable with it.
>
> I would even recommend that the 2.6.x.0 be equivalent to the -rc2
> kernel. So if there's some feature that you would like, in 2.6.x,
> instead of asking for someone to back port it, you could just wait for
> 2.6.x.y where y is something you are comfortable with.  I'm sure people
> will still ask, but the rule would be to tell them NO.
>
> The problem with 2.4 / 2.5 was that there were features in 2.5 that
> people would want in 2.4 but couldn't wait a year for them. This method
> would allow that time to be shortened and new features won't take
> forever to get to a stable release.

I don't think you are understanding the proposal

2.6.11.y will be released as 2.6.12 is being developed.

once 2.6.12 is released (or shortly after that if 2.6.12 ends up being a 
_real_ mess) 2.6.11.y will not get any additional releases (2.6.12.y will 
get released instead)

as a result there will be no backports at all. if you want a feature 
that's introduced in 2.6.12 then you wait until you get a 2.6.12.y release 
that's good enough for you.

also I think the expectation is that there aren't going to be more then 
2-3 2.6.x.y releases so your comment of people waiting until y>5 won't 
apply

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
