Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262210AbVEYAp3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262210AbVEYAp3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 20:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262211AbVEYAp3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 20:45:29 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:57593 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262210AbVEYApW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 20:45:22 -0400
Subject: Re: RT patch acceptance
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: Bill Huey <bhuey@lnxw.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, sdietrich@mvista.com
In-Reply-To: <20050525001019.GA18048@nietzsche.lynx.com>
References: <20050524054722.GA6160@infradead.org>
	 <20050524064522.GA9385@elte.hu> <4292DFC3.3060108@yahoo.com.au>
	 <20050524081517.GA22205@elte.hu> <4292E559.3080302@yahoo.com.au>
	 <20050524090240.GA13129@elte.hu> <4292F074.7010104@yahoo.com.au>
	 <1116957953.31174.37.camel@dhcp153.mvista.com>
	 <20050524224157.GA17781@nietzsche.lynx.com>
	 <1116978244.19926.41.camel@dhcp153.mvista.com>
	 <20050525001019.GA18048@nietzsche.lynx.com>
Content-Type: text/plain
Organization: MontaVista
Date: Tue, 24 May 2005 17:45:13 -0700
Message-Id: <1116981913.19926.58.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-05-24 at 17:10 -0700, Bill Huey wrote:
> On Tue, May 24, 2005 at 04:44:04PM -0700, Daniel Walker wrote:
> > That's a good reason why it should be included. The maintainers know
> > that as developers there is no way for us to flush out all the bugs in
> > our code by ourselves. If the RT patch was added to -mm it would have
> > greatly increased coverage which , as you noted, is needed . Drivers
> > will break like mad , but no one but the community has all the hardware
> > for the drivers.
> 
> It's too premature at this time. There was a lot of work that went
> into the RT patch that I would have like for folks to have thought
> it through more carefully like RCU, the RT mutex itself, etc...
> All of it is very raw and most likely still is subject to rapid
> change.
> 

I think some of it is volatile still, but there are plenty of pieces
that could go in now. Threaded interrupts is up for discussion, this is
the reason why I started the thread. People appear to have specific
objections to that feature, which are still not clear.

Whole patch, no, small chunks yes. 

Daniel

