Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135293AbRD1Pi3>; Sat, 28 Apr 2001 11:38:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135306AbRD1PiT>; Sat, 28 Apr 2001 11:38:19 -0400
Received: from pD901468C.dip.t-dialin.net ([217.1.70.140]:27140 "HELO
	spot.local") by vger.kernel.org with SMTP id <S135293AbRD1PiD>;
	Sat, 28 Apr 2001 11:38:03 -0400
Date: Sat, 28 Apr 2001 17:07:09 +0200
From: Rene Puls <rpuls@gmx.net>
To: Peter Osterlund <peter.osterlund@mailbox.swipnet.se>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.4 sluggish under fork load
Message-ID: <20010428170709.A410@kianga.local>
In-Reply-To: <Pine.LNX.4.33.0104281322070.1159-100000@ppro.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0104281322070.1159-100000@ppro.localdomain>; from peter.osterlund@mailbox.swipnet.se on Sat, Apr 28, 2001 at 01:52:06PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Osterlund wrote:
> 
> Another thing is that the bash loop "while true ; do /bin/true ; done" is
> not possible to interrupt with ctrl-c.

	Same thing here.

> A third thing I noticed is that starting a gnome session in redhat 7.0
> takes longer. (It takes more time for the gnome splash screen to
> appear.)

	I had similar problems with Sawfish: Starting a program from
the root menu would take about one or two seconds under 2.4.4.

> Reverting the fork patch makes all these problems go away on my
> machine.

	This patch worked for me as well.

bye,
Rene
 
-- 
Rene Puls <rpuls@gmx.net>                                 0x8652FFE2
http://www.lionking.org/~kianga/                    personal/pgp-key
