Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271149AbRICDIx>; Sun, 2 Sep 2001 23:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271135AbRICDIm>; Sun, 2 Sep 2001 23:08:42 -0400
Received: from ns.suse.de ([213.95.15.193]:18439 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S271129AbRICDIb>;
	Sun, 2 Sep 2001 23:08:31 -0400
Date: Mon, 3 Sep 2001 05:08:49 +0200 (CEST)
From: Dave Jones <davej@suse.de>
To: Keith Owens <kaos@ocs.com.au>
Cc: Alan Cox <laughing@shared-source.org>, <linux-kernel@vger.kernel.org>,
        <torvalds@transmeta.com>
Subject: Re: Linux 2.4.9-ac6 
In-Reply-To: <4165.999485481@kao2.melbourne.sgi.com>
Message-ID: <Pine.LNX.4.30.0109030507190.8867-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Sep 2001, Keith Owens wrote:

> -ac4 added to arch/i386/kernel/setup.c::display_cacheinfo()
>         if (c->x86_vendor == X86_VENDOR_CENTAUR && (c->x86 == 6) &&
>                 (c->x86_model == 7) || (c->x86_model == 8)) {
>
> That should probably be
>
>         if (c->x86_vendor == X86_VENDOR_CENTAUR && (c->x86 == 6) &&
>                 ((c->x86_model == 7) || (c->x86_model == 8))) {

Agreed, well spotted.
The same change also went into 2.4.10pre3 and needs the same fix there.

regards,

Dave.
-- 
| Dave Jones.        http://www.suse.de/~davej
| SuSE Labs

