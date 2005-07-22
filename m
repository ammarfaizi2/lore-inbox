Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262078AbVGVKyP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262078AbVGVKyP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 06:54:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262079AbVGVKyP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 06:54:15 -0400
Received: from mxfep01.bredband.com ([195.54.107.70]:35727 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S262078AbVGVKyN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 06:54:13 -0400
Message-ID: <42E0D1C2.8080703@stesmi.com>
Date: Fri, 22 Jul 2005 13:00:18 +0200
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bernd Eckenfels <ecki@lina.inka.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: a 15 GB file on tmpfs
References: <E1Dvusr-00048r-00@calista.eckenfels.6bone.ka-ip.net>
In-Reply-To: <E1Dvusr-00048r-00@calista.eckenfels.6bone.ka-ip.net>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira Milter 1.0.7; VAE 6.29.0.5; VDF 6.29.0.100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Bernd Eckenfels wrote:
> In article <200507201416.36155.naber@inl.nl> you wrote:
> 
>>The machine we plan to buy is a HP Proliant Xeon machine and I want to run a 
>>32 bit linux kernel on it (the xeon we want doesn't have the 64-bit stuff 
>>yet)
> 
> 
> You cant have 16GB of Memory with 32bit CPUs.

PAE

CONFIG_HIGMEM64G

Supports a 36bit address space, which Xeons do support.

That doesn't mean a program can access it, you still
have the same old limitations per process.

// Stefan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (MingW32)

iD8DBQFC4NHCBrn2kJu9P78RApKpAKCEUzgKKRY8VG8XIwlCBrTzWpE7LwCdGUss
bSM49ZnzRgFxJ4h0WF5Ulio=
=zwUX
-----END PGP SIGNATURE-----
