Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272224AbTHNF0O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 01:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272225AbTHNF0N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 01:26:13 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:7040 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S272224AbTHNF0K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 01:26:10 -0400
Date: Thu, 14 Aug 2003 06:34:04 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200308140534.h7E5Y4qc000327@81-2-122-30.bradfords.org.uk>
To: bunk@fs.tum.de, john@grabjohn.com
Subject: Re: time for some drivers to be removed?
Cc: alan@lxorguk.ukuu.org.uk, davidsen@tmr.com, linux-kernel@vger.kernel.org,
       wowbagger@sktc.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > > Interesting question - whatever I guess. We don't have an existing convention.
> > > > > How many drivers have we got nowdays that failing on just SMP ?
> > > > 
> > > > I 2.6.0-test2 tested on i386 with a .config that is without support for
> > > > modules and compiles as much as possible statically into the kernel.
> > > > Without claiming completeness, I found this way besides the complete Old
> > > > ISDN4Linux subsystem 36 drivers that compile due to cli/sti issues only
> > > > on UP.
> > >
> > > Should those be made to depend on SMP (not SMP) perhaps? They are probably
> > > high candidates for fixing if they work UP.
> > 
> > Especially since a lot of the time, 'works on UP, but not on SMP',
> > really means, 'broken on UP and SMP, but the bug is much more
> > difficult to trigger on UP'.
>
> Please reread my mail:
> "that compile due to cli/sti issues only on UP".
>
> This clearly disproves your theory.

I was talking about broken-on-SMP in general, not just this specific
case.

John.
