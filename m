Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271187AbRHONvj>; Wed, 15 Aug 2001 09:51:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271192AbRHONv3>; Wed, 15 Aug 2001 09:51:29 -0400
Received: from athena.intergrafix.net ([206.245.154.69]:4828 "HELO
	athena.intergrafix.net") by vger.kernel.org with SMTP
	id <S271187AbRHONvQ>; Wed, 15 Aug 2001 09:51:16 -0400
Date: Wed, 15 Aug 2001 09:51:29 -0400 (EDT)
From: Admin Mailing Lists <mlist@intergrafix.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.8 Resource leaks + limits
In-Reply-To: <3B7A0F01.DC4CAE4@pobox.com>
Message-ID: <Pine.LNX.4.10.10108150949160.9584-100000@athena.intergrafix.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


i would think to put global limits in /proc or in a flat text /etc
and per user limits in something like /etc/passwd or /etc/shadow?
Is it against any standard to have extra fields in those files?

-Tony
.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-.
Anthony J. Biacco                       Network Administrator/Engineer
thelittleprince@asteroid-b612.org       Intergrafix Internet Services

    "Dream as if you'll live forever, live as if you'll die today"
http://www.asteroid-b612.org                http://www.intergrafix.net
.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-.

On Tue, 14 Aug 2001, J Sloan wrote:

> dmaynor@iceland.oit.gatech.edu wrote:
> 
> > > This is why you mainly find per-process stuff in all the limits.
> > >
> > > Linux has had (for a while now) a "struct user" that is actually quickly
> > > accessible through a direct pointer off every process that is associated
> > > with that user, and we could (and _will_) start adding these kinds of
> > > limits. However, part of the problem is that because the limits haven't
> > > historically existed, there is also no accepted and nice way of setting
> > > the limits.
> > So when you do impose this, where will it be setable, will there be a flat file in /etc
> > like solaris, or compile time for the kernel?
> 
> Eh?
> 
> Why wouldn't it be like most parameters in Linux,
> e.g. dynamically adjustable via a sysctl or /proc?
> 
> IMHO, of course...
> 
> cu
> 
> jjs
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

