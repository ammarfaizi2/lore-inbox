Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316649AbSGYWly>; Thu, 25 Jul 2002 18:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316662AbSGYWly>; Thu, 25 Jul 2002 18:41:54 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:44046 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S316649AbSGYWlx>; Thu, 25 Jul 2002 18:41:53 -0400
Date: Thu, 25 Jul 2002 19:44:23 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Cort Dougan <cort@fsmlabs.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cheap lookup of symbol names on oops()
In-Reply-To: <1027637183.11604.8.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44L.0207251943360.3086-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 Jul 2002, Alan Cox wrote:
> On Thu, 2002-07-25 at 18:00, Cort Dougan wrote:
> > This is from the -atp (Aunt Tillie and Penelope) tree.
> >
> > This patch adds a small function that looks up symbol names that correspond
> > to given addresses by digging through the already existent ksyms table.
> > It's invaluable for debugging on embedded systems - especially when testing
> > modules - since ksymoops is a hassle to deal with in cross-build
> > environments.  We already have this info in the kernel so we might as well
> > use it.
>
> I would much rather have hex data. It makes all the parsing tools
> connected to the serial port that much easier.

I'd prefer having both. The hex data is useful for developers,
but seems pretty much unusable for normal users and sysadmins.

And we _do_ want those people to be able to give us useful bug
reports...

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

