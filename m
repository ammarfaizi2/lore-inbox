Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129409AbRCFTjK>; Tue, 6 Mar 2001 14:39:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129428AbRCFTjA>; Tue, 6 Mar 2001 14:39:00 -0500
Received: from s057.dhcp212-109.cybercable.fr ([212.198.109.57]:3589 "EHLO
	s057.dhcp212-109.cybercable.fr") by vger.kernel.org with ESMTP
	id <S129409AbRCFTil>; Tue, 6 Mar 2001 14:38:41 -0500
Message-ID: <3AA53AE6.5D17A6C8@baretta.com>
Date: Tue, 06 Mar 2001 20:30:46 +0100
From: Alessandro Baretta <alex@baretta.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: it, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Inadequate documentation: sockets
In-Reply-To: <200103061926.WAA23796@ms2.inr.ac.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kuznet@ms2.inr.ac.ru wrote:
> 
> Hello!
> 
> > The manual specifies the following flag to be returned by the
> > kernel
> > [smip]
> 
> The information is is not quite correct.
> [snip]

The information you gave me sounds interesting, but it is conflict
with the documentation. This was my original assertion: the
documentation on the subject is inadequate.

> > Finally I'm left with my original problem: how am I supposed to
> > detect a close or a shutdown from the peer?
> 
> By EOF. No other way exists. POLLHUP is local condition, only
> local side can close connection in write direction. Exception
> is abort (reset) initiated by peer.

What do you mean by "local condition"? You surely do not mean that
the event which provokes the POLLHUP occours on my host? What
about a shutdown(sock, SHUT_RD) called by the peer?

> > by addressing me to more adequate documentation.
> 
> UNIX98 and Austin draft pages. The are very ambiguous though.
> 
Hmmmm....

Thank you very much!

Alex

P.S. Alexey, I meant this post to be for the list. The copy I sent
to you privately is my mistake.
