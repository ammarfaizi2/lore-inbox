Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262015AbULKV0r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262015AbULKV0r (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 16:26:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262016AbULKV0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 16:26:47 -0500
Received: from 90.Red-213-97-199.pooles.rima-tde.net ([213.97.199.90]:63441
	"HELO fargo") by vger.kernel.org with SMTP id S262015AbULKV0j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 16:26:39 -0500
Date: Sat, 11 Dec 2004 22:25:35 +0100
From: David =?iso-8859-15?Q?G=F3mez?= <david@pleyades.net>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Simos Xenitellis <simos74@gmx.net>, linux-kernel@vger.kernel.org
Subject: Re: Improved console UTF-8 support for the Linux kernel?
Message-ID: <20041211212533.GA13739@fargo>
Mail-Followup-To: Jan Engelhardt <jengelh@linux01.gwdg.de>,
	Simos Xenitellis <simos74@gmx.net>, linux-kernel@vger.kernel.org
References: <1102784797.4410.8.camel@kl> <20041211173032.GA13208@fargo> <Pine.LNX.4.53.0412112002020.30929@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.53.0412112002020.30929@yvahk01.tjqt.qr>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jan ;),

On Dec 11 at 08:07:11, Jan Engelhardt wrote:
> >> The current UTF-8 keyboard input (for the console) of the Linux kernel
> >> does not support  "composing" or writing characters with accents.
> 
> That's weird, because "ö" (LATIN O WITH DIAERESIS) -- which clearly lies
> outside the 7-bit range, is working on my system without myself poking the
> kernel.

Indeed is weird. Are you sure you keyboard is generating an UTF-8
enconded "ö"? Just check it with echo:

$ echo -n ö | od -t x1

0000000 c3 b6 
0000002

I'm using kernel 2.6.9 + Chris patch

> So am I. I have to use xterm for anything fancy now...
> (especially for the even-more fancy stuff that begins at three-byte UTF8
> sequences, such as Japanese :-)

I know :)). By the way, and this is offtopic, have you checked uim? I
was testing it the other day with good results, and like it a lot as
a japanese (or another script, although i only use this japanese) input 
method. I've used it with anthy, just have to check it with skk.

regards,

-- 
David Gómez                                      Jabber ID: davidge@jabber.org
