Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261173AbULZWNl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261173AbULZWNl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 17:13:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261174AbULZWNl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 17:13:41 -0500
Received: from ds01.webmacher.de ([213.239.192.226]:19603 "EHLO
	ds01.webmacher.de") by vger.kernel.org with ESMTP id S261173AbULZWMg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 17:12:36 -0500
In-Reply-To: <1104093456.16487.0.camel@localhost.localdomain>
References: <200412250121_MC3-1-91AF-7FBB@compuserve.com> <20041226011222.GA1896@work.bitmover.com> <20041226030957.GA8512@work.bitmover.com> <yw1x7jn5bbj1.fsf@inprovide.com> <20041226160205.GB26574@work.bitmover.com> <yw1xmzw19bnn.fsf@inprovide.com> <20041226181837.GA28786@work.bitmover.com> <1104093456.16487.0.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <3ECEAB02-578B-11D9-BCB8-000A95E3BCE4@dalecki.de>
Content-Transfer-Encoding: 7bit
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       M?ns Rullg?rd <mru@inprovide.com>, Larry McVoy <lm@bitmover.com>
From: Martin Dalecki <martin@dalecki.de>
Subject: Re: lease.openlogging.org is unreachable
Date: Sun, 26 Dec 2004 23:12:34 +0100
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2004-12-26, at 21:37, Alan Cox wrote:

> On Sul, 2004-12-26 at 18:18, Larry McVoy wrote:
>> The other answer, which I'm happy to consider, is to come up with a 
>> unique
>> id on a per host basis and use that for the leases.  That's not a fun 
>> task,
>> does anyone have code (BSD license please) which does that?
>
> libuuid does that on straight statistical probability - what properties
> do you want your id to have ?
>

Simply storing the first hostname used in a dot file for subsequent 
reuse on client side,
would be even easier I guess. That would be basically the same strategy 
as used by
ssh with regard to host keys. It wouldn't even perhaps make protocol 
changes necessary.
But still not a perfect solution... (Remember the times you have delete 
something from
.ssh/known_hosts).

