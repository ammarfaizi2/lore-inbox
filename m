Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262425AbUADTzr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 14:55:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262730AbUADTzr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 14:55:47 -0500
Received: from smtprelay01.ispgateway.de ([62.67.200.156]:19165 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S262425AbUADTzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 14:55:45 -0500
Message-ID: <3FF86F95.6040304@metalhen.de>
Date: Sun, 04 Jan 2004 20:55:01 +0100
From: Benjamin Henne <metalhen@metalhen.de>
Organization: =?ISO-8859-1?Q?Universit=E4t_Hannover?=
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: de-de, de-at
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: gaim problems in 2.6.0
References: <20040104172535.GA322@elf.ucw.cz>
In-Reply-To: <20040104172535.GA322@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
> I'm having bad problems with gaim... When I run gaim, my machine tends
> to freeze hard (no blinking leds). I'm running vesafb -> that should
> rule out X problems. Machine is rather strange pre-production athlon64
> noteook, but I'm running 32-bit (on 32-bit kernel), and I can run gaim
> under 2.4.X kernel.
> 
> [Ugh, I was running with kgdb, but I recall same problem before, too.]
> 
> Does anyone have similar problem?
> 								Pavel


It's not a so similiar problem or is it.
I also have problems with gnome and freezing when using 2.6.0.
With my old 2.4.20 kernel all is ok. My problems starts with 2.6.0 
installation, which I needed for some hardware support. The new kernel 
works well in console. Have no errors in `dmesg`, not even in syslog.
If I setup a nework device and then also define a default route to my 
gateway gnome seems to freeze with it's first network access.
If I start net and then gnome, gnome needs to start over 20-30minutes 
and still did not come up totally. If I setup network in a xterm in 
gnome then gnome freezes after a short while, e.g. when starting mozilla.
It is no hard freeze, it looks like gnome is running on a 1 Mhz PC or as 
if it has time lack of several minutes.
But it's only in grapical gnome. In a console I can surf with lynx.
First I thougth it could be a gnome problem, but problems only come when 
booting with 2.6.0

Benjamin

