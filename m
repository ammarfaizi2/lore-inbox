Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272382AbTHSP4f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 11:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272064AbTHSPzv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 11:55:51 -0400
Received: from zeus.kernel.org ([204.152.189.113]:64226 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S272340AbTHSPyt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 11:54:49 -0400
X-Sender-Authentication: SMTPafterPOP by <info@euro-tv.de> from 217.64.64.14
Date: Tue, 19 Aug 2003 16:18:32 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: mfedyk@matchmail.com, andrea@suse.de, green@namesys.com,
       marcelo@conectiva.com.br, akpm@osdl.org, linux-kernel@vger.kernel.org,
       mason@suse.com
Subject: Re: 2.4.22-pre lockups (now decoded oops for pre10)
Message-Id: <20030819161832.2a0bae58.skraw@ithnet.com>
In-Reply-To: <1061298621.30565.31.camel@dhcp23.swansea.linux.org.uk>
References: <20030813125509.360c58fb.skraw@ithnet.com>
	<Pine.LNX.4.44.0308131143570.4279-100000@localhost.localdomain>
	<20030813145940.GC26998@namesys.com>
	<20030813171224.2a13b97f.skraw@ithnet.com>
	<20030813153009.GA27209@namesys.com>
	<20030819011208.GK10320@matchmail.com>
	<20030819091243.007acac0.skraw@ithnet.com>
	<1061298621.30565.31.camel@dhcp23.swansea.linux.org.uk>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 Aug 2003 14:10:22 +0100
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> On Maw, 2003-08-19 at 08:12, Stephan von Krawczynski wrote:
> > > Are you saying that one CPU can't saturate the memory bus?  Or maybe
> > > we're hitting something on the CPU bus, or just that SMP will change the
> > > timings and stress things differently?  Or that if memtest doesn't test
> > > from the second CPU then it could be a faulty cpu/L2?
> > 
> > Well, if memtest does not use a second available CPU then probably we
> > should ask the author about this...
> 
> I'm sure he'd give you a quote for adding SMP support if you asked.

Well, actually I don't want to burn down his time as long as I don't see a need
for it. Since I am pretty confident to make the box work in SMP under 2.4.20 a
memtest will most certainly not give any additional information, be it running
UP or SMP.
Instead I will invest another day and convert the whole system back to
reiserfs, because the ext3 fs cannot be used under 2.4.20 - I don't know why.
Additionally reiserfs is better for testing possible patches because it crashes
in much shorter time than ext3 setup.
2.4.20 setup gives me a simple testcase to prove people right or wrong that are
talking about a hardware issue.

Regards,
Stephan
