Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263486AbUAPPNL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 10:13:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265143AbUAPPNL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 10:13:11 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:55961 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S263486AbUAPPMx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 10:12:53 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: Pavel Machek <pavel@suse.cz>
Subject: Re: [discuss] KGDB 2.0.3 with fixes and development in ethernet interface
Date: Fri, 16 Jan 2004 20:42:12 +0530
User-Agent: KMail/1.5
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       kgdb-bugreport@lists.sourceforge.net, mpm@selenic.com,
       discuss@x86-64.org, george@mvista.com
References: <200401161759.59098.amitkale@emsyssoft.com> <200401161951.51597.amitkale@emsyssoft.com> <20040116144555.GE2535@elf.ucw.cz>
In-Reply-To: <20040116144555.GE2535@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401162042.12969.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 16 Jan 2004 8:15 pm, Pavel Machek wrote:
> Hi!
>
> > > > KGDB 2.0.3 is available at
> > > > http://kgdb.sourceforge.net/kgdb-2/linux-2.6.1-kgdb-2.0.3.tar.bz2
> > > >
> > > > Ethernet interface still doesn't work. It responds to gdb for a
> > > > couple of packets and then panics. gdb log for ethernet interface is
> > > > pasted below.
> > >
> > > Did you add the fix for netpoll Jim posted?
> >
> > I am not using netpoll (yet). My patch doesn't require any driver
> > modifications, that the mm ethernet patch required.
>
> Does that mean that you are going to use netpoll, eventually?

I don't know yet. I don't like the idea of a debugger using a lot of kernel 
code.  I am trying to implement kgdboe without netpoll and without making 
changes to ethernet drivers.

Perhaps I'll have to use netpoll eventually!
-- 
Amit Kale
EmSysSoft (http://www.emsyssoft.com)
KGDB: Linux Kernel Source Level Debugger (http://kgdb.sourceforge.net)

