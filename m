Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318207AbSIJWzX>; Tue, 10 Sep 2002 18:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318208AbSIJWzW>; Tue, 10 Sep 2002 18:55:22 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:62197
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318207AbSIJWzN>; Tue, 10 Sep 2002 18:55:13 -0400
Subject: Re: [linux-usb-devel] Re: [BK PATCH] USB changes for 2.5.34
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Rik van Riel <riel@conectiva.com.br>,
       Linus Torvalds <torvalds@transmeta.com>,
       David Brownell <david-b@pacbell.net>,
       Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
       Greg KH <greg@kroah.com>, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <5220.1031696794@redhat.com>
References: <1031696601.2726.1.camel@irongate.swansea.linux.org.uk> 
	<1031689089.31554.132.camel@irongate.swansea.linux.org.uk>
	<Pine.LNX.4.44L.0209101626350.1519-100000@duckman.distro.conectiva>
	<4744.1031695202@redhat.com>   <5220.1031696794@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 11 Sep 2002 00:01:16 +0100
Message-Id: <1031698876.2768.6.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-09-10 at 23:26, David Woodhouse wrote:
> 
> alan@lxorguk.ukuu.org.uk said:
> >  It changes video mode to get the hardware into a known or roughly
> > known state. Linear framebuffer is a bit of an assumption both at the
> > low end (windowed) and high end (no framebuffer or tiled)
> 
> We shouldn't _assume_ it. XFree86 should tell us. And it can tell us about 
> the other cases too; some of those we can deal with anyway.

You could make a usermode app that makes a DGA query and feeds the
results to the kernel I guess

