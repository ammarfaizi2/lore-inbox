Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266505AbRGIHtK>; Mon, 9 Jul 2001 03:49:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266691AbRGIHtA>; Mon, 9 Jul 2001 03:49:00 -0400
Received: from L0185P19.dipool.highway.telekom.at ([62.46.87.19]:34718 "EHLO
	mannix") by vger.kernel.org with ESMTP id <S266505AbRGIHsn>;
	Mon, 9 Jul 2001 03:48:43 -0400
Date: Mon, 9 Jul 2001 09:52:09 +0200
To: "Robert J.Dunlop" <rjd@xyzzy.clara.co.uk>
Cc: "Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org
Subject: Re: PATCH: linux-2.4.7-pre3/drivers/char/sonypi.c would hang some non-Sony notebooks
Message-ID: <20010709095209.A12223@aon.at>
In-Reply-To: <200107081026.DAA22119@baldur.yggdrasil.com> <20010708174639.A7477@xyzzy.clara.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20010708174639.A7477@xyzzy.clara.co.uk>
User-Agent: Mutt/1.3.18i
"X-Signature-Color: eidotterbraun
X-Registered-Linux-User: 174382
X-Der-wahre-WM: Enlightenment
X-Die-wahre-Distro: Debian"
From: Alexander Griesser <tuxx@aon.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 08, 2001 at 05:46:39PM +0100, you wrote:
> OK. lspic -v shows
>   CardBus bridge: Ricoh Co Ltd RL5c475 (rev 80)
>   Subsystem: Sony Corporation: Unknown device 8082
> I guess that's a pretty safe signature if the other VAIO lap and
> palmtops have it.

Seems so, my Vaio shows this signature too.

00:0c.0 CardBus bridge: Ricoh Co Ltd RL5c475 (rev 80)
	Subsystem: Sony Corporation: Unknown device 8082
	Flags: bus master, medium devsel, latency 168, IRQ 9
	Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
	I/O window 0: 00000000-00000003
	I/O window 1: 00000000-00000003
	16-bit legacy interface ports at 0001

HTH, alexx
-- 
|    .-.    |   CCNAIA Alexander Griesser <tuxx@aon.at>  |   .''`.  |
|    /v\    |  http://www.tuxx-home.at -=- ICQ:63180135  |  : :' :  |
|  /(   )\  |    echo "K..?f{1,2}e[nr]böck" >>~/.score   |  `. `'   |
|   ^^ ^^   |    Linux Version 2.4.6 - Debian Unstable   |    `-    |
