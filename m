Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275403AbTHNRR2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 13:17:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275405AbTHNRR2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 13:17:28 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:53376 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S275403AbTHNRRX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 13:17:23 -0400
Date: Thu, 14 Aug 2003 18:17:03 +0100
From: Jamie Lokier <jamie@shareable.org>
To: john stultz <johnstul@us.ibm.com>
Cc: timothy parkinson <t@timothyparkinson.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test3 "loosing ticks"
Message-ID: <20030814171703.GA10889@mail.jlokier.co.uk>
References: <20030813014735.GA225@timothyparkinson.com> <1060793667.10731.1437.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1060793667.10731.1437.camel@cog.beaverton.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz wrote:
> Sounds like either your PIT is running slowly or something is
> consistently keeping the timer interrupt from being handled. In 2.4 do
> you have any time related issues at all?  Does the "Loosing too many
> ticks!" message correlate to any event on the system (boot, heavy load)?
> 
> Also listing system type, motherboard, any sort of funky devices you've
> got might be helpful.

I am seeing something similar on my dual Athlon MP 1800 box.

It is running NTP to synchronise with another machine over the LAN,
but ntpdc reports that it develops a larger and larger offset relative
to the server - ntpd clearly is not managing to regulate the clock.

It does not have this problem with 2.4 - the time synchronises perfectly.

-- Jamie


