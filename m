Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264897AbUFHIp1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264897AbUFHIp1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 04:45:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264900AbUFHIp1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 04:45:27 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:10170 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S264897AbUFHIp0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 04:45:26 -0400
Date: Tue, 8 Jun 2004 10:45:06 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Timothy Miller <miller@techsource.com>, Ingo Molnar <mingo@elte.hu>,
       Andrea Arcangeli <andrea@suse.de>, Rik van Riel <riel@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 4k stacks in 2.6
Message-ID: <20040608084506.GA21109@wohnheim.fh-wedel.de>
References: <Pine.LNX.4.44.0405251549530.26157-100000@chimarrao.boston.redhat.com> <Pine.LNX.4.44.0405251607520.26157-100000@chimarrao.boston.redhat.com> <20040525211522.GF29378@dualathlon.random> <20040526103303.GA7008@elte.hu> <20040526125014.GE12142@wohnheim.fh-wedel.de> <20040526125300.GA18028@devserv.devel.redhat.com> <20040526130047.GF12142@wohnheim.fh-wedel.de> <40C4B09B.406@techsource.com> <1086675984.2736.20.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1086675984.2736.20.camel@laptop.fenrus.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 June 2004 08:26:25 +0200, Arjan van de Ven wrote:
> 
> > That gave me an idea.  Sometimes in chip design, we 'overconstrain' the 
> > logic synthesizer, because static timing analyzers often produce 
> > inaccurate results.  Anyhow, what if we were to go to 4K stacks but in 
> > static code analysis, flag anything which uses more than 2K or even 1K?

With 2.6.6, there are currently just a few non-recursive paths over
3k.  2k will give you a *lot* of output, but if you insist... ;)

http://wh.fh-wedel.de/~joern/data.nointermezzo.cs2.2k.bz2
470k compressed, 65M uncompressed

Feel free to send patches.

> the patch I sent to akpm went to 400 bytes actually, but yeah, even that
> already is debatable.

400 bytes?  That is for a single function, I assume.

Jörn

-- 
Those who come seeking peace without a treaty are plotting.
-- Sun Tzu
