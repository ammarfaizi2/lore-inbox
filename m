Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752114AbWAEImM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752114AbWAEImM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 03:42:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752113AbWAEImM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 03:42:12 -0500
Received: from mxfep02.bredband.com ([195.54.107.73]:46528 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S1752110AbWAEImK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 03:42:10 -0500
Message-ID: <43BCDBD5.8090601@stesmi.com>
Date: Thu, 05 Jan 2006 09:41:57 +0100
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Jan Engelhardt <jengelh@linux01.gwdg.de>, Peter Bortas <bortas@gmail.com>,
       =?UTF-8?B?VG9tYXN6IEvFgm9jemtv?= <kloczek@rudy.mif.pg.gda.pl>,
       Adrian Bunk <bunk@stusta.de>, Jesper Juhl <jesper.juhl@gmail.com>,
       Takashi Iwai <tiwai@suse.de>, Olivier Galibert <galibert@pobox.com>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>, Andi Kleen <ak@suse.de>,
       perex@suse.cz, alsa-devel@alsa-project.org, James@superbug.demon.co.uk,
       sailer@ife.ee.ethz.ch, linux-sound@vger.kernel.org, zab@zabbo.net,
       kyle@parisc-linux.org, parisc-linux@lists.parisc-linux.org,
       jgarzik@pobox.com, Thorsten Knabe <linux@thorsten-knabe.de>,
       zwane@commfireservices.com, zaitcev@yahoo.com,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
References: <200601031522.06898.s0348365@sms.ed.ac.uk>	 <s5hvex1m472.wl%tiwai@suse.de>	 <9a8748490601031256x916bddav794fecdcf263fb55@mail.gmail.com>	 <20060103215654.GH3831@stusta.de> <20060103221314.GB23175@irc.pl>	 <20060103231009.GI3831@stusta.de>	 <Pine.BSO.4.63.0601040048010.29027@rudy.mif.pg.gda.pl>	 <43BB16C0.3080308@stesmi.com>	 <Pine.BSO.4.63.0601040146540.29027@rudy.mif.pg.gda.pl>	 <43BB9A0B.3010209@stesmi.com>	 <7e5f60720601041903s3462bf9bib9ada16fe70ef988@mail.gmail.com>	 <Pine.LNX.4.61.0601050812040.10161@yvahk01.tjqt.qr> <1136445541.24475.21.camel@mindpipe>
In-Reply-To: <1136445541.24475.21.camel@mindpipe>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/signed; micalg=pgp-ripemd160;
 protocol="application/pgp-signature";
 boundary="------------enig1380D3B53F873CBC322C01A0"
X-AntiVirus: checked by Vexira Milter 1.0.7; VAE 6.29.0.5; VDF 6.29.0.100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1380D3B53F873CBC322C01A0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi.

>>>No. Everything on Solaris uses the Solaris native sound API except for
>>>possibly quick-hack ports of applications from Linux. Doing anything
>>>else would as you say be insane and break things like device
>>>redirection on Sunrays.
>>>
>>
>>Device redirection is just "writing to a different /dev node" - on
>>Solaris and Linux. IIRC, the API is the same.
> 
> This whole "OSS is cross platform" thing seems mostly like a cop out by
> lazy developers who can't be bothered to grok ALSA.  None of the usual
> offenders (Skype, Quake 3, Doom 3) run on any other Unix platform so why
> not just use ALSA?
> 
> It does not help that the most problematic apps seem to be proprietary
> (most likely they are abusing the OSS API in a way that no one
> anticipated).

What's actually funny (well actually it's not) is that Doom3 for
instance works great using the OSS emul of ALSA but not using
native ALSA for some reason. I haven't reported it cause it's
a commercial program without source.

( The sound stutters all the time, and not just when moving, etc, but
all the time )

// Stefan

--------------enig1380D3B53F873CBC322C01A0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFDvNvcBrn2kJu9P78RA6FNAKC2MGFMefw4qpy/4BuJTtQ6r2mvTQCfW2ls
ooFhZHAMcrkbyuULhzbjOsI=
=RXzr
-----END PGP SIGNATURE-----

--------------enig1380D3B53F873CBC322C01A0--
