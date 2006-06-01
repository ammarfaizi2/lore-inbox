Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750882AbWFAXOx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750882AbWFAXOx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 19:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750877AbWFAXOx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 19:14:53 -0400
Received: from nz-out-0102.google.com ([64.233.162.202]:37207 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750821AbWFAXOw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 19:14:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mLB9LmJoSknlK62Uv59IHnoFqbubaLrBZsXdFLyZrqbw4vG6tXVlDauXrYNZ0oRne8qbv4VtxWRFf6avDAO44fb5mZnpPntPl5SDIvvccRZ+2ufU7PHLj7EiXVWokzHjEETo6ytlqENsvGFxgqaE5xtkyvauWSiujA/WZ6XbD88=
Message-ID: <21d7e9970606011614x5b4d3a3t9608971a714f8c77@mail.gmail.com>
Date: Fri, 2 Jun 2006 09:14:41 +1000
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
In-Reply-To: <9e4733910606011335q5791997drc02d23f398a2acf5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>
	 <9e4733910606010959o4f11d7cfp2d280c6f2019cccf@mail.gmail.com>
	 <Pine.LNX.4.63.0606010758380.3827@qynat.qvtvafvgr.pbz>
	 <200606011603.57421.dhazelton@enter.net>
	 <9e4733910606011335q5791997drc02d23f398a2acf5@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

\
> Where do you get 'tons'? There will probably be one for initial reset,
> one for VESA based mode setting and a few more if there is device
> specific code needed for a specific card.
>
> Making console rely on a permanent daemon that is subject to getting
> killed by the OOM mechanism is not a workable solution.

Jon stop trying to hammer everyone by repeating ad-nauseum statements
of little importance...

We can stop the OOM killer from killing the daemon if necessary.
running device drivers in userspace would sort of require this, we can
run the daemon from init and if it dies, have it respawn, it could put
persistent info in a shared memory segment provided by the DRM, just
because you can't think of any way around things, doesn't mean the
rest of us can't..

The same things apples to a lot of your other "issues" a /dev/ with
permissions is no more or less useful than a /tmp/.grphs_socket1 and 2
with permissions, you insistence that everything be controlled via the
kernel is another thing you've just failed to think about rather than
hammer on about it *must* do this.

I'm spending more time rebutting points you repeatedly make, please
accept that there are other solutions, and everytime you post a list
of things *YOU* believe *MUST* be done, remove the things we've shown
are possible to be done other ways...

Dave.
