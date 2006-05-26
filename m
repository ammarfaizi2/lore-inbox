Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932410AbWEZMBO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932410AbWEZMBO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 08:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932413AbWEZMBF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 08:01:05 -0400
Received: from nz-out-0102.google.com ([64.233.162.207]:40585 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932410AbWEZMA4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 08:00:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rUd8QjHGxqp88WO5+UsFm2bgwf+OOx9TBf+t9GRzLmxZl1Fm7G+zpBumNc0vfYmN4C5fvupssQ24km8TriOGKNTjmJf7ACl2lgtihEq95AY+sYmdgx8cbZ+9fPGcza/uRxPBHF7y+0u4+X/pB1LkimByZcHc0awypJ3XU9MwmPA=
Message-ID: <5486cca80605260500p72e107fcw8c422c1ea884be4f@mail.gmail.com>
Date: Fri, 26 May 2006 14:00:23 +0200
From: Antonio <tritemio@gmail.com>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: : unclean backward scrolling
Cc: nick@linicks.net, linux-kernel@vger.kernel.org
In-Reply-To: <44764F4F.5000102@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5486cca80605210638l2906112fv515df1bc390cff24@mail.gmail.com>
	 <7c3341450605211155i3674a27bob6213b449e2d1a3a@mail.gmail.com>
	 <44764F4F.5000102@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/26/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
> Nick Warne wrote:
> > Hmmmph.
> >
> > I get this problem, and always have, but I always put it down to my system.
> >
> > I run Slackware 10, and this has always happened to me from 2.6.2
> > upwards on CRT 1024x768 and later TFT 1280x1024 dvi.
> >
> > I use[d] in lilo:
> >
> > # VESA framebuffer console @ 1280x1024x?k
> > vga=794
> > # VESA framebuffer console @ 1024x768x64k
> > #vga=791
> >
> > So you are not alone.
> >
> > Nick
> >
> > On 21/05/06, Antonio <tritemio@gmail.com> wrote:
> >> Hi,
> >>
> >> I'm using the radeonfb driver with a radeon 7000 with the frambuffer
> >> at 1280x1024 on a i386 system, with a 2.6.16.17 kernel. At boot time,
> >> if I stop the messages with CTRL+s and try look the previous messages
> >> with CTRL+PagUp (backward scrolling) the screen become unreadable. In
> >> fact some lengthier lines are not erased scrolling backward and some
> >> random characters a overwritten instead. So it's very difficult to
> >> read the messages.
> >>
> >> I don't have such problem with the frambuffer at 1024x768.
> >>
> >> All the previous kernels I've tried have this problem (at least up to
> >> 2.6.15).
> >>
> >> If someone can look at this issue I can provide further information.
> >>
> >> Many Thanks.
> >>
> >> Cheers,
> >>
>
> Can you try this patch and let me know if this fixes the problem?
>
> Tony
>
> PATCH: Fix scrollback with logo issue immediately after boot.
[cut]

This patch fixes completely the problem for me. Many thanks!

Is going to be included in mainline anytime soon?

Many thanks again, I've really appreciated your help.

Cheers,

  ~ Antonio
