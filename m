Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262363AbSI2BZS>; Sat, 28 Sep 2002 21:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262364AbSI2BZS>; Sat, 28 Sep 2002 21:25:18 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:16402 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262363AbSI2BZR>; Sat, 28 Sep 2002 21:25:17 -0400
Date: Sat, 28 Sep 2002 18:31:45 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Jeff Garzik <jgarzik@pobox.com>, Larry Kessler <kessler@us.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       "Andrew V. Savochkin" <saw@saw.sw.com.sg>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Richard J Moore <richardj_moore@uk.ibm.com>
Subject: Re: v2.6 vs v3.0
In-Reply-To: <Pine.LNX.4.44.0209280934540.13549-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0209281826050.2198-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 28 Sep 2002, Ingo Molnar wrote:
> 
> i consider the VM and IO improvements one of the most important things
> that happened in the past 5 years - and it's definitely something that
> users will notice. Finally we have a top-notch VM and IO subsystem (in
> addition to the already world-class networking subsystem) giving
> significant improvements both on the desktop and the server - the jump
> from 2.4 to 2.5 is much larger than from eg. 2.0 to 2.4.

Hey, _if_ people actually are universally happy with the VM in the current
2.5.x tree, I'll happily call the dang thing 5.0 or whatever (just
kidding, but yeah, that would be a good enough reason to bump the major
number).

However, I'll believe that when I see it. Usually people don't complain 
during a development kernel, because they think they shouldn't, and then 
when it becomes stable (ie when the version number changes) they are 
surprised that the behabviour didn't magically improve, and _then_ we get 
tons of complaints about how bad the VM is under their load.

Am I hapyy with current 2.5.x?  Sure. Are others? Apparently. But does 
that mean that we have a top-notch VM and we should bump the major number? 
I wish.

The block IO cleanups are important, and that was the major thing _I_ 
personally wanted from the 2.5.x tree when it was opened. I agree with you 
there. But I don't think they are major-number-material.

Anyway, people who are having VM trouble with the current 2.5.x series, 
please _complain_, and tell what your workload is. Don't sit silent and 
make us think we're good to go.. And if Ingo is right, I'll do the 3.0.x 
thing.

		Linus

