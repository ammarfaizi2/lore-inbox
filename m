Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129063AbQJaO3e>; Tue, 31 Oct 2000 09:29:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129069AbQJaO3Y>; Tue, 31 Oct 2000 09:29:24 -0500
Received: from tellus.thn.htu.se ([193.10.192.40]:34059 "EHLO thn.htu.se")
	by vger.kernel.org with ESMTP id <S129063AbQJaO3O>;
	Tue, 31 Oct 2000 09:29:14 -0500
Date: Tue, 31 Oct 2000 15:28:55 +0100 (CET)
From: Richard Torkar <ds98rito@thn.htu.se>
To: John R Lenton <john@grulic.org.ar>
cc: linux-kernel@vger.kernel.org
Subject: Re: oopsen in 2.4.0-pre9
In-Reply-To: <20001031094755.A1029@grulic.org.ar>
Message-ID: <Pine.LNX.4.21.0010311526550.1449-100000@toor.thn.htu.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

John R Lenton wrote:

> Several oops come up when using a lot of memory (using
> imagemagick on PIA00001.tif from photojournal.jpl.nasa.gov/tiff,
> on a 64MB machine, for example)
> 
> The weird thing is the oops happen *after* I've finished with
> imagemagick (or the gimp, or ...). In this particular situation
> netscape suddenly died, together with wmtime, and then the whole
> of X hung. I entered via the network, to find that xfs had died
> (explaining X's hanging), and as soon as I restarted X the whole
> box was gone. It still responded to pings, but even the active
> ssh session was dead and I couldn't get a new one.

I can only confirm your problem, but I use 128MB RAM.

When using "display PIA00001.tif" my computer starts swapping furiously
and then locks *hard*. Not even sysrq works and unfortunately in my case
no oops in messages...


Hmmmm, serious? Dunno...


/Richard
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE5/tcrUSLExYo23RsRAticAKDV+Id7DrSVq8soFQVgtXj5X7mFRACfcgCs
OgH+ITA+oafSn8QHuH9E43w=
=cEAp
-----END PGP SIGNATURE-----


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
