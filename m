Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275279AbTHSBMT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 21:12:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275280AbTHSBMS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 21:12:18 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:6674
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S275279AbTHSBMN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 21:12:13 -0400
Date: Mon, 18 Aug 2003 18:12:08 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Stephan von Krawczynski <skraw@ithnet.com>, green@namesys.com,
       marcelo@conectiva.com.br, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org, mason@suse.com
Subject: Re: 2.4.22-pre lockups (now decoded oops for pre10)
Message-ID: <20030819011208.GK10320@matchmail.com>
Mail-Followup-To: Andrea Arcangeli <andrea@suse.de>,
	Stephan von Krawczynski <skraw@ithnet.com>, green@namesys.com,
	marcelo@conectiva.com.br, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
	linux-kernel@vger.kernel.org, mason@suse.com
References: <20030813125509.360c58fb.skraw@ithnet.com> <Pine.LNX.4.44.0308131143570.4279-100000@localhost.localdomain> <20030813145940.GC26998@namesys.com> <20030813171224.2a13b97f.skraw@ithnet.com> <20030813153009.GA27209@namesys.com> <20030818150625.GW7862@dualathlon.random> <20030818221921.7b96de86.skraw@ithnet.com> <20030818223127.GH16139@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030818223127.GH16139@dualathlon.random>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 19, 2003 at 12:31:27AM +0200, Andrea Arcangeli wrote:
> On Mon, Aug 18, 2003 at 10:19:21PM +0200, Stephan von Krawczynski wrote:
> > On Mon, 18 Aug 2003 17:06:25 +0200
> > Andrea Arcangeli <andrea@suse.de> wrote:
> > 
> > > an SMP kernel puts the double of the stress on the mem bus, so it might
> > > still be ram that went bad around the time you upgraded from 2.4.19. Or
> > > it maybe simply a buggy smp motherboard, or whatever.
> > > 
> > > Of course I can't be sure but we can't exclude it.
> > 
> > It is unlikely for bad ram to survive memtest for several hours.
> 
> memtest is single threaded, UP kernel works fine too.

Are you saying that one CPU can't saturate the memory bus?  Or maybe we're
hitting something on the CPU bus, or just that SMP will change the timings
and stress things differently?  Or that if memtest doesn't test from the
second CPU then it could be a faulty cpu/L2?

Grr, has anything been done to verify the hardware is running withing specs
and isn't too hot?
