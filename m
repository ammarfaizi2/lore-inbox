Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262396AbVAEO7f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262396AbVAEO7f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 09:59:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262457AbVAEO7f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 09:59:35 -0500
Received: from adsl-ull-142-137.44-151.net24.it ([151.44.137.142]:50696 "EHLO
	gateway.milesteg.arr") by vger.kernel.org with ESMTP
	id S262396AbVAEO7V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 09:59:21 -0500
Date: Wed, 5 Jan 2005 15:59:16 +0100
From: Daniele Venzano <webvenza@libero.it>
To: Brancaleoni Matteo <mbrancaleoni@tiscali.it>
Cc: linux-kernel@vger.kernel.org, NetDev <netdev@oss.sgi.com>
Subject: Re: [PATCH] sis900.c net poll support
Message-ID: <20050105145916.GA31207@picchio.gall.it>
Mail-Followup-To: Brancaleoni Matteo <mbrancaleoni@tiscali.it>,
	linux-kernel@vger.kernel.org, NetDev <netdev@oss.sgi.com>
References: <1104921127.5729.17.camel@athlon64>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1104921127.5729.17.camel@athlon64>
X-Operating-System: Debian GNU/Linux on kernel Linux 2.4.28-grsec
X-Copyright: Forwarding or publishing without permission is prohibited.
X-Truth: La vita e' una questione di culo, o ce l'hai o te lo fanno.
X-GPG-Fingerprint: 642A A345 1CEF B6E3 925C  23CE DAB9 8764 25B3 57ED
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, it was on my TODO list and now I can just remove the entry :-)
I'll try to integrate your patch in the next sis900 update.

Bye.

On Wed, Jan 05, 2005 at 11:32:07AM +0100, Brancaleoni Matteo wrote:
> Hi.
> 
> I was in need to use netconsole to trace some lock
> of my sata disk, but my onboard network card (sis900)
> seems doesn't support net poll.
> So searching the web I found out an old patch for enabling
> in under 2.4, and ported it to 2.6.10 (looking
> also into 2.6.x device drivers already working)
> 
> Seems to be ok, netconsole works without issues.
> Hope that's ok and can be useful.
> 
> Matteo Brancaleoni.

> --- linux-2.6.10/drivers/net/sis900.orig	2005-01-05 09:55:46.000000000 +0100
> +++ linux-2.6.10/drivers/net/sis900.c	2005-01-05 10:09:04.000000000 +0100

-- 
-----------------------------
Daniele Venzano
Web: http://teg.homeunix.org

