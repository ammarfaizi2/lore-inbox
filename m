Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264285AbTLYJz7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Dec 2003 04:55:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264286AbTLYJz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Dec 2003 04:55:59 -0500
Received: from fw.osdl.org ([65.172.181.6]:465 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264285AbTLYJz6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Dec 2003 04:55:58 -0500
Date: Thu, 25 Dec 2003 01:55:18 -0800
From: Andrew Morton <akpm@osdl.org>
To: George Anzinger <george@mvista.com>
Cc: mpm@selenic.com, jgarzik@pobox.com, dilinger@voxel.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] more CardServices() removals (drivers/net/wireless)
Message-Id: <20031225015518.09c3eaad.akpm@osdl.org>
In-Reply-To: <3FEAB1D6.9030209@mvista.com>
References: <1072229780.5300.69.camel@spiral.internal>
	<20031223182817.0bd3dd3c.akpm@osdl.org>
	<3FE8FC2E.3080701@pobox.com>
	<20031223184827.4cfb87e2.akpm@osdl.org>
	<3FE9022A.7010604@pobox.com>
	<20031223202305.489c409f.akpm@osdl.org>
	<20031224043349.GI18208@waste.org>
	<3FEAB1D6.9030209@mvista.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

George Anzinger <george@mvista.com> wrote:
>
> >>George, I'm sorely tempted to fold all of these:
>  >>
>  >>	kgdb-buff-too-big.patch
>  >>	kgdb-warning-fix.patch
>  >>	kgdb-build-fix.patch
>  >>	kgdb-spinlock-fix.patch
>  >>	kgdb-fix-debug-info.patch
>  >>	kgdb-cpumask_t.patch
>  >>	kgdb-x86_64-fixes.patch
>  >>
>  >>into the base kgdb patch.   Beware ;)
>  > 
>  > 
>  > I did that here too, and I believe mbligh has as well.
>  > 
>  I got side tracked by a customer with money :)

A what?

> The fold is fine with me, but I would like to know what went in.

I'll send you the diffs when I do it.

> 
>  By the way, in my looking at the network link stuff,
>

That's all changing.  It will be based on the netpoll infrstructure, which
is also used by netconsole.  Matt has a little documentation file and for
kgdb and I assume the netpoll code includes documentation of the kernel
parameter format to supply IP addresses and such.


