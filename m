Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964793AbWEYAbL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964793AbWEYAbL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 20:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964791AbWEYAbL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 20:31:11 -0400
Received: from wr-out-0506.google.com ([64.233.184.234]:27144 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S964793AbWEYAbJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 20:31:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MrCGMrH11IKp01LLALMhgTK4wLrySA2jK9lPVwU80KMMdOBAAOWX/d2UAGUtTydrkRh0e4vRYUTND4zF/M5kqjSVctQAu7GUMHDk8pPq/L8KC26qMR55MMrX6rM/IJ8yXaxXY/SZAV3giNbMKOp2xp9TYQo4mJux4zb3FuBCVLI=
Message-ID: <21d7e9970605241731h7dc0fe40ga1baf0445f913a1e@mail.gmail.com>
Date: Thu, 25 May 2006 10:31:08 +1000
From: "Dave Airlie" <airlied@gmail.com>
To: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: OpenGL-based framebuffer concepts
Cc: "D. Hazelton" <dhazelton@enter.net>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Kyle Moffett" <mrmacman_g4@mac.com>,
       "Manu Abraham" <abraham.manu@gmail.com>,
       "linux cbon" <linuxcbon@yahoo.fr>,
       "Helge Hafting" <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
In-Reply-To: <9e4733910605241656r6a88b5d3hda8c8a4e72edc193@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>
	 <200605232338.54177.dhazelton@enter.net>
	 <21d7e9970605232108u27bc3ae7mbd161778c51afaf5@mail.gmail.com>
	 <200605240017.45039.dhazelton@enter.net>
	 <21d7e9970605232214l3349df0dka162f794f8eddf95@mail.gmail.com>
	 <9e4733910605240827w309c4dc7of42ea2def10960c9@mail.gmail.com>
	 <21d7e9970605241618x7eaeb010h60817b5ca944acd9@mail.gmail.com>
	 <9e4733910605241656r6a88b5d3hda8c8a4e72edc193@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> I got giant earfuls of the BSD issue from EricA. But, Dave, you are
> more reasonable than some of the other X developers so I'm not putting
> blame on you. I did notice that you didn't deny the part about zero
> forward progress in the kernel.
>

Well that part is true, which is totally to do with lack of developers
working on it in the correct direction, as I said lots of us know how
to do it and what direction it needs to go, lots of us however have
lots of other things that keep us occupied that are more urgent now,
the problem is for 90% of things the current systems work, so getting
the momentum to redesign a complete system just so root can't get root
is always going to be difficult... the people who care about the 10%
haven't contributed their time other than to complain about the 10%,
which puts them in the don't care category for the people trying their
best to please the other 90% with limited resources.

> I do stand by my opinion that building a driver bus so that three
> independent drivers (fbdev, DRM, XAA/EXA) can simultaneously multitask
> on a single piece of hardware is not a good design. It is a political
> solution, not a technical one.
>

Your problem is you never listen when someone tells you, you can't
break things, your solutions all took the easy path which is to bust
fbdev or make it require DRM, which isn't what people want, there is
no politics here other than Linus stating you can't break working
systems and trying to figure out how to do it technically, of course
it is going to be more work and of course most of the work might be
thrown away in two years, but that happens a lot transition code is
very important. The amount of dirty work I've  had to do to get the
r300 stuff so that the DRM doesn't break current systems is an example
of this, you would have just said, well let them fix X, I however
cannot accept that answer.

Dave.
