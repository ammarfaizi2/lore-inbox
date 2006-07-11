Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965050AbWGKBs0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965050AbWGKBs0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 21:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965072AbWGKBs0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 21:48:26 -0400
Received: from terminus.zytor.com ([192.83.249.54]:29613 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S965050AbWGKBs0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 21:48:26 -0400
Message-ID: <44B30356.8060404@zytor.com>
Date: Mon, 10 Jul 2006 18:48:06 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Albert Cahalan <acahalan@gmail.com>
CC: Jan Engelhardt <jengelh@linux01.gwdg.de>, ray-gmail@madrabbit.org,
       Jon Smirl <jonsmirl@gmail.com>, Greg KH <greg@kroah.com>,
       alan@lxorguk.ukuu.org.uk, efault@gmx.de, linux-kernel@vger.kernel.org
Subject: Re: Opinions on removing /proc/tty?
References: <787b0d920607082230w676ddc62u57962f1fc08cf009@mail.gmail.com>	 <9e4733910607090704r68602194h3d2a1a91a4909984@mail.gmail.com>	 <787b0d920607090923p65c417f2v71c8e72bf786f995@mail.gmail.com>	 <2c0942db0607091000m259c1ed5m960821eb5237c4b0@mail.gmail.com>	 <787b0d920607091226sb1db56dg9c0267f6ae8e2dc7@mail.gmail.com>	 <20060709193133.GA32457@flint.arm.linux.org.uk>	 <787b0d920607091257u52198c55sb8973a39bff3fcc8@mail.gmail.com>	 <Pine.LNX.4.61.0607101601470.5071@yvahk01.tjqt.qr>	 <787b0d920607100806u613e7594nb6a7a1e2965e11a6@mail.gmail.com>	 <Pine.LNX.4.61.0607110015030.5420@yvahk01.tjqt.qr> <787b0d920607101807j2804023v17f7643bffeb2456@mail.gmail.com>
In-Reply-To: <787b0d920607101807j2804023v17f7643bffeb2456@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cahalan wrote:
> 
> On any of Linux, MacOS, Solaris, NetBSD, OpenBSD:
> 
> $ ls /dev/tty /dev/ctty
> ls: /dev/ctty: No such file or directory
> /dev/tty
> 
> Lord only knows why FreeBSD has both.
> Unlike Linux, they don't supply a man page.
> On a Linux system, "man 4 tty" is useful.
> On a Solaris system, "man -s 7d tty" is useful.

On System V, /dev/ctty is the primary console device (meaning that 
unlike /dev/console, it cannot be redirected.)

	-hpa

