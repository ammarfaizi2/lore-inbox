Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262433AbUCCLQh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 06:16:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262439AbUCCLQf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 06:16:35 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:33956 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S262433AbUCCLQc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 06:16:32 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: Code freeze on lite patches and schedule for submission into mainline kernel
Date: Wed, 3 Mar 2004 16:46:22 +0530
User-Agent: KMail/1.5
Cc: Tom Rini <trini@kernel.crashing.org>, George Anzinger <george@mvista.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       KGDB bugreports <kgdb-bugreport@lists.sourceforge.net>
References: <200403031354.10370.amitkale@emsyssoft.com> <20040303110154.GC342@elf.ucw.cz>
In-Reply-To: <20040303110154.GC342@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403031646.22151.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 03 Mar 2004 4:31 pm, Pavel Machek wrote:
> Hi!
>
> > We have two sets of kgdb patches as of now: [core-lite, i386-lite, 8250]
> > and [core, i386, ppc, x86_64, eth]. First set of kgdb patches (lite) is
> > fairly clean. Let's consider it to be a candicate for submission to
> > mainline kernel.
>
> There may be better way to get kgdb into mainline.
>
> AFAICS, mainline already contains kgdb/ppc. Submiting "core-lite,
> ppc-lite, 8250" would then be simply much needed cleanup. We can push
> i386 few days after that.

ppc.patch removes arch/ppc/kernel/ppc-stub.c and adds a new file kgdb.c I 
think that has a greater rejection chance.

Let's not change the direction now. Some time ago there was another view that 
x86_64 would be easier. We have already had sufficient headache because of 
split -lite -heavy patches. Let's try to finish that asap.

-Amit

