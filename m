Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261506AbTJCWzk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 18:55:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261518AbTJCWzk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 18:55:40 -0400
Received: from dyn-ctb-203-221-74-2.webone.com.au ([203.221.74.2]:20484 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S261506AbTJCWzi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 18:55:38 -0400
Message-ID: <3F7DFE52.9010400@cyberone.com.au>
Date: Sat, 04 Oct 2003 08:55:14 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>, Matthew Wilcox <willy@debian.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: must-fix list reconciliation
References: <3F7D3F37.1060005@cyberone.com.au>	<20031003113437.GL24824@parcelfarce.linux.theplanet.co.uk> <20031003083640.61dcf517.rddunlap@osdl.org>
In-Reply-To: <20031003083640.61dcf517.rddunlap@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Randy.Dunlap wrote:

>On Fri, 3 Oct 2003 12:34:37 +0100 Matthew Wilcox <willy@debian.org> wrote:
>
>| On Fri, Oct 03, 2003 at 07:19:51PM +1000, Nick Piggin wrote:
>| > Hi everyone,
>| > As you might or might not know, the must-fix / should-fix lists have been
>| > inadvertently forked. We are merging them again, so please don't update
>| > the wiki until we have worked out what to do with them. This should be a
>| > day or two at most.
>| > 
>| > I had the idea that maybe we could put them into the source tree, and
>| > encourage people to keep them up to date by making them become criteria
>| > for the feature and code freeze. Comments?
>| 
>| I'm a little disappointed that after I spent time converting them into
>| the wiki form, you're now proposing abandoning them again.  This seems
>| like a retrograde step.
>| 
>

To be honest I don't really like the wiki. I'd rather changes go through
lkml where its easier to discuss them and keep up with them. Thats just my
preference though. I don't know what anyone else thinks.

>
>| What I'd be more interested in doing is combining the must- and should-
>| fix lists.  As a first pass, just put all the must-fix items on the
>| should-fix list at pri 4.  One of the things I did was delete the things
>| that appeared on both lists.  This would obviously be easier if they
>| were in one list ;-)
>

Yes, and even easier if there was just one editor.
eg. there 2 drivers/acpi sections in the mustfix list on wiki.

I'd like to keep the 2 lists seperate. The must-fix list is concise and easy
to scan the whole thing. I guess this isn't a problem if there is one 
editor.

>Agreed on that.  I think the location is not the problem (whether
>source tree or wiki), it's just an extra step to keep them updated,
>and having no owner (or _many_ owners) often doesn't work.
>Is one of you (or the two of you) willing to be the owner/editor?
>

If it ends up going into a source tree, I can be the editor / maintainer.


