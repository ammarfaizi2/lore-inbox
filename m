Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271712AbRH0Lsr>; Mon, 27 Aug 2001 07:48:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271703AbRH0Ls1>; Mon, 27 Aug 2001 07:48:27 -0400
Received: from skiathos.physics.auth.gr ([155.207.123.3]:1598 "EHLO
	skiathos.physics.auth.gr") by vger.kernel.org with ESMTP
	id <S271706AbRH0LsS>; Mon, 27 Aug 2001 07:48:18 -0400
Date: Mon, 27 Aug 2001 14:48:24 +0300 (EET DST)
From: Liakakis Kostas <kostas@skiathos.physics.auth.gr>
To: Jan Niehusmann <jan@gondor.com>
cc: "Grover, Andrew" <andrew.grover@intel.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: VCool - cool your Athlon/Duron during idle
In-Reply-To: <20010827115357.A1335@gondor.com>
Message-ID: <Pine.GSO.4.21.0108271443170.6958-100000@skiathos.physics.auth.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Aug 2001, Jan Niehusmann wrote:

> Motherboard vendors may have disabled the bus disconnection because of a
> 3% performance hit, to make their boards look better in benchmarks.
> In that case, the system may run perfectly stable with disconnection reenabled.

There is still another reason..

> (asus writes that one of the problems that can happen with this power
> saving mode are the huge changes in power dissipation, from 60W to 5W
> and back - therefore I assume the power saving mode can save up to 55W)

The problem they are describing is not the change in power dissipation,
but the change in current draw from the regulated 1.75V (difference of
about 30A or more). During this almost instantaneous transition either
your mobo regulator or your PSU can give up for a while and you get a nice
crash. This tends to happen more often with the 1400-Cs.

-K.



