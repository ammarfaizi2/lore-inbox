Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318176AbSIJWRL>; Tue, 10 Sep 2002 18:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318182AbSIJWRL>; Tue, 10 Sep 2002 18:17:11 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:15861
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318176AbSIJWRK>; Tue, 10 Sep 2002 18:17:10 -0400
Subject: Re: [linux-usb-devel] Re: [BK PATCH] USB changes for 2.5.34
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Rik van Riel <riel@conectiva.com.br>,
       Linus Torvalds <torvalds@transmeta.com>,
       David Brownell <david-b@pacbell.net>,
       Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
       Greg KH <greg@kroah.com>, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <4744.1031695202@redhat.com>
References: <1031689089.31554.132.camel@irongate.swansea.linux.org.uk> 
	<Pine.LNX.4.44L.0209101626350.1519-100000@duckman.distro.conectiva>  
	<4744.1031695202@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 10 Sep 2002 23:23:21 +0100
Message-Id: <1031696601.2726.1.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-09-10 at 23:00, David Woodhouse wrote:
> Why change video mode? As long as X told the kernel what it's doing, we 
> know how to drive a linear framebuffer and in fact a few other types of 
> framebuffers. In the 'oh shit' case we could at least _attempt_ to spew our 
> dying splutter onto the screen.

It changes video mode to get the hardware into a known or roughly known
state. Linear framebuffer is a bit of an assumption both at the low end
(windowed) and high end (no framebuffer or tiled)

