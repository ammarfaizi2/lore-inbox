Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266522AbUHRO3b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266522AbUHRO3b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 10:29:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266745AbUHRO3b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 10:29:31 -0400
Received: from digitalimplant.org ([64.62.235.95]:32153 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S266522AbUHRO3a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 10:29:30 -0400
Date: Wed, 18 Aug 2004 07:29:27 -0700 (PDT)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       David Brownell <david-b@pacbell.net>
Subject: Re: [patch] enums to clear suspend-state confusion
In-Reply-To: <1092812149.9932.180.camel@gaston>
Message-ID: <Pine.LNX.4.50.0408180727390.6727-100000@monsoon.he.net>
References: <20040812120220.GA30816@elf.ucw.cz>  <20040817212510.GA744@elf.ucw.cz>
 <20040817152742.17d3449d.akpm@osdl.org>  <20040817223700.GA15046@elf.ucw.cz>
 <20040817161245.50dd6b96.akpm@osdl.org>  <20040818002711.GD15046@elf.ucw.cz>
 <1092794687.10506.169.camel@gaston>  <20040818061227.GA7854@elf.ucw.cz>
 <1092812149.9932.180.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 18 Aug 2004, Benjamin Herrenschmidt wrote:

>
> > Yes, that's exactly what I did... Unfortunately typedef means ugly
> > code. So I'll just switch it back to enum system_state, and lets care
> > about device power managment when it hits us, okay?
>
> I don't agree... with this approach, we'll have to change all drivers
> _twice_ when we move to something more descriptive than a scalar

I totally agree. Why be hasty? We need to do it right and do it once. If
that means a couple of more weeks and several more emails, than so be it.
Otherwise, we'll be stuck with a sub-par solution for who knows how long.


	Pat
