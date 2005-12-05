Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932383AbVLELjn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932383AbVLELjn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 06:39:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932381AbVLELjn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 06:39:43 -0500
Received: from xproxy.gmail.com ([66.249.82.201]:22687 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932383AbVLELjm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 06:39:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fh13CCc6bUX9+KsIn6rI004TWtkANBfPkctB8CfWMxeggSN8eq82UegtXP3BLnUT0u6Y+ZiJa5iv0g5qsZcAl+8/a7W5uUsX/e0oCQ281gQqGLzRv+PgwEp3SJ0bSelSUZoi/Ut9td4z856Q3ECriM10xzqb6tIzLiPdfXv0p5o=
Message-ID: <21d7e9970512050339s392c12a9jd4168cd707bb5e8d@mail.gmail.com>
Date: Mon, 5 Dec 2005 22:39:42 +1100
From: Dave Airlie <airlied@gmail.com>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: Linux in a binary world... a doomsday scenario
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1133779953.9356.9.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1133779953.9356.9.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Several hardware vendors that have been friendly to open source so far,
> see their competitors ship only binary drivers, and internally they
> start to see pressure to also keep the IP private, and they know that
> they haven't used some features of the hardware because their legal
> department didn't want that IP in the public. As a result they perceive
> their competitors binary drivers to be at a theoretical advantage, or at
> least their own drivers could be at an advantage if they were also
> closed, because they then can use those few extra features to be ahead
> of the competition. By February 1st 2006, about half the hardware
> vendors have refocused their internal linux driver efforts to create
> value adds in the binary drivers they will release in addition to the
> open drivers that already exist. Some vendors even openly stopped
> supporting the open drivers because they don't have enough resources
> to do both.

This is pretty much how the 3D drivers has gone down (as I'm sure
Arjan knows) but just to back it up with others, ATI released enough
info to make a basic 3D driver for their hardware to do OpenGL, they
didn't give out any info on the "protected IP" like HyperZ, MPEG
decoder, SmartShader, the list goes on, a lot of this has since been
reverse engineered for the older chips, then NVIDIA didn't release any
open source drivers, then ATI decided to go close source as they
couldn't compete on the feature set they were willing (allowed by
lawyers) to put into the open source drivers. ATI engineers now use
the excuse well NVIDIA have a closed source driver so we have to have
one to compete. Again neither company is willing to put resources into
doing much on the open source scene due to lack of staff, reasons, and
neither company is willing to give info to open source developers
because they need to push it all past their legal departments (despite
this info existing and a number of open source developers having
access to it via $job).

Intel are now starting to think about doing closed source only drivers
from what I heard on the grapevine, and as their open drivers only
provide modesetting via the BIOS, their drivers aren't exactly useful
in many situations..

Its a slippery slippery slope and all you people that bitch and moan
about stable API really don't have a clue what it means, Arjans
scenario is quite practical (it may take longer to happen but I doubt
the future would be much different..)

You'd also have issues with two binary drivers doing things in the
kernel that might affect each other, like bad interrupt sharing or
messing with pci setups for higher speeds, and no chance of getting
them working in any controlled fashion together without vendor
support.

Dave.
