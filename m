Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267892AbRGROvT>; Wed, 18 Jul 2001 10:51:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267897AbRGROvJ>; Wed, 18 Jul 2001 10:51:09 -0400
Received: from pricie.ccl.kuleuven.ac.be ([134.58.128.16]:55194 "EHLO
	pricie.ccl.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id <S267892AbRGROu5>; Wed, 18 Jul 2001 10:50:57 -0400
Date: Wed, 18 Jul 2001 16:50:51 +0200 (CEST)
From: Bert de Bruijn <bob@ccl.kuleuven.ac.be>
To: <linux-kernel@vger.kernel.org>
cc: David HM Spector <spector@zeitgeist.com>
Subject: Re: PCI hiccup installing Lucent/Orinoco carbus PCI adapter
In-Reply-To: <200107181443.QAA01801@ace.ulyssis.org>
Message-ID: <Pine.LNX.4.33.0107181644150.7821-100000@pricie.ccl.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Jul 2001 David HM Spector <spector@zeitgeist.com> wrote in
 Message-ID: <200107171706.f6HH63S05993@thx1138.ny.zeitgeist.com> :

> Hi,  included is a bug-report that seems to be a PCI oops that affects the
> intallation of a Lucent PCI CardBus adapter.
>
> [1.] One line summary of the problem:
>
>      PCI Drivers fail to allocate interrrupt for Lucent Cardbus bridge
>
> [2.] Full description of the problem/report:
>
> The 2.4.3 kernel recognizes the card but failts to allocate an
> interrupt for it.  This is the Lucent Oinoco PCI Carbus bridge product
> which is based on the TI1410 chip.  In talking with Dave Hinds about
> the problem, he looked at the enclose outbut and suggested that it
> looks like a kernel/PCI problem.
>
> Moving PCI cards arong, removing other from the system etc has no affect.

I got my Lucent PCI-to-PCMCIA adapter to work on my dual Intel box, but
win2k had some problems with it (slow booting, IIRC). I put the card in my
Alpha (Miata), but it has never worked there, with symptoms similar to the
ones you describe. The PCI initialisation apparently never allocates
(enough) resources to the card. But that PCI initialisation is
arch-dependant AFAIK.


-- 
/* Bert de Bruijn        E-mail@home: bert @ debruijn.be         */
/* Linux specialist              web: http://bert.debruijn.be/   */
/* * * * *  I'm not lost, but I still want to be found.  * * * * */

