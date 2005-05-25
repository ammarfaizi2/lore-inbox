Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262187AbVEYAc2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262187AbVEYAc2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 20:32:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262191AbVEYAc1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 20:32:27 -0400
Received: from relay02.pair.com ([209.68.5.16]:14862 "HELO relay02.pair.com")
	by vger.kernel.org with SMTP id S262187AbVEYAcW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 20:32:22 -0400
X-pair-Authenticated: 24.241.238.70
Message-ID: <4293C794.6000105@cybsft.com>
Date: Tue, 24 May 2005 19:32:20 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Bill Huey (hui)" <bhuey@lnxw.com>
CC: Daniel Walker <dwalker@mvista.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Ingo Molnar <mingo@elte.hu>, Christoph Hellwig <hch@infradead.org>,
       linux-kernel@vger.kernel.org, akpm@osdl.org, sdietrich@mvista.com
Subject: Re: RT patch acceptance
References: <20050524054722.GA6160@infradead.org> <20050524064522.GA9385@elte.hu> <4292DFC3.3060108@yahoo.com.au> <20050524081517.GA22205@elte.hu> <4292E559.3080302@yahoo.com.au> <20050524090240.GA13129@elte.hu> <4292F074.7010104@yahoo.com.au> <1116957953.31174.37.camel@dhcp153.mvista.com> <20050524224157.GA17781@nietzsche.lynx.com> <1116978244.19926.41.camel@dhcp153.mvista.com> <20050525001019.GA18048@nietzsche.lynx.com>
In-Reply-To: <20050525001019.GA18048@nietzsche.lynx.com>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Huey (hui) wrote:
> On Tue, May 24, 2005 at 04:44:04PM -0700, Daniel Walker wrote:
> 
>>That's a good reason why it should be included. The maintainers know
>>that as developers there is no way for us to flush out all the bugs in
>>our code by ourselves. If the RT patch was added to -mm it would have
>>greatly increased coverage which , as you noted, is needed . Drivers
>>will break like mad , but no one but the community has all the hardware
>>for the drivers.
> 
> 
> It's too premature at this time. There was a lot of work that went
> into the RT patch that I would have like for folks to have thought
> it through more carefully like RCU, the RT mutex itself, etc...
> All of it is very raw and most likely still is subject to rapid
> change.
> 
> It conflicts with the sched domain and RCU changes at this time
> so integration with -mm is highly problematic. -mm is too massive
> as is for anything like the RT patch to go in. I've already tried
> merging these trees in usig Monotone as my backing SCM and came
> to this conclusion.
> 
> I consider the RT patch to be for front line folks only at this
> time. Give it another 6 months or so since people are having enough
> problems with 2.6.11.x
> 
> bill

The only question I would ask of you is this: What will be different in
6 months? The patch may be a bit different, it may be a lot different.
However, it probably won't be that much more rung out than it is today
until more people start beating on it. This probably won't happen until
it is merged. :-)

-- 
   kr
