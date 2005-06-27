Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261882AbVF0GLy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261882AbVF0GLy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 02:11:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261859AbVF0GHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 02:07:09 -0400
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:28421 "EHLO
	ninja.slaphack.com") by vger.kernel.org with ESMTP id S261844AbVF0GCm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 02:02:42 -0400
Message-ID: <42BF9676.1010702@slaphack.com>
Date: Mon, 27 Jun 2005 01:02:30 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050325)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>
Cc: Valdis.Kletnieks@vt.edu, Lincoln Dale <ltd@cisco.com>,
       Gregory Maxwell <gmaxwell@gmail.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
References: <200506240241.j5O2f1eb005609@laptop11.inf.utfsm.cl> <42BCD93B.7030608@slaphack.com> <200506251420.j5PEKce4006891@turing-police.cc.vt.edu> <42BDA377.6070303@slaphack.com> <200506252031.j5PKVb4Y004482@turing-police.cc.vt.edu> <42BDC422.6020401@namesys.com> <42BE3645.4070806@cisco.com> <e692861c05062522071fe380a5@mail.gmail.com> <42BE563D.4000402@cisco.com> <42BE5DB6.8040103@slaphack.com> <200506261816.j5QIGMdI010142@turing-police.cc.vt.edu> <42BF08CF.2020703@slaphack.com> <200506262105.j5QL5kdR018609@turing-police.cc.vt.edu> <42BF2DC4.8030901@slaphack.com> <200506270040.j5R0eUNA030632@turing-police.cc.vt.edu>            <42BF667C.50606@slaphack.com> <200506270427.j5R4RYiO004629@turing-police.cc.vt.edu> <42BF89F6.3020200@namesys.com>
In-Reply-To: <42BF89F6.3020200@namesys.com>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hans Reiser wrote:
> Valdis.Kletnieks@vt.edu wrote:
> 
> 
>>>tarball/zipfile.  Nobody ever suggested that you would actually want to.
>>>   
>>>
>>
>>Besides, your point was that you could not run make inside of a kernel
>>
> 
> Umm, try it when we have it working, on a 1-4GB RAM machine it might not
> be so bad.....  We have the compression (albeit still with bugs) but not
> the tar plugin.

We *desperately* need either more plugin-like "plugins" or a FUSE-like
way of writing plugins.  I mean, tar is small enough, but I don't want
you chipping away at my (soon-to-be) 2 gigs of desktop RAM -- I need
that for Doom 3!

Or, do you mean using the RAM for keeping the working copy of the
zipfile?  And here I was trying to establish that it was better to cache
this.  If the cache appears as a separate Reiser tree, it's not much
different than keeping it in RAM anyway, but it can be flushed if I need
the space for... work... ;)

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQr+WdngHNmZLgCUhAQLYrw//V8z1ywRTyXk7zaHU+COPO2PCV8kKXtWJ
7BkDXm65cVCUVNN6hgiJxMGEx7fe8ZWNJRHhvdIWGt5G68qI6G0F/tYQajtT59mk
E7AF2WWJ2ip0E0WKzBVVYKYnaeB+w9rF/8RJ/0Zj7C3zQ+fzvmVCGw6y9bLWYQle
VCUYjSMKaQz1cU4RqtDd+pIgr9w5/kxfhd30Aj9nK2qaQZLSxeFTv7p9c2vW5ZwM
YeQG8K4EZ0gO1GH0e85BAa9McLnDurosxeeLumaPqbIbFzc+1YXy9+5PsXjPKGDN
IjKVm/R0HpPP9KpCLdpRvp3GyWz1EuYSp9zpUEh5mDPH/gOSgRCva3Vx/2TW+YTk
3U73tHbTI5b9Mf/dlK3GPAoJ1krRm83sNMMAyGaTv+n6kRVWaSWIelZrVEJ5/jHO
pgY+5mDJwROlXdDqO1CV9PJHx4DivyODOrKzFnIykfQ2MO1vs1+Fy94LyYGkrPGd
Nq6y6XGxjx5MZ1fX3vJfovX0z+eR9s3R1uIgCMXlVoELEh9XKoFGGWIhrb7MhUdK
Q+n2ljixMZhIakeEUflhycZw0CY8jlgTK+vULUS7mDhOExVxombdAalVhhQ3cK0+
ZasRPyS3A3mCE7U6AKt8oc1AjRpdNIR1YKmfh+C44Yy+2e2wIWAoIb4mg0uY6jEa
GJl0uZIj4rY=
=uAm0
-----END PGP SIGNATURE-----
