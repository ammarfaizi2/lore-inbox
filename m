Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266485AbUA2Xnm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 18:43:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266291AbUA2Xnm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 18:43:42 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:46570 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id S266485AbUA2Xnk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 18:43:40 -0500
Date: Fri, 30 Jan 2004 00:43:36 +0100
From: David Weinehall <tao@acc.umu.se>
To: Tim Hockin <thockin@hockin.org>
Cc: Andries Brouwer <aebr@win.tue.nl>, Matt Mackall <mpm@selenic.com>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Lindent fixed to match reality
Message-ID: <20040129234336.GQ16675@khan.acc.umu.se>
Mail-Followup-To: Tim Hockin <thockin@hockin.org>,
	Andries Brouwer <aebr@win.tue.nl>, Matt Mackall <mpm@selenic.com>,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20040129193727.GJ21888@waste.org> <20040129201556.GK16675@khan.acc.umu.se> <20040129233730.A19497@pclin040.win.tue.nl> <20040129225456.GM16675@khan.acc.umu.se> <20040129231724.GA814@hockin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040129231724.GA814@hockin.org>
User-Agent: Mutt/1.4.1i
X-Accept-Language: Swedish, English
X-GPG-Fingerprint: 7ACE 0FB0 7A74 F994 9B36  E1D1 D14E 8526 DC47 CA16
X-GPG-Key: http://www.acc.umu.se/~tao/files/pubkey_dc47ca16.gpg.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 29, 2004 at 03:17:24PM -0800, Tim Hockin wrote:

[snip]
> No, you're building a straw man.  Everyone knows that you should always use
> the parens on sizeof().  Just because you CAN leave them out SOMETIMES does
> not mean you SHOULD.

"Everyone" also sprinkles far too many parenthesis for their own code,
just to be sure.  I've seen code such as

a = b * c + 1;

written as

a = ((b * c) + 1);
 
The question is rather, why should you insert superfluous parenthesis
when they do no semantic difference, and do not improve readability in
any way?  If you get paid by the byte, then sure, but I don't, so I
won't...

[snip]

As mentioned earlier, if mister divine Pee-sprinkler decides that the
CodingStyle for 2.6 should be without the space for sizeof/typeof, then
I'll follow the leader when/if sending patches to the 2.6 kernel.
2.0 will still have the spaces in place, though.


Regards: David Weinehall
-- 
 /) David Weinehall <tao@acc.umu.se> /) Northern lights wander      (\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\)  http://www.acc.umu.se/~tao/    (/   Full colour fire           (/
