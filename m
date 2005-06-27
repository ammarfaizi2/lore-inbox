Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261803AbVF0Ev4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261803AbVF0Ev4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 00:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261805AbVF0Ev4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 00:51:56 -0400
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:57873 "EHLO
	ninja.slaphack.com") by vger.kernel.org with ESMTP id S261803AbVF0Evv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 00:51:51 -0400
Message-ID: <42BF85DD.6030202@slaphack.com>
Date: Sun, 26 Jun 2005 23:51:41 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050325)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
Cc: Lincoln Dale <ltd@cisco.com>, Gregory Maxwell <gmaxwell@gmail.com>,
       Hans Reiser <reiser@namesys.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
References: <200506240241.j5O2f1eb005609@laptop11.inf.utfsm.cl> <42BCD93B.7030608@slaphack.com> <200506251420.j5PEKce4006891@turing-police.cc.vt.edu> <42BDA377.6070303@slaphack.com> <200506252031.j5PKVb4Y004482@turing-police.cc.vt.edu> <42BDC422.6020401@namesys.com> <42BE3645.4070806@cisco.com> <e692861c05062522071fe380a5@mail.gmail.com> <42BE563D.4000402@cisco.com> <42BE5DB6.8040103@slaphack.com> <200506261816.j5QIGMdI010142@turing-police.cc.vt.edu> <42BF08CF.2020703@slaphack.com> <200506262105.j5QL5kdR018609@turing-police.cc.vt.edu> <42BF2DC4.8030901@slaphack.com> <200506270040.j5R0eUNA030632@turing-police.cc.vt.edu>            <42BF667C.50606@slaphack.com> <200506270427.j5R4RYiO004629@turing-police.cc.vt.edu>
In-Reply-To: <200506270427.j5R4RYiO004629@turing-police.cc.vt.edu>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Valdis.Kletnieks@vt.edu wrote:
> On Sun, 26 Jun 2005 21:37:48 CDT, David Masover said:
> 
> 
>>>Go read http://www.tux.org/lkml/#s7-7 and ponder until enlightenment arrives.
>>
>>So what?  I don't intend to convince anyone based on how much
>>slower/faster their kernel compiles.  It's meant to illustrate the
>>principle of the thing.
> 
> 
> No, you seemed convinced that you'd have a big win based on the fact that
> big chunks don't get unpacked - when in fact it's not as much of a win as
> you might think.

Not in this case.

> And at least in the real world, performance *does* matter - if doing it the
> traditional way is 3 times faster, nobody's going to be interested.

Not true.  I've said it before, and I'll say it again:

http://www.apple.com/macosx/features/spotlight/

Users *are* willing to trade speed for features, under the right
circumstances.  Tiger *is* noticeably slower.  People *do* make
webservers out of it anyway.

Or, for an extreme example:

http://www.doom3.com/

Doom 3 can be made to run on much older hardware (the Voodoo3, I think),
by disabling things like the dynamic lighting.  The old way of doing
lighting is probably more than 3 times faster, I know it's more than
twice as fast.  The new way looks much, much better, and many people
upgraded their hardware -- at least a couple hundred dollars upgrade,
sometimes an entirely new box -- in order to play this game.

For that matter, the old way of doing this kind of discussion is email,
the new way seems to be a PHP Wiki, which has got to be more of a load
on the server, but people use it anyway.

In the real world, killer features trump performance.

All of this is irrelevent.  The performance isn't that bad.  It may even
be better, even if it's not *much* better.

>>Besides, your point was that you could not run make inside of a kernel
>>tarball/zipfile.  Nobody ever suggested that you would actually want to.
> 
> 
> "Here's a new facility.  Don't bother trying to actually use it".

Not the facility.  The specific example.

> Is that the message you're trying to send?

I'm lacking a little imagination right now.  It's Sunday night, after all.

Actually, I think it might be a big win for Debian-like package
management systems.  That's also somewhere in the "Silent Semantic"
archives.

Here's another, somewhat better example:  modifying a zisofs CD image.
I'm going to go reply to your other mail now; I think the details belong
there.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQr+F3XgHNmZLgCUhAQJWDA/+NmbL7kCANpEEeV+4zKx3MUmABuoRRo6Y
hbRPDlBk9PCPM8GWQx+XwRh4XXb17FQklP7oIJHnnGtQelwDtcvbX8bSsDUTPd3s
Gt8a11GMAJkGcPAHh2oBtlGjslJj7O/eJRlj3eeYv5LIRxq/KEfvBt0wvx2W73uN
d8Mm65baeq7ipWDqKf0yQTcJT8M8kQQczO5gb9E5Q68fL+8rO7diQEOCm2A+Sp2G
rlKpvcQuhQ/P7IBOnX8ABUG4UphQfMqtICIwMmkLimLfjO+ID9pnO516K7O4erMI
Q2deFh6+KQ62Ngmokkh6GOu7VEmUD4XZubJpJknGWWBaKdCz12LsvHt2DeucKD5e
5mWi4oVwSInlxIRboso0CmRkoJZdEmqBJWFPtjXEtGGdufqJFySIHxPXpsqwRsa4
SuIIa2SK5vDXoc9URqKtPZtGkrGjG4VL1fxLNp9hD91hp+T5bLhsO+/8v2ZqfyRC
UvTKb9u3mqdu//UxJhhj0LTTjNv3eNc+2UQFhAg7uSpa7FZjV+nEvD5ZwlpimQL1
InDt+nd5wQWWQ+SfjbZNvdvE/XGfmMArT/Ik7tYv9LkSLp0ohwOVQw3fThPGY+BD
1SW0E5FLruAMh/cRl0mwIhDQ9CZO/jrKjRbueyC7CYFMjmyBLUxbt0vUIJqsB8rJ
P58IcgUaWFs=
=R57s
-----END PGP SIGNATURE-----
