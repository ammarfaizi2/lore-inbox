Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129059AbRBIACD>; Thu, 8 Feb 2001 19:02:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129041AbRBIABx>; Thu, 8 Feb 2001 19:01:53 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:51716 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129115AbRBIABh>; Thu, 8 Feb 2001 19:01:37 -0500
Message-ID: <3A83335A.A5764CD7@transmeta.com>
Date: Thu, 08 Feb 2001 16:01:30 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: "Michael H. Warfield" <mhw@wittsend.com>
CC: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: DNS goofups galore...
In-Reply-To: <95ulrk$aik$1@forge.intermeta.de> <Pine.LNX.4.10.10102081346001.16513-100000@innerfire.net> <95v8am$k6o$1@cesium.transmeta.com> <20010208183232.A1642@alcove.wittsend.com> <3A833005.5C8E0D81@transmeta.com> <20010208185449.B1642@alcove.wittsend.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> > Wouldn't that be true for any CNAME anyway?
> 
>         That's the point...
> 
>         In other words, you do a lookup, you start with a primary lookup
> and then possibly a second lookup to resolve an MX or CNAME.  It's only
> the MX that points to a CNAME that results in yet another lookup.  An
> MX pointing to a CNAME is almost (almost, but not quite) as bad as a
> CNAME pointing to a CNAME.
> 

There is no reducibility problem for MX -> CNAME, unlike the CNAME ->
CNAME case.

Please explain how there is any different between an CNAME or MX pointing
to an A record in a different SOA versus an MX pointing to a CNAME
pointing to an A record where at least one pair is local (same SOA).

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
