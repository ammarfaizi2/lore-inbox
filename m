Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131718AbRCUSoY>; Wed, 21 Mar 2001 13:44:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131722AbRCUSoO>; Wed, 21 Mar 2001 13:44:14 -0500
Received: from 069up090.chartermi.net ([24.247.69.90]:52864 "EHLO
	oof.netnation.com") by vger.kernel.org with ESMTP
	id <S131718AbRCUSn7>; Wed, 21 Mar 2001 13:43:59 -0500
Date: Wed, 21 Mar 2001 13:43:10 -0500
From: Simon Kirby <sim@netnation.com>
To: linux-kernel@vger.kernel.org
Subject: Re: LDT allocated for cloned task!
Message-ID: <20010321134310.A2463@netnation.com>
In-Reply-To: <Pine.LNX.4.33.0103201745080.1701-100000@pau.intranet.ct> <9983m2$1l5$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <9983m2$1l5$1@penguin.transmeta.com>; from torvalds@transmeta.com on Tue, Mar 20, 2001 at 09:23:14AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 20, 2001 at 09:23:14AM -0800, Linus Torvalds wrote:

> It's harmless.
> 
> It's really a warning that says: the mm that you allocated a new LDT for
> may have multiple users, and while the LDT is added to all of them, we
> don't guarantee _when_ the other users will actually see the LDT.
> 
> It so happens that the other users are probably just something like
> "top" or similar, that increment the MM count to make sure that the MM
> doesn't go away while they get information about the process. And those
> users don't care about the LDT in the least.

xmms with the xmms-avi (or avi-xmms?) plugin reproduces the message each
and every time xmms starts up.

Simon-

[  Stormix Technologies Inc.  ][  NetNation Communications Inc. ]
[       sim@stormix.com       ][       sim@netnation.com        ]
[ Opinions expressed are not necessarily those of my employers. ]
