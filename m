Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932376AbWAFFwe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932376AbWAFFwe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 00:52:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932377AbWAFFwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 00:52:34 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:35596 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S932376AbWAFFwd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 00:52:33 -0500
Date: Fri, 6 Jan 2006 06:52:08 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Kay Sievers <kay.sievers@vrfy.org>, Pekka Enberg <penberg@cs.helsinki.fi>,
       linux-kernel@vger.kernel.org
Subject: Re: 80 column line limit?
Message-ID: <20060106055208.GE7142@w.ods.org>
References: <20060105130249.GB29894@vrfy.org> <84144f020601050532l56c15be1i4938a84f6c212960@mail.gmail.com> <20060105211438.GA1408@vrfy.org> <Pine.LNX.4.61.0601052301270.27662@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0601052301270.27662@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2006 at 11:03:09PM +0100, Jan Engelhardt wrote:
> >> And your nesting is too deep, it should be fixed.
> >
> >It's not about nesting, if that's the reason, the number of tabs
> >should get a maximum specified instead.
> >
> Or we could have the tab width lowered, but I doubt
> Linus would accept that :)

In fact, one tab could be lowered, it's the first one. Nearly all code
has at least this tab which is not very useful and would not affect
readability if reduced to 2 or 4. But it will be difficult to maintain
a variable tab width, not to mention the alignment problem on the
second tab.

BTW, if 80 is not enough, simply consider that one tab is exactly one
character ( '\011' ) and you will be able to put more, but I doubt
your code will be accepted ;-)

Willy

