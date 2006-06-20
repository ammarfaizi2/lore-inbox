Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750858AbWFTUCp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750858AbWFTUCp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 16:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750861AbWFTUCp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 16:02:45 -0400
Received: from nz-out-0102.google.com ([64.233.162.207]:40678 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750857AbWFTUCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 16:02:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=CwZnEWwP2yLtC3tUbVqpTB0lyVedQU2Gzcj6hM44fg9MFKCOCBD+nwZhTg7pUcnqaSraj9ONfGql8fWppeajRv2fgu/EeRB+r+/YQmRh7JqXma1K6p/fJ1rcoApok6lAAuSo4vgJxTzGFGHIDbHgdyNywBVwjV7BKP3gQ78Gcj8=
Message-ID: <161717d50606201302o7b13a436wc733c522611b5531@mail.gmail.com>
Date: Tue, 20 Jun 2006 16:02:43 -0400
From: "Dave Neuer" <mr.fred.smoothie@pobox.com>
To: "Stefan Richter" <stefanr@s5r6.in-berlin.de>,
       "Linus Torvalds" <torvalds@osdl.org>, "Al Viro" <viro@ftp.linux.org.uk>,
       linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
       "Ben Collins" <bcollins@ubuntu.com>,
       "Jody McIntyre" <scjody@modernduck.com>,
       "Andrew Morton" <akpm@osdl.org>
Subject: Re: [git pull] ieee1394 tree for 2.6.18
In-Reply-To: <20060620193422.GA10748@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <44954102.3090901@s5r6.in-berlin.de>
	 <Pine.LNX.4.64.0606191902350.5498@g5.osdl.org>
	 <20060620025552.GO27946@ftp.linux.org.uk>
	 <Pine.LNX.4.64.0606192007460.5498@g5.osdl.org>
	 <20060620175321.GA7463@flint.arm.linux.org.uk>
	 <44984CA1.5010308@s5r6.in-berlin.de>
	 <20060620193422.GA10748@flint.arm.linux.org.uk>
X-Google-Sender-Auth: 1b0f9cda4c2503a2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/20/06, Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> On Tue, Jun 20, 2006 at 09:29:37PM +0200, Stefan Richter wrote:
> > Russell King wrote:
> > >On Mon, Jun 19, 2006 at 08:14:45PM -0700, Linus Torvalds wrote:
> > >>I want them to tell me what they are sending, so that _when_ I pull, I
> > >>can line up the result of that pull with the mail they sent, and I can
> > >>tell "ok, that's actually what the other side intended".
> > >
> > >Given that you've complained about me sending daily pull requests
> > >already, how do you intend folk to handle the situation where they've
> > >sent you a pull request, it's apparantly been ignored, and they update
> > >the tree from which you pull (maybe for akpm's benefit) and then you
> > >eventually get around to pulling it a couple of days later?
> > [...]
> >
> > I don't maintain git repos myself, but I'd say _branches_ or something
> > like that might be the way to go.
>
> The point was to try to establish when we could consider the tree from
> which we'd asked Linus to pull from as being sufficiently old that it
> would not be pulled from without another request being sent - or if it
> was pulled from, that we wouldn't get an email from Linus about the fact
> there was new stuff in there.

Can git pull a tag?

Dave
