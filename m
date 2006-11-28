Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935851AbWK1K7U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935851AbWK1K7U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 05:59:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935852AbWK1K7U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 05:59:20 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:61101 "EHLO
	rubicon.netdirect.ca") by vger.kernel.org with ESMTP
	id S935851AbWK1K7U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 05:59:20 -0500
X-Originating-Ip: 72.57.81.197
Date: Tue, 28 Nov 2006 05:55:42 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Arjan van de Ven <arjan@infradead.org>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: mismatch between default and defconfig LOG_BUF_SHIFT values
In-Reply-To: <1164708938.3276.65.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.64.0611280554430.15533@localhost.localdomain>
References: <Pine.LNX.4.64.0611280451010.13481@localhost.localdomain>
 <1164708938.3276.65.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.8, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Nov 2006, Arjan van de Ven wrote:

> > ...
> >
> >   is it worth trying to bring the Kconfig.debug default values into
> > line with the defconfig file values, to avoid any possible confusion?
>
> I don't think so. defconfig is just there to get some working
> system. You should really pay attention to the config options you
> care about, and select the value YOU want. Neither defconfig nor the
> "default value" matter in that. Of course especially the "default
> value" should be a sane one, but it is in this case.. your system
> boots and works fine.
>
> defconfig also tends to be the config used by the arch maintainer,
> eg the one he uses for his system. He might very well have different
> preferences than you have...

fair enough.  i didn't *think* there was any technical reason why
those values had to match, i just thought i'd ask.

rday
