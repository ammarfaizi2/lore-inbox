Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129759AbQLGI13>; Thu, 7 Dec 2000 03:27:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129413AbQLGI1T>; Thu, 7 Dec 2000 03:27:19 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:21776 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129319AbQLGI1N>; Thu, 7 Dec 2000 03:27:13 -0500
Date: Wed, 6 Dec 2000 02:29:47 -0500 (EST)
From: "Mike A. Harris" <mharris@opensourceadvocate.org>
To: Rusty Russell <rusty@linuxcare.com.au>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ipchains log will show all flags 
In-Reply-To: <20001206004022.B8AAC813F@halfway.linuxcare.com.au>
Message-ID: <Pine.LNX.4.30.0012060226360.620-100000@asdf.capslock.lan>
X-Unexpected-Header: The Spanish Inquisition
Copyright: Copyright 2000 by Mike A. Harris - All rights reserved
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Dec 2000, Rusty Russell wrote:

>Date: Wed, 06 Dec 2000 11:40:12 +1100
>From: Rusty Russell <rusty@linuxcare.com.au>
>To: Mike A. Harris <mharris@opensourceadvocate.org>
>Cc: linux-kernel@vger.kernel.org
>Subject: Re: [PATCH] ipchains log will show all flags
>
>In message <Pine.LNX.4.30.0012051058090.620-100000@asdf.capslock.lan> you write
>:
>> Personally, I'd like to see the rule number stay on the end,and
>> have the new display just before it.  The rule number in the
>> middle looks messy.
>
>But what will break people's perl scripts?
>
>I think leaving the rule number at the end is probably the Right Thing
>from this point of view, so that would be a nice change.

I am of the camp "do it right, and fix problems that arise"
rather than doing things messy and/or kludgy in the name of
compatibility.

I'd rather see such a feature not get in than to see it get in as
a kludge that is permanent.

>But I prefer the compressed form of `-----' (with the old `SYN' kept
>there) to the "SYN FIN RST" alternative.

I prefer the SYN to disappear and be replaced with the new way
IMHO.  It'd be nice to see netfilter do this as well if it
doesn't already do similar.  2.4.0 isn't released yet, so
changing it now is safe IMHO.

Just some more food for thought...

Anyone?


----------------------------------------------------------------------
      Mike A. Harris  -  Linux advocate  -  Open source advocate
          This message is copyright 2000, all rights reserved.
  Views expressed are my own, not necessarily shared by my employer.
----------------------------------------------------------------------

If it weren't for C, we'd all be programming in BASI and OBOL.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
