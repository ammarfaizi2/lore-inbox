Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275421AbTHNR3l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 13:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275422AbTHNR3l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 13:29:41 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:65227 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S275421AbTHNR3i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 13:29:38 -0400
Subject: Re: 2.6.0-test3 "loosing ticks"
From: john stultz <johnstul@us.ibm.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: timothy parkinson <t@timothyparkinson.com>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20030814171703.GA10889@mail.jlokier.co.uk>
References: <20030813014735.GA225@timothyparkinson.com>
	 <1060793667.10731.1437.camel@cog.beaverton.ibm.com>
	 <20030814171703.GA10889@mail.jlokier.co.uk>
Content-Type: text/plain
Organization: 
Message-Id: <1060882084.10732.1588.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 14 Aug 2003 10:28:04 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-08-14 at 10:17, Jamie Lokier wrote:
> john stultz wrote:
> > Sounds like either your PIT is running slowly or something is
> > consistently keeping the timer interrupt from being handled. In 2.4 do
> > you have any time related issues at all?  Does the "Loosing too many
> > ticks!" message correlate to any event on the system (boot, heavy load)?
> > 
> > Also listing system type, motherboard, any sort of funky devices you've
> > got might be helpful.
> 
> I am seeing something similar on my dual Athlon MP 1800 box.
> 
> It is running NTP to synchronise with another machine over the LAN,
> but ntpdc reports that it develops a larger and larger offset relative
> to the server - ntpd clearly is not managing to regulate the clock.

Approximately at what rate does it skew? Does ntpdate -b <server> set it
properly?

Are you also seeing the "Loosing too many ticks!" message?

thanks
-john


