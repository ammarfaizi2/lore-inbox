Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751163AbWATT2Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163AbWATT2Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 14:28:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751065AbWATT2X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 14:28:23 -0500
Received: from a34-mta01.direcpc.com ([66.82.4.90]:2152 "EHLO
	a34-mta01.direcway.com") by vger.kernel.org with ESMTP
	id S1751161AbWATT2X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 14:28:23 -0500
Date: Fri, 20 Jan 2006 14:27:50 -0500
From: Ben Collins <bcollins@ubuntu.com>
Subject: Re: Development tree, PLEASE?
In-reply-to: <D1A7010C56BB90C4FA73E6DD@dhcp-2-206.wgops.com>
To: Michael Loftis <mloftis@wgops.com>
Cc: linux-kernel@vger.kernel.org
Message-id: <1137785271.13530.10.camel@grayson>
Organization: Ubuntu Linux
MIME-version: 1.0
X-Mailer: Evolution 2.5.5
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <D1A7010C56BB90C4FA73E6DD@dhcp-2-206.wgops.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-20 at 08:17 -0700, Michael Loftis wrote:
> OK, I don't know abotu others, but I'm starting to get sick of this 
> unstable stable kernel.  Either change the statements allover that were 
> made that even-numbered kernels were going to be stable or open 2.7. 
> Removing devfs has profound effects on userland.  It's one thing to screw 
> with all of the embedded developers, nearly all kernel module developers, 
> etc, by changing internal APIs but this is completely out of hand.

Me, personally, I like it. It's much easier for the distro maintainers
in that they can get the latest and greatest stuff without waiting an
entire year for 2.<odd>.x to turn into 2.<even>.0, and wait a little
more until 2.<even>.0 becomes something like 2.<even>.8 for it to be
stable (because no one was testing the millions of lines of new code
going into the development branch).

I think the new model is also easier for new
drivers/filesystems/whatever, since they don't have to wait for the next
development 2.<odd> branch to get their code in, and then wait for
2.<even>.0 to be released so normal users and distros will get their new
feature.

It also keeps development moving along _very_ quickly, and reduces how
stale the stable kernel tree becomes. When 2.5.0 started, developers
stopped working on 2.4.x because it was just too damn much work to track
two trees. So 2.4.x became stagnant, and while development was moving on
2.5.x, no one other than hardcore developers were using it, so there was
very little testing of a tree that was getting a years worth of code
changes.

So put me in for +1 on the current development model. It suits me,
Ubuntu, and the Ubuntu users very well. We are on a 6 month release
cycle, so a new kernel every 3 months fits us perfect. Means every 6
months we can release a 3 month old kernel. Just old enough to be
stable, not so old it's useless.

-- 
Ben Collins
Kernel Developer - Ubuntu Linux

