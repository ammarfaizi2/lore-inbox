Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281214AbRLQQuV>; Mon, 17 Dec 2001 11:50:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281255AbRLQQuL>; Mon, 17 Dec 2001 11:50:11 -0500
Received: from pop.gmx.net ([213.165.64.20]:59224 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S281214AbRLQQuA>;
	Mon, 17 Dec 2001 11:50:00 -0500
Date: Mon, 17 Dec 2001 17:52:06 +0100
From: Sebastian =?ISO-8859-1?Q?Dr=F6ge?= <sebastian.droege@gmx.de>
To: Dave Jones <davej@suse.de>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: your mail
Message-Id: <20011217175206.193d02e0.sebastian.droege@gmx.de>
In-Reply-To: <Pine.LNX.4.33.0112171717010.28670-100000@Appserv.suse.de>
In-Reply-To: <20011217170740.74a1cb95.sebastian.droege@gmx.de>
	<Pine.LNX.4.33.0112171717010.28670-100000@Appserv.suse.de>
X-Mailer: Sylpheed version 0.6.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="=.Fd.uRJK)t83+S4"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.Fd.uRJK)t83+S4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

Ok...
2.4.16-2.4.17-rc1 works perfectly
2.5.0-2.5.1 works perfectly
Only 2.5.1-dj1 has this 2 errors (ISA-PnP non-detection and USB only root hub detection)
All have the same .config
If you need some more information feel free to ask me ;)

Bye

PS: 2.5.1 (dj1 or not ;) has one problem more on my pc:
INIT can't send the TERM signal to all processes...
Nothing happens... no error message no nothing
SysRQ works
I don't know when it went into 2.5 but I think it wasn't there in -pre10 (don't try -pre11)
PPS: What the hell is APIC (no I don't mean ACPI)? ;) I've enabled it on my UP machine but don't know what it does...
Does anyone have informations about it?

On Mon, 17 Dec 2001 17:22:14 +0100 (CET)
Dave Jones <davej@suse.de> wrote:

> On Mon, 17 Dec 2001, Sebastian Dröge wrote:
> 
> > Attached you find my .config, lspci -vvv and dmesg output
> > I'll test 2.4.17-rc1 in a few minutes and will report what happens ;)
> 
> Thanks. Right now getting 2.4 into a better shape is more
> important than fixing 2.5, so if you find any problems repeatable
> in 2.4.17rc1, Marcelo really needs to know about it.
> 
> The only USB changes in my tree are __devinit_p changes, which
> really shouldn't be causing a problem, but there could be some
> other unrelated-to-usb patch which is causing this..
> 
> 2.4 info would be appreciated.
> 
> Dave.
> 
> -- 
> | Dave Jones.        http://www.codemonkey.org.uk
> | SuSE Labs
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

--=.Fd.uRJK)t83+S4
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iD8DBQE8HiK8vIHrJes3kVIRAvdIAJsE4AK9YCjxWEHoFzM7l3uTFAj8qACgoOvT
vyt1nn/MuV/3AOM/WxDIZMY=
=+S85
-----END PGP SIGNATURE-----

--=.Fd.uRJK)t83+S4--

