Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750760AbVLTSAO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbVLTSAO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 13:00:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750762AbVLTSAJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 13:00:09 -0500
Received: from wproxy.gmail.com ([64.233.184.199]:6660 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750760AbVLTSAG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 13:00:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Q6bbdpSPoqka71quDTUmPwai36iIho59MvuMF7Irw+sRsadDr3gvDoptVIWqhShN4eE2NeHJXCLEJIrHqs78qaYjs/Dqh+1pPleSVe1oHaUSRTUTB8OMd5AqguAxu0RNVgwEzGa4vgHC7Qlf+N/mgl8AbyWnHotFBC3ekJEl1rA=
Message-ID: <9a8748490512201000q18f02d95v44d713522e566aea@mail.gmail.com>
Date: Tue, 20 Dec 2005 19:00:05 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: Yet more display troubles with 2.6.15-rc5-mm2
Cc: LKML List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <439F73D4.9060304@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9a8748490512111306x3b01cb8cw2068a7ad3af93b03@mail.gmail.com>
	 <439CBE49.2090901@gmail.com>
	 <9a8748490512121031p11beaa51l7445ce1a5b31c3c6@mail.gmail.com>
	 <439E9762.4070809@gmail.com>
	 <9a8748490512131319o408a368eqfed225abebaff4d@mail.gmail.com>
	 <439F73D4.9060304@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/14/05, Antonino A. Daplas <adaplas@gmail.com> wrote:
> Jesper Juhl wrote:
> > On 12/13/05, Antonino A. Daplas <adaplas@gmail.com> wrote:
> >> Jesper Juhl wrote:
> >>> On 12/12/05, Antonino A. Daplas <adaplas@gmail.com> wrote:
> >>>> Jesper Juhl wrote:
> >>>>
> >>> I'm already using the vesa driver. It seems to be the only Open Source
> >>> driver that'll work with this card, so i don't have any other to try.
> >>>
> >> I just tried with Xorg vesa and vgacon, and everything seems to work okay.
> >> Now I'm not sure what changes in linux causes the vgacon state restore
> >> to fail (VGA state restoration is almost the entire responsibility
> >> of X, BTW), but maybe you can use vbetool to get and set the vga mode,
> >> just to test?
> >>
> > Ok, I'm not familiar with that tool and my distribution doesn't
> > include it, but if it will be useful to you for me to test with  it
> > I'll get and install it. What exactely would you like me to do/try
> > with it?
>
> The vbetool is capable of getting/setting or saving/restoring the current
> state of the hardware.  You can run vbetool vbestate save before going
> to X and then run vbetool vbestate restore after switching back to console.
>

Hi Antonio,

Sorry about the late reply but I've been busy and unable to return to
this issue until now.

I've tried building vbetool, but unfortunately all versions of it that
I can obtain refuse to build on my system, so at the moment I can't do
that testing for you.

I'll test the recently released 2.6.15-rc5-mm3 as well as
2.6.15-rc6-git1 and let you know if they have this issue or not.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
