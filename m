Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286207AbRLaDYT>; Sun, 30 Dec 2001 22:24:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286206AbRLaDYJ>; Sun, 30 Dec 2001 22:24:09 -0500
Received: from www.transvirtual.com ([206.14.214.140]:2579 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S286197AbRLaDX6>; Sun, 30 Dec 2001 22:23:58 -0500
Date: Sun, 30 Dec 2001 19:23:43 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: Andrew Morton <akpm@zip.com.au>
cc: Timothy Covell <timothy.covell@ashavan.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [patch] Re: Framebuffer...Why oh Why???
In-Reply-To: <3C2FD24A.19EAC82A@zip.com.au>
Message-ID: <Pine.LNX.4.10.10112301921400.22693-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Usually the problem with X11 and framebuffer is people forget they need to
> > use the UseFBDev option for XFree86. You need to tell the X server please
> > use the fbdev layer to restore the video mode. Otherwise X will try to
> > reset the card back to the VGA state.
> 
> Couldn't the X server query the kernel for this info when it starts up?

Personally I like to the console system restore the console itself. It is
so easy to do since the console system already has the code to do this.
The code just has to be reorgainzed. The point is that it is there.  

