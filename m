Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264571AbUIZWoA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264571AbUIZWoA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Sep 2004 18:44:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264665AbUIZWoA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Sep 2004 18:44:00 -0400
Received: from gprs214-244.eurotel.cz ([160.218.214.244]:49281 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S264571AbUIZWn4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Sep 2004 18:43:56 -0400
Date: Mon, 27 Sep 2004 00:43:38 +0200
From: Pavel Machek <pavel@suse.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Kevin Fenzi <kevin@scrye.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9-rc2-mm1 swsusp bug report.
Message-ID: <20040926224338.GS28810@elf.ucw.cz>
References: <20040924143714.GA826@openzaurus.ucw.cz> <20040924210958.A3C5AA2073@voldemort.scrye.com> <1096069216.3591.16.camel@desktop.cunninghams> <20040925014546.200828E71E@voldemort.scrye.com> <1096113235.5937.3.camel@desktop.cunninghams> <415562FE.3080709@yahoo.com.au> <20040925154527.GA8212@elf.ucw.cz> <1096149821.8359.1.camel@desktop.cunninghams> <20040926100442.GG10435@elf.ucw.cz> <1096235982.10015.1.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1096235982.10015.1.camel@desktop.cunninghams>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Are we still planning on having suspend2 replace swsusp eventually? It
> > > was a lot of work to switch from those high order allocations, and if we
> > > are still going to replace swsusp, perhaps it's would be a better use of
> > > your time to do other things?
> > 
> > I do not know if I'm more scared of swsusp1 to kill order-8
> > allocations or if suspend2's two page sets scare me more. (Hooks
> > suspend2 needs to stop all page cache activity are scary...)
> 
> Hooks to stop all page cache activity? I'm not sure what you mean.

You have system where you write image in two parts, and there are some
pretty special rules what you may not touch when writing first part,
IIRC. That is what scares me...
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
