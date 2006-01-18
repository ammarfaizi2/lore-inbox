Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030307AbWARNlZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030307AbWARNlZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 08:41:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030308AbWARNlZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 08:41:25 -0500
Received: from mail.gmx.de ([213.165.64.21]:16335 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030307AbWARNlZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 08:41:25 -0500
X-Authenticated: #7258287
Subject: Re: [BUG] at mm/slab.c:1235! (Version 2.6.15)
From: Sven Lauritzen <the-pulse@gmx.net>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <84144f020601180422q78ecdf37mb8b8e9d1f40039d1@mail.gmail.com>
References: <1137582956.1774.15.camel@berlin.slsd>
	 <84144f020601180422q78ecdf37mb8b8e9d1f40039d1@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 18 Jan 2006 14:41:22 +0100
Message-Id: <1137591682.1774.35.camel@berlin.slsd>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-18 at 14:22 +0200, Pekka Enberg wrote:
> Try enabling CONFIG_DEBUG_SLAB and CONFIG_DEBUG_PAGEALLOC to see if
> they pick up anything.

Ok, I'll try that. I guess I'll find the results in syslog?

> I don't quite see how this could happen. Is the box otherwise stable?
> Have you run memtest86 on it?

It's the first crash within 4 days. I have exchanged motherboard and ram
of the box, so maybe there's something worng. But it seems that the
crash was caused by high traffic on the disk drive. 6:25 is the time,
when findutils and logrotate and so on start to run.

I'll do further testing as soon as I have some time.

Sven
-- 
Sven Lauritzen
--------------------------------------------------------------------
mailto:the-pulse@gmx.net

pub 1024D/95C9A892                  sub 1024g/D30E490F ABCDEFGHIJKLM
Fp  2FA9 FC9B 078C 5BC7 87DC  0B0D 2329 94F6 95C9 A892 NOPQRSTUVWXYZ
--------------------------------------------------------------------

