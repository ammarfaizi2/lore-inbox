Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964968AbVIMSbb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964968AbVIMSbb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 14:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964965AbVIMSbb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 14:31:31 -0400
Received: from mxfep02.bredband.com ([195.54.107.73]:5800 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S964968AbVIMSba (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 14:31:30 -0400
Message-ID: <43271CA3.7050706@stesmi.com>
Date: Tue, 13 Sep 2005 20:38:27 +0200
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: markh@compro.net
CC: linux-kernel@vger.kernel.org
Subject: Re: HZ question
References: <4326CAB3.6020109@compro.net> <Pine.LNX.4.61.0509130919390.29445@chaos.analogic.com> <4326DB8A.7040109@compro.net> <Pine.LNX.4.53.0509131615160.13574@gockel.physik3.uni-rostock.de> <4326EAD7.50004@compro.net> <Pine.LNX.4.53.0509131750580.15000@gockel.physik3.uni-rostock.de> <43270294.9010509@compro.net>
In-Reply-To: <43270294.9010509@compro.net>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira Milter 1.0.7; VAE 6.29.0.5; VDF 6.29.0.100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Mark Hounschell wrote:
> Tim Schmielau wrote:
> 
>> Do you also want to know about CONFIG_PREEMPT, SMP, current load, future
>> load in order to estimate the delay you want to ask for?
> 
> 
> Are not CONFIG_PREEMPT, SMP, and current load, all determinable from
> userland anyway? Why not HZ?

And with dynamic HZ?

Do you want
a) The HZ that was used when we booted
b) The HZ that is currently used (say 22, but could be 573 in 0.1s)
c) The MIN HZ (if there is such a thing and it is configured)
   that the kernel will use.
d) The MAX HZ (same) that the kernel will use.

Or do you want USER_HZ?

Or are you after something else entirely.

// Stefan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (MingW32)

iD8DBQFDJxyjBrn2kJu9P78RAmgUAKCAhcOexz9zGIY8PLrqL4v/m+s9fgCgh/Q/
4yQ0qwPqHp9AbV2qHC8Mgs8=
=uCFK
-----END PGP SIGNATURE-----
