Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318182AbSIJWWH>; Tue, 10 Sep 2002 18:22:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318196AbSIJWWH>; Tue, 10 Sep 2002 18:22:07 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:1528 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S318182AbSIJWWG>; Tue, 10 Sep 2002 18:22:06 -0400
X-Mailer: exmh version 2.5 13/07/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <1031696601.2726.1.camel@irongate.swansea.linux.org.uk> 
References: <1031696601.2726.1.camel@irongate.swansea.linux.org.uk>  <1031689089.31554.132.camel@irongate.swansea.linux.org.uk> <Pine.LNX.4.44L.0209101626350.1519-100000@duckman.distro.conectiva> <4744.1031695202@redhat.com> 
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Rik van Riel <riel@conectiva.com.br>,
       Linus Torvalds <torvalds@transmeta.com>,
       David Brownell <david-b@pacbell.net>,
       Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
       Greg KH <greg@kroah.com>, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: [BK PATCH] USB changes for 2.5.34 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 10 Sep 2002 23:26:34 +0100
Message-ID: <5220.1031696794@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


alan@lxorguk.ukuu.org.uk said:
>  It changes video mode to get the hardware into a known or roughly
> known state. Linear framebuffer is a bit of an assumption both at the
> low end (windowed) and high end (no framebuffer or tiled)

We shouldn't _assume_ it. XFree86 should tell us. And it can tell us about 
the other cases too; some of those we can deal with anyway.

--
dwmw2


