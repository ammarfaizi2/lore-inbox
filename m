Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131420AbRCWUPm>; Fri, 23 Mar 2001 15:15:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131415AbRCWUPc>; Fri, 23 Mar 2001 15:15:32 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:40204 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131414AbRCWUPQ>; Fri, 23 Mar 2001 15:15:16 -0500
Date: Fri, 23 Mar 2001 12:14:10 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Version 6.1.8 of the aic7xxx driver availalbe 
In-Reply-To: <200103230131.f2N1Uos09088@aslan.scsiguy.com>
Message-ID: <Pine.LNX.4.31.0103231159300.766-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 22 Mar 2001, Justin T. Gibbs wrote:
>
> 	aic7xxx_proc.c:
> 		Use an unsigned long for total number of commands
> 		sent to a device.  %q and %lld don't seem to work
> 		under Linux or I'd have used a uint64_t.

It's "%Ld".

Think ANSI "long long double" -> "Lf".

Thus "long long int" -> "Ld".

I know it's at least been discussed for ANSI C9X, although I have no idea
if it actually caught on.

		Linus

