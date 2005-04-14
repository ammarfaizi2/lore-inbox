Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261553AbVDNRKU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261553AbVDNRKU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 13:10:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261556AbVDNRKU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 13:10:20 -0400
Received: from vsmtp2alice.tin.it ([212.216.176.142]:40371 "EHLO vsmtp2.tin.it")
	by vger.kernel.org with ESMTP id S261553AbVDNRJn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 13:09:43 -0400
Message-ID: <425EA2AD.3050309@tin.it>
Date: Thu, 14 Apr 2005 12:04:45 -0500
From: "Franco \"Sensei\"" <senseiwa@tin.it>
Reply-To: Sensei <senseiwa@tin.it>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041207 Thunderbird/1.0 Mnenhy/0.7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Krzysztof Halasa <khc@pm.waw.pl>
CC: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
Subject: Re: [INFO] Kernel strict versioning
References: <4256C89C.4090207@tin.it> <20050408190500.GF15688@stusta.de>	<425B1E3F.5080202@tin.it> <20050412015018.GA3828@stusta.de>	<425B3864.8050401@tin.it> <m3mzs4kzdp.fsf@defiant.localdomain>	<425C03D6.2070107@tin.it> <m37jj7hctl.fsf@defiant.localdomain>
In-Reply-To: <m37jj7hctl.fsf@defiant.localdomain>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig9C8578B48CA0071C4C2C1B8C"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9C8578B48CA0071C4C2C1B8C
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Krzysztof Halasa wrote:
> Yes, but you still can't change .config. You enable SMP, your binary
> compatibility is history. You _have_to_ be able to enable SMP and
> _you_have_ to be able to disable it.
> 
> The following kernel packages are parts of Fedora Core 3:
> kernel-2.6.9-1.667.i586.rpm
> kernel-2.6.9-1.667.i686.rpm
> kernel-smp-2.6.9-1.667.i586.rpm
> kernel-smp-2.6.9-1.667.i686.rpm

That's because SMP makes a different architecture. So, let's not talk 
about SMP, beacuse it's not a problem.

> 4 of them, each with a different ABI. And this is all the same kernel
> major-minor-version-subversion and the same compiler - only the settings
> differ.

Of course. When upgrading to kernel-2.6.10.i586.rpm? Why should you 
screw up the modules you've compiled? They all belong to 2.6 series.

> Being modular has nothing to do with the "problem" (except it's probably
> required, but Linux _is_ modular for some time now).

It gives more freedom to change the implementation resulting in a easy 
mantainance. Modularity make things easy... little things that work, 
isn't it a unix motto? :)

> Not "can". You have to. You don't want the kernel running on your dual
> Athlon MP to power your old Pentium MMX test machine. The modules are
> irrelevant.

Why always SMP! You are talking about porting a SPARC kernel on a 386! 
I'm talking about having the same binary kernel distribution for your 
achitecture, let's say i586, and being able to upgrade the kernel 
without hassles. No person on earth can imagine using a kernel for 
x86_64 on a i486! :)

> You can have it in /boot. In fact, it's not a kernel issue.

I know, I was just wondering why kernel and modules were on different 
locations.

> Actually, because boot can be a small partition, and may lack support
> for, say, long filenames.
> Actually, I put the kernels in /lib/modules/* as well. I have no /boot
> file systems and I like the idea of rm -rf /lib/modules/something
> deleting all files related to a particular kernel.

I always use a /boot partition. Anyway, /boot will always exist as /lib, 
and you can always do a rm -rf /boot/kernel/modules :)

-- 
Sensei <mailto:senseiwa@tin.it> <pgp:8998A2DB>
        <icqnum:241572242>
        <yahoo!:sensei_sen>
        <msn-id:sensei_sen@hotmail.com>

--------------enig9C8578B48CA0071C4C2C1B8C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCXqKx4LBKhYmYotsRAsR2AJ9xb4YppnxynDyNsLDdcGtM1rVi9ACghs6G
V6XepiBdaHT6725dfRffLJ8=
=q3u4
-----END PGP SIGNATURE-----

--------------enig9C8578B48CA0071C4C2C1B8C--
