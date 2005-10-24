Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751067AbVJXOKN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751067AbVJXOKN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 10:10:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751070AbVJXOKN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 10:10:13 -0400
Received: from mxfep01.bredband.com ([195.54.107.70]:43005 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S1751067AbVJXOKM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 10:10:12 -0400
Message-ID: <435CED7E.6000402@stesmi.com>
Date: Mon, 24 Oct 2005 16:19:42 +0200
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "J.A. Magallon" <jamagallon@able.es>
CC: jonathan@jonmasters.org, jonmasters@gmail.com,
       "Linux-Kernel," <linux-kernel@vger.kernel.org>
Subject: Re: /proc/kcore size incorrect ?
References: <20051023235806.1a4df9ab@werewolf.able.es>	<35fb2e590510231613u492d24c6k4d65ff3ac5ffcee6@mail.gmail.com> <20051024015710.29a02e63@werewolf.able.es>
In-Reply-To: <20051024015710.29a02e63@werewolf.able.es>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira Milter 1.0.7; VAE 6.29.0.5; VDF 6.29.0.100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi.

> I expected /proc/kcore to give the size of your installed memory, with
> the reserved BIOS areas just not accesible, but it looks like it already
> has them discounted, so gives 1022 Mb.
> 
> It looks really silly to have a motd say "wellcome to this box, it has
> 2 xeons and 1022 Mb of RAM".

Then round it on 32MiB boundary? 128MiB boundary?

I did something else that "needed" the size of the memory installed
and that's how I did.

( I have an install script which I run at the end of an installation
  of a system that does a lot of stuff the distro doesn't and one
  of the things it does is simply to take the size of the memory
  rounded up, multiply by 2 and then create a swapfile in a specified
  location. )

// Stefan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (MingW32)

iD8DBQFDXO1+Brn2kJu9P78RAp6aAJ9VXDLkwGHkewZtyIsajlcMugsuUwCdHKB6
da0LD9u6SHA4iL/OfHr6dD8=
=3DXl
-----END PGP SIGNATURE-----
