Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129344AbRBHW7S>; Thu, 8 Feb 2001 17:59:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129326AbRBHW67>; Thu, 8 Feb 2001 17:58:59 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:26129 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129277AbRBHW64>; Thu, 8 Feb 2001 17:58:56 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: DNS goofups galore...
Date: 8 Feb 2001 14:58:30 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <95v8am$k6o$1@cesium.transmeta.com>
In-Reply-To: <95ulrk$aik$1@forge.intermeta.de> <Pine.LNX.4.10.10102081346001.16513-100000@innerfire.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.10.10102081346001.16513-100000@innerfire.net>
By author:    Gerhard Mack <gmack@innerfire.net>
In newsgroup: linux.dev.kernel
>
> Thanklfully bind 9 barfs if you even try this sort of thing.
> 

Personally I find it puzzling what's wrong with MX -> CNAME at all; it
seems like a useful setup without the pitfalls that either NS -> CNAME
or CNAME -> CNAME can cause (NS -> CNAME can trivially result in
irreducible situations; CNAME -> CNAME would require a link maximum
count which could result in obscure breakage.)

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
