Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261270AbUA0HiE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 02:38:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262687AbUA0HiE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 02:38:04 -0500
Received: from ookhoi.xs4all.nl ([213.84.114.66]:53890 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S261270AbUA0HiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 02:38:02 -0500
Date: Tue, 27 Jan 2004 08:38:01 +0100
From: Sander <sander@humilis.net>
To: Wakko Warner <wakko@animx.eu.org>
Cc: Robert Love <rml@ximian.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.1 dual xeon
Message-ID: <20040127073801.GB9708@favonius>
Reply-To: sander@humilis.net
References: <20040124203646.A8709@animx.eu.org> <1074995006.5246.1.camel@localhost> <20040125083712.A9318@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040125083712.A9318@animx.eu.org>
X-Uptime: 07:25:48 up 31 days, 21:14, 36 users,  load average: 1.16, 1.99, 2.45
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wakko Warner wrote (ao):
> > > I recently aquired a dual xeon system. HT is enabled which shows
> > > up as 4 cpus. I noticed that all interrupts are on CPU0. Can
> > > anyone tell me why this is?
> > 
> > The APIC needs to be programmed to deliver interrupts to certain
> > processors.
> > 
> > In 2.6, this is done in user-space via a program called irqbalance:
> 
> Thanks, working great. (Debian by the way)

Ehm, IIRC the "all interrupts are on CPU0" is how it is supposed to work
with a 2.6 kernel? The interrupts should spread if you have _a_lot_ of
them. This gives better performance than spreading the interrupts. Did I
read this on the list, or am I completely wrong here?

-- 
Humilis IT Services and Solutions
http://www.humilis.net
