Return-Path: <linux-kernel-owner+w=401wt.eu-S932261AbXAOMHh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932261AbXAOMHh (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 07:07:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932268AbXAOMHh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 07:07:37 -0500
Received: from mail.first.fraunhofer.de ([194.95.169.2]:58689 "EHLO
	mail.first.fraunhofer.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932266AbXAOMHg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 07:07:36 -0500
Subject: Re: prioritize PCI traffic ?
From: Soeren Sonnenburg <kernel@nn7.de>
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20070115120124.GA5045@rhlx01.hs-esslingen.de>
References: <1168859265.15294.8.camel@localhost>
	 <20070115120124.GA5045@rhlx01.hs-esslingen.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 15 Jan 2007 13:07:29 +0100
Message-Id: <1168862849.15294.32.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2007-01-15 at 13:01 +0100, Andreas Mohr wrote:
> Hi,
> 
> On Mon, Jan 15, 2007 at 12:07:45PM +0100, Soeren Sonnenburg wrote:
> > Dear all,
> > 
> > is it possible to explicitly tell the kernel to prioritize PCI traffic
> > for a number of cards in pci slots x,y,z ?
> > 
> > I am asking as severe ide traffic causes lost frames when watching TV
> > using 2 DVB cards + vdr... This is simply due to the fact that the PCI
> > bus is saturated...
> > 
> > So, is any prioritizing of the PCI bus possible ?
> 
> You probably need to adjust PCI latency settings via setpci:
> 
> http://www-128.ibm.com/developerworks/library/l-hw2.html

Thanks, but I already tried this...

> Not sure whether this is a LKML related question ;)

Well I already tried to set maximum latencies etc to the cards to
prioritize to no avail... This did not make a difference though. Maybe
this is due to the fact that a lot more has to be transferred (not just
sound, but video data) and this is not possible in a single
transaction ... ?!

Soeren
-- 
Sometimes, there's a moment as you're waking, when you become aware of
the real world around you, but you're still dreaming.
