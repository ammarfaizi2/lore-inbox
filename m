Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbTHSHNk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 03:13:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261151AbTHSHN0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 03:13:26 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:42678 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S262116AbTHSHMy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 03:12:54 -0400
X-Sender-Authentication: SMTPafterPOP by <info@euro-tv.de> from 217.64.64.14
Date: Tue, 19 Aug 2003 09:12:43 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: andrea@suse.de, green@namesys.com, marcelo@conectiva.com.br, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, mason@suse.com
Subject: Re: 2.4.22-pre lockups (now decoded oops for pre10)
Message-Id: <20030819091243.007acac0.skraw@ithnet.com>
In-Reply-To: <20030819011208.GK10320@matchmail.com>
References: <20030813125509.360c58fb.skraw@ithnet.com>
	<Pine.LNX.4.44.0308131143570.4279-100000@localhost.localdomain>
	<20030813145940.GC26998@namesys.com>
	<20030813171224.2a13b97f.skraw@ithnet.com>
	<20030813153009.GA27209@namesys.com>
	<20030819011208.GK10320@matchmail.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Aug 2003 18:12:08 -0700
Mike Fedyk <mfedyk@matchmail.com> wrote:

> > > It is unlikely for bad ram to survive memtest for several hours.
> > 
> > memtest is single threaded, UP kernel works fine too.
> 
> Are you saying that one CPU can't saturate the memory bus?  Or maybe we're
> hitting something on the CPU bus, or just that SMP will change the timings
> and stress things differently?  Or that if memtest doesn't test from the
> second CPU then it could be a faulty cpu/L2?

Well, if memtest does not use a second available CPU then probably we should
ask the author about this...
 
> Grr, has anything been done to verify the hardware is running withing specs
> and isn't too hot?

In fact we are talking about datacenter environment with air conditioning and
the like.
Besides the favourite test box I have others (already mentioned in this thread)
- SMP with completely different hw - where I can make 2.4.21 and above crash,
too.

Regards,
Stephan
