Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275526AbTHMUrb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 16:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275527AbTHMUrb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 16:47:31 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:24706 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S275526AbTHMUra (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 16:47:30 -0400
Date: Wed, 13 Aug 2003 21:55:29 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200308132055.h7DKtTkH002249@81-2-122-30.bradfords.org.uk>
To: bunk@fs.tum.de, davidsen@tmr.com
Subject: Re: time for some drivers to be removed?
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, wowbagger@sktc.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Interesting question - whatever I guess. We don't have an existing convention.
> > > How many drivers have we got nowdays that failing on just SMP ?
> > 
> > I 2.6.0-test2 tested on i386 with a .config that is without support for
> > modules and compiles as much as possible statically into the kernel.
> > Without claiming completeness, I found this way besides the complete Old
> > ISDN4Linux subsystem 36 drivers that compile due to cli/sti issues only
> > on UP.
>
> Should those be made to depend on SMP (not SMP) perhaps? They are probably
> high candidates for fixing if they work UP.

Especially since a lot of the time, 'works on UP, but not on SMP',
really means, 'broken on UP and SMP, but the bug is much more
difficult to trigger on UP'.

John.
