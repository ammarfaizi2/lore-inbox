Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932350AbVIKOHM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932350AbVIKOHM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 10:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932260AbVIKOHL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 10:07:11 -0400
Received: from mxfep01.bredband.com ([195.54.107.70]:26524 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S932280AbVIKOHK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 10:07:10 -0400
Message-ID: <43243BDC.7020309@stesmi.com>
Date: Sun, 11 Sep 2005 16:14:52 +0200
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stephen Frost <sfrost@snowman.net>
CC: Andi Kleen <ak@suse.de>, Jim Gifford <maillist@jg555.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Pure 64 bootloaders
References: <43228E4E.4050103@jg555.com> <p73k6hp2up7.fsf@verdi.suse.de> <20050911115327.GZ6026@ns.snowman.net>
In-Reply-To: <20050911115327.GZ6026@ns.snowman.net>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira Milter 1.0.7; VAE 6.29.0.5; VDF 6.29.0.100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi.

>>Jim Gifford <maillist@jg555.com> writes:
>>
>>>I have been working on a project to create a Pure 64 bit distro of
>>>linux, nothing 32 bit in the system. I can accomplish that with no
>>
>>Hopefully you're using /lib64 for that, otherwise your
>>packages will be incompatible to everybody else and not 
>>FHS compliant. If you don't please don't submit any 
>>patches to hardcode this to upstream packages.
> 
> 
> /lib64 sucks, as mentioned, and I thought FHS only required that the
> linker be in /lib64.  Thus, the actual libraries could be pretty much
> anywhere (as it should be, really).  Debian-amd64 uses a symlink from
> /lib64 to /lib and provides the 64bit libraries and linker in /lib (but
> when actually compiling does link binaries through /lib64 for FHS
> compliance).
> 
> Hopefully /lib64, et al, will die and multiarch will happen soon.

How exactly would multiarch support work then?

// Stefan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (MingW32)

iD8DBQFDJDvcBrn2kJu9P78RAk9/AJ9KkdDxnqQmRSonntRZBqONlMH2pgCfQpH/
FDhtQSwqDrBzrQUb6/5YeOs=
=fEv6
-----END PGP SIGNATURE-----
