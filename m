Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932155AbVKFRGI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155AbVKFRGI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 12:06:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932137AbVKFRGI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 12:06:08 -0500
Received: from mailout01.sul.t-online.com ([194.25.134.80]:10973 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id S932169AbVKFRGF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 12:06:05 -0500
Message-ID: <436E37E8.3070807@t-online.de>
Date: Sun, 06 Nov 2005 18:05:44 +0100
From: Harald Dunkel <harald.dunkel@t-online.de>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pozsar Balazs <pozsy@uhulinux.hu>
CC: 333052@bugs.debian.org, Kay Sievers <kay.sievers@vrfy.org>,
       Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: Bug#333052: 2.6.14, udev: unknown symbols for ehci_hcd
References: <436CD1BC.8020102@t-online.de> <20051105173104.GA31048@vrfy.org> <20051105184802.GB25468@ojjektum.uhulinux.hu> <436DA120.9040004@t-online.de> <436E181D.6010507@t-online.de> <20051106152924.GB16987@ojjektum.uhulinux.hu>
In-Reply-To: <20051106152924.GB16987@ojjektum.uhulinux.hu>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigAFEA4EF0EA532F22C33CAFDC"
X-ID: G-d40ZZeweQhdl6nqhXUVolAKrUvF2oXOkj-jqOU2E-mXZrxm5M8QE
X-TOI-MSGID: b49c37c2-da3f-4acd-b295-ee59e79ede10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAFEA4EF0EA532F22C33CAFDC
Content-Type: multipart/mixed;
 boundary="------------050900040809070701040700"

This is a multi-part message in MIME format.
--------------050900040809070701040700
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Pozsar Balazs wrote:
> 
> Well, that's really wierd, It Should Work(tm) :)
> Did you apply both patches (Rusty's + mine), or only the latter?
> 

I hadn't seen Rusty's patch on Debian's bts, until you mentioned
it. I have applied both patches now, and rebooted twice: By now
it worked. But that's what I thought before.

> Could you send me debug output please? The first time I met the problem, 
> I used a modprobe wrapper which dumped /proc/modules and modprobe 
> stdout/stderr to a temp file.
> 
If the problem comes back then I will do.

> I would like to also mention, that my patch leaves a very little time 
> window open, but that's only a problem if module unloading is also 
> happening: after parsing /proc/modules, but before actually loading the 
> module, it is possible that an rmmod unloads (starts to unload) a 
> dependant module. But this does not affect booting.
> 
> 

Are there several modprobe's running in parallel? Or does modprobe
return SUCCESS while the kernel is still busy "making the module
usable somehow"?


Regards

Harri

--------------050900040809070701040700
Content-Type: application/x-tar;
 name="modprobe.patch.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="modprobe.patch.gz"

H4sICLEubkMAA21vZHByb2JlLnBhdGNoAJVUbW/TMBD+nP6KWyRY0sZt025sdBSGeJ1U9gk+
ICFFIXE6a6ld2Q5jvPx37uykrHtjWGlSn893z3NvjDFYqbKpORNSWGaVqg2bDidsrfneUGmx
HOH5WquvfFgEk/F4n9FzCOOns+nhbH8yHHcLBmM87w0Gg3tM3rCWjtlkD9LpLEWDT29YOz4G
Nn0yTZ7AgD4HcHzcg+DtyeIN9NFOkXlX5gilxVmuoV8LyXHXGxibaztD+agPH8TyzIJUFr5y
RNdIy0u45HYI8FrJXQtVLuoh9EeoftUszKFSay6jcETiUSsOEwh1GJNTUUG0c/VK7DEfTJN0
gqAP9pJp6lCjstPm0upLePwYjNXFau33CcVM5isew3wO4xh+kjpBP6lAWODfhbEmgcbwguCD
MGDPOP6ELsGZcPBZ4J10emSIZIH3OienVp1Hp58WCyQBXyTRcBobbH4LuBBkdM/FGHbmQIK4
N2gN7Nyr7/WCpbIKVGOPeoOHXgSMxIY78rxuhxjWhnv5VgBcHIOgv7k9h9wq4d3F/wkhZOFt
3v/HBJalbcw9HDBjGxY72zUSLlReCrkMY/j1C64ffpJ1dxx3RoLG1Jyvo9Q1VXzUSivNeUSd
8ldS1MrwaKuSuzOH0bVTK/l9HTt4IYlxP3P7qz7gTg90orlttIT0yLXOYbqXTLD/3de1ji9G
XEhYrLNvXK/ypSiSdo/GUGSEkgkUq5JcZmptyTqCwklAbbRQxTk2f6U0hwsOtVLnCQgJRY4R
F3bXAE0rkdfiB0Zw6PNTlZjJGm9mlah5hI7Yc/rnGpViQTlCpWe+Y5E911rpKHylmrp084am
B+w+MrszeGSwChLS8my2zDky/ja+pYp99LsQO0LIVi5JTKEmUn52lQpenn7++P7k9B0goLzW
PC8vidw515L7uebLSSwlBiCjHPS6Dve5yITMvHok+QUhghczD7GdTIlvdZpPKbH1FVoJbWxm
BQakF2z4f3A2kfEtaFwQgi4IdzjzQ+k29gzZM3z/IzfsWm7Yg3LDHpybO9BdTVkjCV5bhEGh
VqtcEuhKyDJrt9F2hFsplW63/gDRsBheowcAAA==
--------------050900040809070701040700--

--------------enigAFEA4EF0EA532F22C33CAFDC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDbjfuUTlbRTxpHjcRAqBVAJ9E5DM8q/nh2ALJvTZtQefGYk7W+QCeMAYG
GVBCeBsqx+dfONtdV3HatRA=
=I9cB
-----END PGP SIGNATURE-----

--------------enigAFEA4EF0EA532F22C33CAFDC--
