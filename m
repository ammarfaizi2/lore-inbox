Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275559AbTHNWAH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 18:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275576AbTHNWAH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 18:00:07 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:5249 "EHLO mail.jlokier.co.uk")
	by vger.kernel.org with ESMTP id S275559AbTHNWAE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 18:00:04 -0400
Date: Thu, 14 Aug 2003 22:58:28 +0100
From: Jamie Lokier <jamie@shareable.org>
To: john stultz <johnstul@us.ibm.com>
Cc: timothy parkinson <t@timothyparkinson.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test3 "loosing ticks"
Message-ID: <20030814215828.GA12650@mail.jlokier.co.uk>
References: <20030813014735.GA225@timothyparkinson.com> <1060793667.10731.1437.camel@cog.beaverton.ibm.com> <20030814171703.GA10889@mail.jlokier.co.uk> <1060882084.10732.1588.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1060882084.10732.1588.camel@cog.beaverton.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz wrote:
> > I am seeing something similar on my dual Athlon MP 1800 box.
> > 
> > It is running NTP to synchronise with another machine over the LAN,
> > but ntpdc reports that it develops a larger and larger offset relative
> > to the server - ntpd clearly is not managing to regulate the clock.
> 
> Approximately at what rate does it skew? Does ntpdate -b <server> set it
> properly?

I'll keep a note.  It's not very fast, but enough to reach several
tens of seconds after a day's work - enough to break Make over NFS,
that's why I noticed.

It might stop showing up now, as I am now running 2.5.75 on the server too :)

> Are you also seeing the "Loosing too many ticks!" message?

No.

-- Jamie
