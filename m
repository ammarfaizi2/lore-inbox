Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132164AbQLND2y>; Wed, 13 Dec 2000 22:28:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132220AbQLND2p>; Wed, 13 Dec 2000 22:28:45 -0500
Received: from smtp03.mrf.mail.rcn.net ([207.172.4.62]:24268 "EHLO
	smtp03.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id <S132164AbQLND2e>; Wed, 13 Dec 2000 22:28:34 -0500
Date: Wed, 13 Dec 2000 21:58:06 -0500 (EST)
From: "Mohammad A. Haque" <mhaque@haque.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: test12 lockups -- need feedback
In-Reply-To: <3A3804CA.E07FDBB1@haque.net>
Message-ID: <Pine.LNX.4.30.0012132157020.1272-100000@viper.haque.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, got locked up. Dropped me into kdb and I was able to write down the
oops after doing a ss on btp 0.

I'll try to have something posted in an hour.

On Wed, 13 Dec 2000, Mohammad A. Haque wrote:

> At first I thought it was just me when I reported the lockups I was
> having with test12 earlier this week. Now the reports are flooding. Of
> course, now my machine isn't locking up anymore after recompiling from a
> clean source tree (test5 w/ patches through test12)
>
> Now, I'm trying to determine what the common element is.
>
> Those of you who are having lockups, was test12 compiled from a patched
> tree that you've previously compiled?
>
> Those that are locking up in X. Do you have a second machine you can
> hook up via serial port to grab Oops output?
>
> I've got KDB compiled in my current kernel. I'll compile a fresh kernel
> without KDB and see how long I last when I get a chance.
>

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
