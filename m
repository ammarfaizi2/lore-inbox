Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751131AbWFCEDO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbWFCEDO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 00:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147AbWFCEDO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 00:03:14 -0400
Received: from nz-out-0102.google.com ([64.233.162.195]:17390 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751131AbWFCEDO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 00:03:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pS64jmmCdIZMEZIW7unf0EX2/aWLy6bvsPY+n0chYzyxHrH4U3T4bvUMI9H0IQfZ3PUVk0Sy1WCVW4LtWw6CiRBdRrQjy+l7QTxWGiAlAESJYn4xWbsM9pFa/d6aTDbxVdNZ8s7rugG/az20QPKCY9E/C9zRLHNZtibM76Agtgk=
Message-ID: <9e4733910606022103i5587b327o8bc550d04fca0e9e@mail.gmail.com>
Date: Sat, 3 Jun 2006 00:03:03 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Kyle Moffett" <mrmacman_g4@mac.com>
Subject: Re: OpenGL-based framebuffer concepts
Cc: "Dave Airlie" <airlied@gmail.com>, "Ondrej Zajicek" <santiago@mail.cz>,
       "D. Hazelton" <dhazelton@enter.net>, "Pavel Machek" <pavel@ucw.cz>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Manu Abraham" <abraham.manu@gmail.com>,
       "linux cbon" <linuxcbon@yahoo.fr>,
       "Helge Hafting" <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org, adaplas@gmail.com
In-Reply-To: <24BBD756-4658-48A7-AD4D-1D25124A946B@mac.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>
	 <200605302314.25957.dhazelton@enter.net>
	 <9e4733910605302116s5a47f5a3kf0f941980ff17e8@mail.gmail.com>
	 <200605310026.01610.dhazelton@enter.net>
	 <9e4733910605302139t4f10766ap86f78e50ee62f102@mail.gmail.com>
	 <20060601092807.GA7111@localhost.localdomain>
	 <9e4733910606010959o4f11d7cfp2d280c6f2019cccf@mail.gmail.com>
	 <21d7e9970606011815y226ebb86ob42ec0421072cf07@mail.gmail.com>
	 <9e4733910606011918vc53bbag4ac5e353a3e5299a@mail.gmail.com>
	 <24BBD756-4658-48A7-AD4D-1D25124A946B@mac.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/2/06, Kyle Moffett <mrmacman_g4@mac.com> wrote:
> On Jun 1, 2006, at 22:18:07, Jon Smirl wrote:
> > On 6/1/06, Dave Airlie <airlied@gmail.com> wrote:
> >> of course, but that doesn't mean it can't re-use X's code, they
> >> are the best drivers we have. you forget everytime that the kernel
> >> fbdev drivers aren't even close, I mean not by a long long way
> >> apart from maybe radeon.
> >
> > I am aware that X has the best mode setting code and it would be
> > foolish to ignore it.
>
> You're kidding, right?  I've never been able to get X to get the
> modes right on my damn flatpanel.  Hell, it can't even match DDC
> channels to VGA ports without hand-holding in the config file.  To
> contrast, the fbdev layer gets it right every time on the whole
> variety of hardware that I've got.  Likewise the only way that I've
> ever gotten X to even set a vaguely functional mode on another card
> is by loading the framebuffer module first and specifying Option
> "UseFBDev" "true".  Anything else and the monitor goes off mode and
> there's no getting it back.

I don't care where the mode setting code comes from. I don't care if
it runs in the kernel or in user space. This argument has been going
on for two years without resolution so I've started working on Mozilla
instead of graphics while I wait for it to resolve.

For a while I didn't understand why 10K of code per adapter had to be
such a controversial subject. Now I understand that this code is a
lighting rod for the causes of microkernel vs monolithic and platform
independence vs Linux specific.

I've posted my requirement for a design. I'll be happy with anything
that satisfies those requirements and works.

-- 
Jon Smirl
jonsmirl@gmail.com
