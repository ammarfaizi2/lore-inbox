Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275057AbTHRU62 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 16:58:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275059AbTHRU62
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 16:58:28 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:10507
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S275057AbTHRU61 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 16:58:27 -0400
Date: Mon, 18 Aug 2003 13:58:25 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Andrea Arcangeli <andrea@suse.de>, green@namesys.com,
       marcelo@conectiva.com.br, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org, mason@suse.com
Subject: Re: 2.4.22-pre lockups (now decoded oops for pre10)
Message-ID: <20030818205825.GF10320@matchmail.com>
Mail-Followup-To: Stephan von Krawczynski <skraw@ithnet.com>,
	Andrea Arcangeli <andrea@suse.de>, green@namesys.com,
	marcelo@conectiva.com.br, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
	linux-kernel@vger.kernel.org, mason@suse.com
References: <20030813125509.360c58fb.skraw@ithnet.com> <Pine.LNX.4.44.0308131143570.4279-100000@localhost.localdomain> <20030813145940.GC26998@namesys.com> <20030813171224.2a13b97f.skraw@ithnet.com> <20030813153009.GA27209@namesys.com> <20030818150625.GW7862@dualathlon.random> <20030818221921.7b96de86.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030818221921.7b96de86.skraw@ithnet.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 18, 2003 at 10:19:21PM +0200, Stephan von Krawczynski wrote:
> On Mon, 18 Aug 2003 17:06:25 +0200
> Andrea Arcangeli <andrea@suse.de> wrote:
> 
> > an SMP kernel puts the double of the stress on the mem bus, so it might
> > still be ram that went bad around the time you upgraded from 2.4.19. Or
> > it maybe simply a buggy smp motherboard, or whatever.
> > 
> > Of course I can't be sure but we can't exclude it.
> 
> It is unlikely for bad ram to survive memtest for several hours.

How many hours?

Are you using memtest 3.0 that supports larger ammounts of memory, and has
specific tests for ECC (ie disabling it)?

Are you doing a full run with all tests, and not just the standard tests?
(you should let it complete one, or preferably two or three in this mode)
