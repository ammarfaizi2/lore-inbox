Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262420AbVCVFp2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262420AbVCVFp2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 00:45:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262387AbVCVFnE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 00:43:04 -0500
Received: from 1-1-10-11a.has.sth.bostream.se ([82.182.131.18]:64465 "EHLO
	DeepSpaceNine.stesmi.com") by vger.kernel.org with ESMTP
	id S262420AbVCVFiO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 00:38:14 -0500
Message-ID: <423FAF21.90108@stesmi.com>
Date: Tue, 22 Mar 2005 06:37:37 +0100
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Phillip Lougher <phillip@lougher.demon.co.uk>
CC: Pavel Machek <pavel@suse.cz>, Paulo Marques <pmarques@grupopie.com>,
       Andrew Morton <akpm@osdl.org>, greg@kroah.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2/2] SquashFS
References: <20050314170653.1ed105eb.akpm@osdl.org> <A572579D-94EF-11D9-8833-000A956F5A02@lougher.demon.co.uk> <20050314190140.5496221b.akpm@osdl.org> <423727BD.7080200@grupopie.com> <20050321101441.GA23456@elf.ucw.cz> <423EEEC2.9060102@lougher.demon.co.uk> <20050321190044.GD1390@elf.ucw.cz> <423F0C67.6000006@lougher.demon.co.uk> <20050321224937.GQ1390@elf.ucw.cz> <423F9256.10606@lougher.demon.co.uk>
In-Reply-To: <423F9256.10606@lougher.demon.co.uk>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira Milter 1.0.7; VAE 6.29.0.5; VDF 6.29.0.100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi.

> I have agreed to drop V1.0 support, and yes (as explained in another
> emauil), breaking the 4GB limit does involve on-disk format change.

I've only also been reading this thread with half an eye but :

Would it be possible (in some logical timeframe) to change the
filesystem's on-disk format to support larger sizes without
actually changing the rest of the code?

I don't know where the 4GB limit comes from in this case but if you
would change the on-disk format, the format itself, then I would
think it would make it easier to swallow the filesystem and then
when it's in the kernel you can actually make it support more
than 4GB.

Then there at least wouldn't need to be a switch in the format
when it's in the kernel.

Just my thought - just feels like it might make it included faster.

And hell, if it's not possible, just ignore what I wrote.

// Stefan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (MingW32)

iD8DBQFCP68hBrn2kJu9P78RAoGVAJ9a2cjFAv6NW8qyd336wEK5VcJf7gCfV5Oc
gswa6cSH7o3ND+lse64LLxI=
=D8rp
-----END PGP SIGNATURE-----
