Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318165AbSIJVz6>; Tue, 10 Sep 2002 17:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318166AbSIJVz6>; Tue, 10 Sep 2002 17:55:58 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:51447 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S318165AbSIJVz5>; Tue, 10 Sep 2002 17:55:57 -0400
X-Mailer: exmh version 2.5 13/07/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <1031689089.31554.132.camel@irongate.swansea.linux.org.uk> 
References: <1031689089.31554.132.camel@irongate.swansea.linux.org.uk>  <Pine.LNX.4.44L.0209101626350.1519-100000@duckman.distro.conectiva> 
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
Date: Tue, 10 Sep 2002 23:00:02 +0100
Message-ID: <4744.1031695202@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


alan@lxorguk.ukuu.org.uk said:
>  There is a patch for this. However its fairly useless since all the
> users are in X11 and while -ac will give you morse as well thats not
> terribly friendly.

> There are some real mode patches that try and get you back into a sane
> video mode and dump you into a saner environment.

Why change video mode? As long as X told the kernel what it's doing, we 
know how to drive a linear framebuffer and in fact a few other types of 
framebuffers. In the 'oh shit' case we could at least _attempt_ to spew our 
dying splutter onto the screen.

--
dwmw2


