Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263957AbRFFSLD>; Wed, 6 Jun 2001 14:11:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263950AbRFFSKn>; Wed, 6 Jun 2001 14:10:43 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:28173 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S263804AbRFFSKn>; Wed, 6 Jun 2001 14:10:43 -0400
Date: Wed, 6 Jun 2001 20:09:33 +0200
From: Tomas Telensky <ttel5535@artax.karlin.mff.cuni.cz>
To: Harald Welte <laforge@gnumonks.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to know HZ from userspace?
Message-ID: <20010606200933.B16802@artax.karlin.mff.cuni.cz>
In-Reply-To: <20010530203725.H27719@corellia.laforge.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010530203725.H27719@corellia.laforge.distro.conectiva>; from laforge@gnumonks.org on Wed, May 30, 2001 at 08:37:25PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi!
> 
> Is there any way to read out the compile-time HZ value of the kernel?

Why simply #include <asm/param.h>?

	Tomas


> 
> I had a brief look at /proc/* and didn't find anything.
> 
> The background, why it is needed:
> 
> There are certain settings, for example the icmp rate limiting values,
> which can be set using sysctl. Those setting are basically derived from
> HZ values (1*HZ, for example).
> 
> If you now want to set those values from a userspace program / script in
> a portable manner, you need to be able to find out of HZ of the currently
> running kernel.
> 
> -- 
> Live long and prosper
> - Harald Welte / laforge@gnumonks.org               http://www.gnumonks.org/
> ============================================================================
> GCS/E/IT d- s-: a-- C+++ UL++++$ P+++ L++++$ E--- W- N++ o? K- w--- O- M- 
> V-- PS+ PE-- Y+ PGP++ t++ 5-- !X !R tv-- b+++ DI? !D G+ e* h+ r% y+(*)
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
