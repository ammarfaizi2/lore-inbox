Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750911AbVL3UyT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750911AbVL3UyT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 15:54:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750871AbVL3UyT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 15:54:19 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:6924 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1750813AbVL3UyS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 15:54:18 -0500
Date: Fri, 30 Dec 2005 21:45:57 +0100
From: Willy Tarreau <willy@w.ods.org>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       marcelo.tosatti@cyclades.com, alan@redhat.com
Subject: Re: [PATCH] strict VM overcommit accounting for 2.4.32/2.4.33-pre1
Message-ID: <20051230204557.GA2712@w.ods.org>
References: <20051230074401.GA7501@ip68-225-251-162.oc.oc.cox.net> <20051230174817.GW15993@alpha.home.local> <1135966666.2941.32.camel@laptopd505.fenrus.org> <20051230183308.GA2501@w.ods.org> <986ed62e0512301137o3ee36bf1yadac63784cb75dd3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <986ed62e0512301137o3ee36bf1yadac63784cb75dd3@mail.gmail.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 30, 2005 at 11:37:38AM -0800, Barry K. Nathan wrote:
> On 12/30/05, Willy Tarreau <willy@w.ods.org> wrote:
> > On Fri, Dec 30, 2005 at 07:17:46PM +0100, Arjan van de Ven wrote:
> [snip discussion not directly related to the timing of my patch submission]
> > > Also I think, to be honest, that this is a feature that is getting
> > > unsuitable for the "bugfixes only" 2.4 kernel series....
> >
> > Agreed, it really is too late IMHO, because there's a non-null risk of
> > introducing new bugs with it. It would have been cool a few months
> > earlier. That won't stop me from trying it in my own tree however ;-)
> 
> Yeah, I know it's a little bit late. I wish I had been able to get
> this done a few months ago... :(

And I wish I could stay awake 24 hours a day and 365 days a year...
Seriously, this work will not be lost because 2.6 has it. However,
if it works well, I intend to link to it from my interesting patches
page (when I finally find time to put it online).

> Oh well, even if it doesn't get into the tree, at least it looks like
> I might not be the only person to benefit from this patch. :)

Every patch which can enhance long term stability will interest people
who manage remote systems and who at least start softdog to get a chance
to reach the box after an accident.

> (BTW,
> you'll probably also want the patch I just posted, which adds
> Committed_AS to /proc/meminfo.)

I've caught it, thanks.

> -Barry K. Nathan <barryn@pobox.com>

Cheers,
Willy

