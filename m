Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262991AbVCDTG3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262991AbVCDTG3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 14:06:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263004AbVCDTBW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 14:01:22 -0500
Received: from fire.osdl.org ([65.172.181.4]:26079 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262997AbVCDS7I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 13:59:08 -0500
Message-ID: <4228B02A.8010202@osdl.org>
Date: Fri, 04 Mar 2005 10:59:54 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Linus Torvalds <torvalds@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andrew Morton <akpm@osdl.org>, jgarzik@pobox.com, davem@davemloft.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFD: Kernel release numbering
References: <422751C1.7030607@pobox.com> <20050303181122.GB12103@kroah.com> <20050303151752.00527ae7.akpm@osdl.org> <1109894511.21781.73.camel@localhost.localdomain> <20050303182820.46bd07a5.akpm@osdl.org> <1109933804.26799.11.camel@localhost.localdomain> <20050304032820.7e3cb06c.akpm@osdl.org> <1109940685.26799.18.camel@localhost.localdomain> <Pine.LNX.4.58.0503040959030.25732@ppc970.osdl.org> <Pine.LNX.4.58.0503041020130.25732@ppc970.osdl.org> <20050304183804.GB29857@kroah.com>
In-Reply-To: <20050304183804.GB29857@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Fri, Mar 04, 2005 at 10:27:37AM -0800, Linus Torvalds wrote:
> 
>>Btw, I also think that this means that the sucker-tree should never aim to 
>>be a "2.6.x.y" kind of release tree. If we do a "2.6.x.y" release, the 
>>sucker tree would be _included_ in that release (and it may indeed be all 
>>of it - most of the time it probably would be), but we should not assume 
>>that "2.6.x.y" _has_ to be just the sucker tree.
> 
> 
> Ah crap, I just called the first release of such a tree, 2.6.11.1.

Darn, I thought that we were converging to that also....
unless we can get back to -pre and -rc naming.

> 
>>We might want to release a "2.6.x.y" that contains a patch that is too big
>>or too intrusive (or otherwise controversial) to really be valid in the
>>sucker-tree.
> 
> 
> Are you sure we would ever do that?  We never have before...
> 
> I think we should call it the 2.6.x.y tree, as that way users can easily
> understand it.  They see it and say, "Ah look, it's 2.6.x with only
> real bugfixes in it."  It's very simple to explain to others.
> 
> And if you disagree, what _should_ we call it?  "-sucker" isn't good, as
> it only describes the people creating the tree, not any of the users :)

-fixup or -fixes maybe.  x.y is OK too.  :)

Can/will/should it also include *required* (showstopper) build fixes,
if there are any of those?

-- 
~Randy
