Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129078AbRB0MZO>; Tue, 27 Feb 2001 07:25:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129112AbRB0MZE>; Tue, 27 Feb 2001 07:25:04 -0500
Received: from sphinx.mythic-beasts.com ([195.82.107.246]:60946 "EHLO
	sphinx.mythic-beasts.com") by vger.kernel.org with ESMTP
	id <S129078AbRB0MYu>; Tue, 27 Feb 2001 07:24:50 -0500
Date: Tue, 27 Feb 2001 12:24:20 +0000 (GMT)
From: Matthew Kirkwood <matthew@hairy.beasts.org>
To: icognito <icognito@dandelion.darkorb.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: wavelan drivers
In-Reply-To: <Pine.LNX.4.21.0102270712080.16065-100000@dandelion.darkorb.net>
Message-ID: <Pine.LNX.4.10.10102271218410.26028-100000@sphinx.mythic-beasts.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Feb 2001, icognito wrote:

> anyone know if there is an updated repository for the linux-wlan
> project? i need drivers for the baystack 660 and none of the wlan n
> modules in the distro in the site
> (http://www.linux-wlan.com/linux-wlan/linux-wlan-0.3.4.tar.gz) compile
> under 2.4.2... i can get the drivers to compile under 2.2.16 but nothing
> beyond that, 2.4.2 drivers would be really cool if anyone has them thanks
> in advance --gabe

Hi,

I have ported the driver to 2.4 with the in-kernel PCMCIA
package.

It's a little bit broken (causes all sorts of warnings in
dmesg, and will kill the machine if the card is removed)
but it works once up.

You can get the patch (againt linux-2.4.0test13pre5, but
applies to 2.4.2) at http://www.hairy.beasts.org/wlan-24.diff.gz

I initially intended to integrate it with the wireless LAN
setup that's used for the other drivers, but haven't had
time for that in several months.

Matthew.

