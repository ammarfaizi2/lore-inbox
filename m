Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261260AbVCTVFh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261260AbVCTVFh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 16:05:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261261AbVCTVFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 16:05:37 -0500
Received: from eth0-0.arisu.projectdream.org ([194.158.4.191]:13292 "EHLO
	b.mx.projectdream.org") by vger.kernel.org with ESMTP
	id S261260AbVCTVF3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 16:05:29 -0500
Date: Sun, 20 Mar 2005 22:05:48 +0100
From: Thomas Graf <tgraf@suug.ch>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "David S. Miller" <davem@davemloft.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-net@vger.kernel.org
Subject: Re: [PKT_SCHED]: Extended Matches API
Message-ID: <20050320210548.GY3086@postel.suug.ch>
References: <200503070214.j272EWfo024708@hera.kernel.org> <Pine.LNX.4.62.0503202157350.27963@gorilla.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0503202157350.27963@gorilla.sonytel.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Geert Uytterhoeven <Pine.LNX.4.62.0503202157350.27963@gorilla.sonytel.be> 2005-03-20 21:58
> On Tue, 15 Feb 2005, Linux Kernel Mailing List wrote:
> > ChangeSet 1.1982.66.2, 2005/02/15 12:13:15-08:00, davem@nuts.davemloft.net
> > 
> > 	[PKT_SCHED]: Extended Matches API
> 
> 
> > --- a/net/sched/Kconfig	2005-03-06 18:14:44 -08:00
> > +++ b/net/sched/Kconfig	2005-03-06 18:14:44 -08:00
> 
> > +config NET_EMATCH_STACK
> > +	int "Stack size"
> > +	depends on NET_EMATCH
> > +	default "32"
> > +	---help---
> > +	  Size of the local stack variable used while evaluating the tree of
> > +	  ematches. Limits the depth of the tree, i.e. the number of
> > +	  encapsulated precedences. Every level requires 4 bytes of addtional
>                                                                     ^^^^^^^^^
> 								    additional
> > +	  stack space.
> > +
> 
> Gr{oetje,eeting}s,

Fixed it in the ematch tree submit it in the next patchset. Thanks.
