Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266457AbUHaDjx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266457AbUHaDjx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 23:39:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266459AbUHaDjx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 23:39:53 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:24752 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S266457AbUHaDjw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 23:39:52 -0400
Date: Mon, 30 Aug 2004 23:39:50 -0400
From: Tom Vier <tmv@comcast.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040831033950.GA32404@zero>
Reply-To: Tom Vier <tmv@comcast.net>
References: <20040825163225.4441cfdd.akpm@osdl.org> <20040825233739.GP10907@legion.cup.hp.com> <20040825234629.GF2612@wiggy.net> <1093480940.2748.35.camel@entropy> <20040826044425.GL5414@waste.org> <1093496948.2748.69.camel@entropy> <20040826053200.GU31237@waste.org> <20040826075348.GT1284@nysv.org> <20040826163234.GA9047@delft.aura.cs.cmu.edu> <Pine.LNX.4.58.0408260936550.2304@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408260936550.2304@ppc970.osdl.org>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2004 at 09:48:04AM -0700, Linus Torvalds wrote:
>  - safely synchronize globally visible data structures
> That's quite fundamental. 99% of what a kernel does is exactly that. TCP
> would be in user space too, if it wasn't for _exactly_ this issue. A lot

What about microkernels? They do tcp in userspace. So did winsock, iirc. As
long as a trusted process keeps data such as free ports, what's the problem?
Perhaps a process could even simply hand off proto:port handles and let a
library do the rest, but i know little about exokernels. (There's probably
some catches.)

-- 
Tom Vier <tmv@comcast.net>
DSA Key ID 0x15741ECE
