Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265213AbUAERYF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 12:24:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265215AbUAERX4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 12:23:56 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:45321 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S265213AbUAERWD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 12:22:03 -0500
Date: Mon, 5 Jan 2004 18:21:40 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Martin Schlemmer <azarah@nosferatu.za.org>
Cc: Soeren Sonnenburg <kernel@nn7.de>, Mike Fedyk <mfedyk@matchmail.com>,
       Willy Tarreau <willy@w.ods.org>, szonyi calin <caszonyi@yahoo.com>,
       Con Kolivas <kernel@kolivas.org>, Mark Hahn <hahn@physics.mcmaster.ca>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
       gillb4@telusplanet.net
Subject: Re: xterm scrolling speed - scheduling weirdness in 2.6 ?!
Message-ID: <20040105172140.GA2424@alpha.home.local>
References: <1073227359.6075.284.camel@nosferatu.lan> <20040104225827.39142.qmail@web40613.mail.yahoo.com> <20040104233312.GA649@alpha.home.local> <20040104234703.GY1882@matchmail.com> <1073294318.3247.80.camel@localhost> <1073323208.6075.318.camel@nosferatu.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1073323208.6075.318.camel@nosferatu.lan>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 05, 2004 at 07:20:08PM +0200, Martin Schlemmer wrote:
> On Mon, 2004-01-05 at 11:18, Soeren Sonnenburg wrote:
> > On Mon, 2004-01-05 at 00:47, Mike Fedyk wrote:
> > > On Mon, Jan 05, 2004 at 12:33:12AM +0100, Willy Tarreau wrote:
> > > > at a time. I have yet to understand why 'ls|cat' behaves
> > > > differently, but fortunately it works and it has already saved
> > > > me some useful time.
> > > 
> > > cat probably does some buffering for you, and sends the output to xterm in
> > > larger blocks.
> > 
> > yes indeed, judging from the cat source it does chose optimal buffer
> > size, here 1024 byte... so it reads/writes larger chunks... and jump
> > scrolling takes place...
> > 
> 
> I cannot reboot right now, so have wrong kernel for testing, but could
> anyone see what happens if you start X reniced to +10 or such?  Maybe
> some other numbers?

I posted such tests with numbers in a previous mail in this thread. IIRC,
renicing X to +10 was indeed a work-around for most cases.

Cheers,
Willy

