Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286179AbRLaCxi>; Sun, 30 Dec 2001 21:53:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286184AbRLaCx2>; Sun, 30 Dec 2001 21:53:28 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:26898 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S286179AbRLaCxP>; Sun, 30 Dec 2001 21:53:15 -0500
Message-ID: <3C2FD24A.19EAC82A@zip.com.au>
Date: Sun, 30 Dec 2001 18:49:46 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: James Simmons <jsimmons@transvirtual.com>
CC: Timothy Covell <timothy.covell@ashavan.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [patch] Re: Framebuffer...Why oh Why???
In-Reply-To: <200112302231.fBUMVTSr012088@svr3.applink.net> <Pine.LNX.4.10.10112301748180.20136-100000@www.transvirtual.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Simmons wrote:
> 
> Usually the problem with X11 and framebuffer is people forget they need to
> use the UseFBDev option for XFree86. You need to tell the X server please
> use the fbdev layer to restore the video mode. Otherwise X will try to
> reset the card back to the VGA state.

Couldn't the X server query the kernel for this info when it starts up?
