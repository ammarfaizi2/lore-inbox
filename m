Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265852AbRFYCfa>; Sun, 24 Jun 2001 22:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265849AbRFYCfK>; Sun, 24 Jun 2001 22:35:10 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:29352 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S265850AbRFYCfF>;
	Sun, 24 Jun 2001 22:35:05 -0400
Date: Sun, 24 Jun 2001 22:35:03 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Marty Leisner <leisner@rochester.rr.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: mounting a fs in two places at once?
In-Reply-To: <200106250212.WAA05336@soyata.home>
Message-ID: <Pine.GSO.4.21.0106242226150.11019-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 24 Jun 2001, Marty Leisner wrote:

> I just installed redhat 7.1 on a system.
> 
> Cleaning up, a made a fs for home...(mounted on /mnt
> to write the stuff to it)
> 
> Then I accidently mounted it on /home.
> 
> So it was mounted on /home and /mnt at the same time.
> (I didn't bother going in to see what was there).

Same tree, obviously.

> Shouldn't this NOT happen?

Sigh... Guys, who maintains l-k FAQ?

Q: I've mounted filesystem in two different places and it worked. Why?
A: Because you've asked to do that. Yes, it works. No, it's not a bug.

Q: what should I do to unmount it?
A: umount <mountpoint>

Q: but that took care only of one of them. How can I deal with another?
A: umount <another_mountpoint>

