Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265146AbUD3LAp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265146AbUD3LAp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 07:00:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265149AbUD3LAp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 07:00:45 -0400
Received: from chaos.analogic.com ([204.178.40.224]:59264 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S265146AbUD3LAk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 07:00:40 -0400
Date: Fri, 30 Apr 2004 07:01:38 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Bryan Stillwell <bryans@aspsys.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Dual Opteron 248s w/ 8GB RAM on Tyan K8W (S2885)
In-Reply-To: <20040430050038.GA27617@aspsys.com>
Message-ID: <Pine.LNX.4.53.0404300657420.3289@chaos>
References: <20040428225331.GA19698@aspsys.com>
 <200404300005.02814.vda@port.imtp.ilyichevsk.odessa.ua> <20040429211733.GD15563@aspsys.com>
 <20040430021516.GA18664@zero> <20040430050038.GA27617@aspsys.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Apr 2004, Bryan Stillwell wrote:

> On Thu, Apr 29, 2004 at 10:15:16PM -0400, Tom Vier wrote:
> >On Thu, Apr 29, 2004 at 03:17:33PM -0600, Bryan Stillwell wrote:
> >> During the 20% chance of it actually booting up, I've been able to
> >> capture /proc/meminfo.  It reports MemTotal as 7642992 kB.  I've been
> >> told that Tyan boards allocate almost 0.5GB for some reason for their
> >
> >interesting. where'd you hear that? mine has 2gigs and is using just under
> >24megs. i wonder what it's doing with all that.

It can't be. The only CPU(s) that would know anything about it and
thus be able to use that RAM are running the operating system.

It is quite obviously a BAD BIOS that doesn't follow the rules about
reporting RAM so some is wasted --- or you have 4GB on the main-board
so some gets wasted to make room for the address-space necessary for
your PCI and AGP cards.

>
> I don't have any theories on what they use it for, but one of the other
> production engineers at my new job says it has been that way with
> multiple previous boards from Tyan we've used.
>
> Bryan
>


Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5557.45 BogoMips).
            Note 96.31% of all statistics are fiction.


