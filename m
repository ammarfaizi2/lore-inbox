Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316226AbSEVQLw>; Wed, 22 May 2002 12:11:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316227AbSEVQKe>; Wed, 22 May 2002 12:10:34 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:16656 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316226AbSEVQKQ>; Wed, 22 May 2002 12:10:16 -0400
Date: Wed, 22 May 2002 09:09:42 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Pavel Machek <pavel@suse.cz>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@zip.com.au>,
        Rusty Russell <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>
Subject: Re: AUDIT: copy_from_user is a deathtrap.
In-Reply-To: <20020522141306.GB29028@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.44.0205220909090.7580-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 22 May 2002, Pavel Machek wrote:
> >
> > Its festering quietly in the glibc source tree where all large and
> > dubiously justifiable hacks seem to end up
>
> In such case, linus, here is your "reasonable" example. For PPro, it
> is faster to copy out-of-order, and if we wanted to use that for
> copy_to_user, you'd have your example.

Hey, you didn't read Alan's email.

The fact that glibc may use it is a strike _against_ your example.

Have you looked at glibc performance lately?

		Linus

