Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129771AbRAQXBY>; Wed, 17 Jan 2001 18:01:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130844AbRAQXBO>; Wed, 17 Jan 2001 18:01:14 -0500
Received: from 00-a0-24-71-59-48.bconnected.net ([209.53.17.43]:26354 "HELO
	00-a0-24-71-59-48.bconnected.net") by vger.kernel.org with SMTP
	id <S129771AbRAQXBE>; Wed, 17 Jan 2001 18:01:04 -0500
Date: Wed, 17 Jan 2001 14:44:37 -0800 (PST)
From: Jonathan Walther <djw@lineo.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Rick Jones <raj@cup.hp.com>, linux-kernel@vger.kernel.org
Subject: Re: [Fwd: [Fwd: Is sendfile all that sexy? (fwd)]]
In-Reply-To: <Pine.LNX.4.10.10101171428520.10628-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.3.96.1010117144315.10822A-100000@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----

They have it because they heard Linux had it and they wanted to do
well in the next round of Mindcraft-like benchmarks. (sendfile() that is)

Jonathan

On Wed, 17 Jan 2001, Linus Torvalds wrote:
> (I also had one person point out that BSD's have the notion of TCP_NOPUSH,
> which does almost what TCP_CORK does under Linux, except it doesn't seem
> to have the notion of uncorking - you can turn NOPUSH off, but apparently
> it doesn't affect queued packets. This makes it even less clear why they
> have the ugly sendfile)

-----BEGIN PGP SIGNATURE-----
Version: 2.6.3ia
Charset: noconv

iQCVAwUBOmYgVsK9HT/YfGeBAQGI7wP+OLEirJP8SEuBQuE5Rm8pMzsZxrLUI4Ei
Ilk4T8B8ZoVBjHfftPpX47ra8ZcmJu+pQWRGleVCUtjfqQS6JUPTaLC2PSJRurer
5+6tB1BOzzD31W7eAoZTtcn1rQvhkG3agoXo5MWM4hVrqUoI5hv+L/qUiKlXqIyq
dZD5e7aITDs=
=OzuY
-----END PGP SIGNATURE-----

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
