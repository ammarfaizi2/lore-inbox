Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264500AbTEaPrL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 11:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264510AbTEaPrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 11:47:10 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:4993 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S264500AbTEaPrE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 11:47:04 -0400
Date: Sat, 31 May 2003 17:06:21 +0100
From: john@grabjohn.com
Message-Id: <200305311606.h4VG6L8f000816@81-2-122-30.bradfords.org.uk>
To: chris@heathens.co.nz, davej@codemonkey.org.uk, hch@infradead.org,
       linux-kernel@vger.kernel.org, lm@bitmover.com
Subject: Re: coding style (was Re: [PATCH][2.5] UTF-8 support in console)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Saving a line over readability is utterly bogus.

> I agree 100%.  If you have anything more complex than
>
>         if (error) return (error);
>
> I want it to look like
>
>         if ((expr) || (expr2) || (expr3)) {
>                 return (error);
>         }

Ergh, personally I hate reading code like that.

Having said that, I hate code that is indented.  Am I the only person who mentally
counts, "in, in, in, out", etc, when reading code?  Artificial indenting really
throws off my concentration, because the 'prompting' it provides does nothing to
help me, but the ragged left margin is irritating, and makes moving code around
awkward, because you have to correct the indenting to match the current, (actual),
nesting level of the code, (because indenting is a completely artificial concept).

I'm not trying to say my coding style is right, and yours is wrong, I'm just curious
 :-).

John.
