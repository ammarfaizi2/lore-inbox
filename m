Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261407AbUL0AE0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261407AbUL0AE0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 19:04:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261415AbUL0AEZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 19:04:25 -0500
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:32388 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S261407AbUL0AEW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 19:04:22 -0500
Date: Sun, 26 Dec 2004 16:03:38 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Martin Dalecki <martin@dalecki.de>
Cc: Florian Weimer <fw@deneb.enyo.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       M?ns Rullg?rd <mru@inprovide.com>, Larry McVoy <lm@bitmover.com>
Subject: Re: lease.openlogging.org is unreachable
Message-ID: <20041227000338.GC29854@taniwha.stupidest.org>
References: <20041226011222.GA1896@work.bitmover.com> <20041226030957.GA8512@work.bitmover.com> <yw1x7jn5bbj1.fsf@inprovide.com> <20041226160205.GB26574@work.bitmover.com> <yw1xmzw19bnn.fsf@inprovide.com> <20041226181837.GA28786@work.bitmover.com> <1104093456.16487.0.camel@localhost.localdomain> <3ECEAB02-578B-11D9-BCB8-000A95E3BCE4@dalecki.de> <871xdc7jfk.fsf@deneb.enyo.de> <D071CC7A-5793-11D9-9777-000A95E3BCE4@dalecki.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D071CC7A-5793-11D9-9777-000A95E3BCE4@dalecki.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 27, 2004 at 12:13:55AM +0100, Martin Dalecki wrote:

> No the first value that worked in the whole setup of course. And I
> said it clearly that would be just a workaround because uniqueness
> can be established in the easiest way on the side of the part which
> is interested in the persistency - the server peer not the client.

actually, the bk lease server could give out id's and those could be
caches in ~/.bk<whatever> --- server side it could be a counter that
you just xor with some s3kr1t value and then blind using a hash or
cryto-function, something good-enough (statistically unlikely to
break) is all that is required, it doesn't have to be perfect surely?
