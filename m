Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263894AbTGXOR5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 10:17:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271198AbTGXOR5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 10:17:57 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:2688 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S263894AbTGXOR4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 10:17:56 -0400
Date: Thu, 24 Jul 2003 15:43:03 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200307241443.h6OEh3Qd000249@81-2-122-30.bradfords.org.uk>
To: linux-kernel@vger.kernel.org, rpjday@mindspring.com
Subject: Re: time for some drivers to be removed?
Cc: h@81-2-122-30.bradfords.org.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   i've mentioned this before, but in a perfect world, should it
> be possible to build a release version of the kernel with
> "make allyesconfig".

Why?  The kernel wouldn't boot on i386 anyway, as it would be too
large.

> this is generally not possible, since there's always the occasional
> broken driver that just won't compile.

Just don't compile it in.

>   more to the point, there are drivers that seem to be perpetually
> broken.  as an example, the riscom8 driver has been borked for as 
> long as i can remember.  at some point, shouldn't something like
> this either be fixed or just removed?

I'm sure a patch to fix it would be accepted.

> what's the point of perpetually bundling a driver that doesn't even
> compile?

Some people might be interested in it.  Maybe somebody would like to
fix it, but can't buy the physical hardware for any price.  Maybe
everybody who has the hardware can't fix it because other kernel bugs
prevent them from using the latest kernels on their machines.  Why
remove it when it's doing no harm whatsoever?

John.
