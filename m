Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751015AbWFAXsG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751015AbWFAXsG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 19:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751014AbWFAXsF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 19:48:05 -0400
Received: from nz-out-0102.google.com ([64.233.162.194]:53479 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751000AbWFAXsC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 19:48:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=M2d4Sb2k6MiMU9G11xN274OxSt95+eE/n43MGfp/ei5J4If5Tcd/6ByEBNcrgYKzKjO8l5yP6ApnMmVofxayrjTmS7P9JzdBRL8klEwMyYYmCA+BadZWFSD5Gnlrbx0TvBa44vfEPY63e8vBHbmEz1KwfOp3B7D6UGJKX3H//pw=
Message-ID: <21d7e9970606011647l11a780d3h816fee2cc01e72a9@mail.gmail.com>
Date: Fri, 2 Jun 2006 09:47:51 +1000
From: "Dave Airlie" <airlied@gmail.com>
To: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: OpenGL-based framebuffer concepts
Cc: "D. Hazelton" <dhazelton@enter.net>,
       "David Lang" <dlang@digitalinsight.com>,
       "Ondrej Zajicek" <santiago@mail.cz>, "Pavel Machek" <pavel@ucw.cz>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Kyle Moffett" <mrmacman_g4@mac.com>,
       "Manu Abraham" <abraham.manu@gmail.com>,
       "linux cbon" <linuxcbon@yahoo.fr>,
       "Helge Hafting" <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org, adaplas@gmail.com
In-Reply-To: <9e4733910606011638s587fff33lbfe46f6a2817245b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>
	 <9e4733910606010959o4f11d7cfp2d280c6f2019cccf@mail.gmail.com>
	 <Pine.LNX.4.63.0606010758380.3827@qynat.qvtvafvgr.pbz>
	 <200606011603.57421.dhazelton@enter.net>
	 <9e4733910606011335q5791997drc02d23f398a2acf5@mail.gmail.com>
	 <21d7e9970606011614x5b4d3a3t9608971a714f8c77@mail.gmail.com>
	 <9e4733910606011638s587fff33lbfe46f6a2817245b@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Jon stop trying to hammer everyone by repeating ad-nauseum statements
> > of little importance...
>
> If you can not restraint yourself to making technical arguments,
> please stop posing to LKML.

Jon,

you have over the past 2 or so years, posted over and over the same
list of technical points that you consider necessary, numerous times I
and others have pointed alternative methods to achieve what you wanted
that would be equally or more acceptable, you return to the list and
others repeating your list of points without editing, you then force
me to repeat things I've stated numerous times previously, I for one
get very bored of this and it really doesn't help anyone, I feel like
NASA refuting the people who say man never walked on the moon,

You snipped my technical arguments by the way so I'll yet again repeat them:

We can stop the OOM killer from killing the daemon if necessary.
running device drivers in userspace would sort of require this, we can
run the daemon from init and if it dies, have it respawn, it could put
persistent info in a shared memory segment provided by the DRM, just
because you can't think of any way around things, doesn't mean the
rest of us can't..

a /dev/ with permissions is no more or less useful than a
/tmp/.grphs_socket1 and 2
with permissions,

Please discuss,
Dave.
>
> --
> Jon Smirl
> jonsmirl@gmail.com
>
