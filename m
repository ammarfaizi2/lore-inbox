Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265513AbUAPOXx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 09:23:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265540AbUAPOXx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 09:23:53 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:59795 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S265513AbUAPOWe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 09:22:34 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: Andi Kleen <ak@suse.de>
Subject: Re: [discuss] KGDB 2.0.3 with fixes and development in ethernet interface
Date: Fri, 16 Jan 2004 19:51:51 +0530
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net,
       pavel@suse.cz, mpm@selenic.com, discuss@x86-64.org, george@mvista.com
References: <200401161759.59098.amitkale@emsyssoft.com> <20040116140551.2da2815b.ak@suse.de>
In-Reply-To: <20040116140551.2da2815b.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401161951.51597.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 16 Jan 2004 6:35 pm, Andi Kleen wrote:
> On Fri, 16 Jan 2004 17:59:59 +0530
>
> "Amit S. Kale" <amitkale@emsyssoft.com> wrote:
> > Hi,
> >
> > KGDB 2.0.3 is available at
> > http://kgdb.sourceforge.net/kgdb-2/linux-2.6.1-kgdb-2.0.3.tar.bz2
> >
> > Ethernet interface still doesn't work. It responds to gdb for a couple of
> > packets and then panics. gdb log for ethernet interface is pasted below.
>
> Did you add the fix for netpoll Jim posted?

I am not using netpoll (yet). My patch doesn't require any driver 
modifications, that the mm ethernet patch required.

-- 
Amit Kale
EmSysSoft (http://www.emsyssoft.com)
KGDB: Linux Kernel Source Level Debugger (http://kgdb.sourceforge.net)

