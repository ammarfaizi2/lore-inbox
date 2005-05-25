Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262161AbVEYAFq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262161AbVEYAFq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 20:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262174AbVEYAFq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 20:05:46 -0400
Received: from smtp.lnxw.com ([207.21.185.24]:52485 "EHLO smtp.lnxw.com")
	by vger.kernel.org with ESMTP id S262169AbVEYAFk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 20:05:40 -0400
Date: Tue, 24 May 2005 17:10:19 -0700
To: Daniel Walker <dwalker@mvista.com>
Cc: Bill Huey <bhuey@lnxw.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Ingo Molnar <mingo@elte.hu>, Christoph Hellwig <hch@infradead.org>,
       linux-kernel@vger.kernel.org, akpm@osdl.org, sdietrich@mvista.com
Subject: Re: RT patch acceptance
Message-ID: <20050525001019.GA18048@nietzsche.lynx.com>
References: <20050524054722.GA6160@infradead.org> <20050524064522.GA9385@elte.hu> <4292DFC3.3060108@yahoo.com.au> <20050524081517.GA22205@elte.hu> <4292E559.3080302@yahoo.com.au> <20050524090240.GA13129@elte.hu> <4292F074.7010104@yahoo.com.au> <1116957953.31174.37.camel@dhcp153.mvista.com> <20050524224157.GA17781@nietzsche.lynx.com> <1116978244.19926.41.camel@dhcp153.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1116978244.19926.41.camel@dhcp153.mvista.com>
User-Agent: Mutt/1.5.9i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2005 at 04:44:04PM -0700, Daniel Walker wrote:
> That's a good reason why it should be included. The maintainers know
> that as developers there is no way for us to flush out all the bugs in
> our code by ourselves. If the RT patch was added to -mm it would have
> greatly increased coverage which , as you noted, is needed . Drivers
> will break like mad , but no one but the community has all the hardware
> for the drivers.

It's too premature at this time. There was a lot of work that went
into the RT patch that I would have like for folks to have thought
it through more carefully like RCU, the RT mutex itself, etc...
All of it is very raw and most likely still is subject to rapid
change.

It conflicts with the sched domain and RCU changes at this time
so integration with -mm is highly problematic. -mm is too massive
as is for anything like the RT patch to go in. I've already tried
merging these trees in usig Monotone as my backing SCM and came
to this conclusion.

I consider the RT patch to be for front line folks only at this
time. Give it another 6 months or so since people are having enough
problems with 2.6.11.x

bill
