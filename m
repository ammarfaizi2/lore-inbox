Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752121AbWCOQUJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752121AbWCOQUJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 11:20:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752127AbWCOQUJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 11:20:09 -0500
Received: from rwcrmhc11.comcast.net ([204.127.192.81]:54215 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1752121AbWCOQUH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 11:20:07 -0500
Message-ID: <44183E75.3080406@comcast.net>
Date: Wed, 15 Mar 2006 11:19:01 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mail/News 1.5 (X11/20060309)
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: ORMAP
References: <44178429.90808@comcast.net> <44180784.6020608@yahoo.com.au>
In-Reply-To: <44180784.6020608@yahoo.com.au>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Nick Piggin wrote:
> John Richard Moser wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> And looking through the recent discussions I see in one thread...
>>
>> Willy Tarreau wrote:
>>
>>
>>> It depends a lot on what people do with it in fact. For instance, it
>>> works better in memory-constrained systems, probably thanks to rmap.
>>> I have one 2.6 running reliably on my web server (hppa) where 2.4
>>> regularly oopsed because of low memory.
>>
>>
>>
>> This reminds me, what the hell ever happened to ORMAP?  That object
>> based rmap thingy I tried out in one of wli's patches made my system
>> boot like 3 times faster.  There were other cool things going on that I
>> never got to try too, never saw that all out to fruition.
>>
>> Status on some of the elements in the old 2.6-wli series from around
>> there would be nice.  I'm curious as to what has gone in.
>>
> 
> 2.6 has an object based rmap system working nicely for quite
> a while now (though it was probably not exactly what you saw
> in the -wli tree, but a derivative).
> 
> It would be surprising if that made your system boot 3 times
> faster though (unless it was on the edge of a swap storm or
> something)

Dramatization.  It was probably around 30 seconds faster on a 2-3 minute
boot sequence (I had a lot in rc.d), but it was noticeable :P

I was wondering about that stuff.  There used to be a few cute things
out there but I can't remember any of it now.  Page clustering etc etc.

> 

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

    Creative brains are a valuable, limited resource. They shouldn't be
    wasted on re-inventing the wheel when there are so many fascinating
    new problems waiting out there.
                                                 -- Eric Steven Raymond

    We will enslave their women, eat their children and rape their
    cattle!
                                     -- Evil alien overlord from Blasto
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQIVAwUBRBg+dAs1xW0HCTEFAQIXyBAAhdWBblyl3Ao+F3pS5IxDxYiPeZzMfVzG
zAacNT77huYYY748DDQgXJvpEGvgCqWtiaHgI0PpZoSLWytzcIr4TjXcMrwC1bcD
yGuV6C9pYnjwyaqhaCs11DAOduXGsMf6gSERp1Q3oFnT3x42wLpmHQtAZD4eOmxF
q6P1RxYTkF2Tgnu3pQOTvTgTziUUPEXt1ZQwocshZGuAHrsDM846DHjw7fwmCu4w
2nGVPJmHsqyZ6savimstzBoLKLAQs+7+hIeb/YJP46NrLa5VbJRLUfKqBoOH/PCs
U7NS8qj5Gvq4YsDd5NAzT8ALiW66EBWQKdi3/SAkeu+JE28CjWzHiLEb4G+sosGV
AWLdgzY6HthlNoM9/zasDRrHvcL8reCrTTBMngvyT7NWMm5qzzEOq7y9k24gMBbp
EGdk7Tol4hSxinuhH2lur8It1rXaMVyOiBflrqXNvwKfbxXG1FXQifCNTQiAvMoc
LjyDC2V7Eqx22ZEy5X/Gj5b3Ah9oOnLrWsCAsl7K2XTKg+CRUOrQ4NKzGbbFxb4f
QumTcq60qmUei0AcGMze8grQGi0JotQ0CpcXTvIYujPFJzJ6kRu4NC8kMst3RUMg
MFXLnzrCNOMvTnVuA2t8MqXkeaWKUvm8qQbJChcsKV/RIGbW8JeWoM2+xIXhbOx1
Kv8Mw4ch8lU=
=k6aR
-----END PGP SIGNATURE-----
