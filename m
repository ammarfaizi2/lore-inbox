Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264928AbTIJPBK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 11:01:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264943AbTIJPBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 11:01:10 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:20352 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S264928AbTIJPBI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 11:01:08 -0400
Date: Wed, 10 Sep 2003 16:14:27 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200309101514.h8AFER1f000656@81-2-122-30.bradfords.org.uk>
To: davidsen@tmr.com, john@grabjohn.com
Subject: Re: Scaling noise
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[snip most of discussion]

You have changed the topic completely.

> > The hardware is fault tollerant by design.  Only extreme events like a
> > fire or flood at the datacentre are likely to cause downtime of the
> > whole machine.  I don't consider that any less secure than a rack of
> > small servers.
>
> And power failure, loss of ISP connectivity, loss of phone service...
> As said originally, reliability is *hard* and *expensive* to do right.

Not sure how any of the above is related to the mainframe vs rack of
micros discussion.  Redundant ISP connectivity can be provided to
both.

You seem to be suggesting that I'm saying that it's a good idea to
replace geographically distributed, separate microcomputer servers
with a _single_ mainframe.  I am not.  I am only concerned with the
per-site situation.  As long as the geographically separate machine
stays geographically separate it is no longer part of the equation.

The only thing I am suggesting is that a single rack of machines in a
datacentre  somewhere could be replaced by a single machine with
virtualisation technology, and the same or better hardware
reliability as the rack of discrete machines, and there would be no
loss of availability.

Infact, increased availability may result, due to the ease of
administrating virtual machines as opposed to physical machines, and
the reduction in network hardware.

> This would be a good topic for comp.arch, it's getting a bit OT here.

Agreed, except that I brought it up to re-inforce Larry's point that
scaling above ~4 CPUs and hurting <=4 CPUs performance was a bad
thing.

John.
