Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129740AbQJaOdy>; Tue, 31 Oct 2000 09:33:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129213AbQJaOdg>; Tue, 31 Oct 2000 09:33:36 -0500
Received: from tellus.thn.htu.se ([193.10.192.40]:39435 "EHLO thn.htu.se")
	by vger.kernel.org with ESMTP id <S129740AbQJaOd2>;
	Tue, 31 Oct 2000 09:33:28 -0500
Date: Tue, 31 Oct 2000 15:33:16 +0100 (CET)
From: Richard Torkar <ds98rito@thn.htu.se>
To: John R Lenton <john@grulic.org.ar>
cc: linux-kernel@vger.kernel.org
Subject: Re: oopsen in 2.4.0-pre9
In-Reply-To: <20001031094755.A1029@grulic.org.ar>
Message-ID: <Pine.LNX.4.21.0010311532090.1566-100000@toor.thn.htu.se>
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
> 
> Please email me if you need anything else (other than the
> attached ksymoops output, that is).


Well some more info.

I see kswapd starting to run @ ~7% CPU.

But my swap starts getting eaten up with approx 5 MB/sec.

Any ideas anyone?

RvR something for you?


/Richard
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE5/tgvUSLExYo23RsRArxbAKCg6ADFyb6G2oKDMZT9m3mKqMF8awCggEBY
2RnARjaRDxqI7BCxaAGjr5M=
=tfT6
-----END PGP SIGNATURE-----


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
