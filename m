Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317276AbSFLAfd>; Tue, 11 Jun 2002 20:35:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317278AbSFLAfd>; Tue, 11 Jun 2002 20:35:33 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:5905 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S317276AbSFLAfb>; Tue, 11 Jun 2002 20:35:31 -0400
Date: Tue, 11 Jun 2002 17:19:29 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Bill Davidsen <davidsen@tmr.com>
cc: Nick Evgeniev <nick@octet.spb.ru>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: linux 2.4.19-preX IDE bugs
In-Reply-To: <Pine.LNX.3.96.1020611184236.29598B-100000@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.4.10.10206111713170.11845-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Oh lets just comment and delete the whole driver.
Everyone knows I am the king of tosser code and driver writing.
Everyone knows that I am a fraud and clear can not write a storage driver.
Surely it has to be the Maintainer's fault, because everyone is capable of
installing hardware and getting connection correct.  Nobody ever buy cheap
crappy mainboards, cause they do not exist.  Obviously the hardware is
always perfect, and the code is pathetic an whoafully buggy and I should
just quit attempting to be something I can't.

Well, I am damn close to orphaning the driver.
Maybe we should just copy 2.5 back into 2.4 and be done!

Regards,

Andre Hedrick
LAD Storage Consulting Group

On Tue, 11 Jun 2002, Bill Davidsen wrote:

> On Tue, 11 Jun 2002, Nick Evgeniev wrote:
> 
> > I don't want to make experiments in production environment anymore...
> > And it's unfair to the rest of Linux users to keep broken drivers in
> > stable kernel...  Because nobody expects that stable kernel will rip
> > your fs _daily_. 
> 
>   I remember when SMP started, if used with certain filesystem types it
> would regularly eat the f/s data. The argument was made that it should be
> commented out of the config file, so you really had to work at getting it
> turned on. In spite of that a number of (from memory early 2.2) kernels
> had the defect and led to people thinking that Linux was unreliable in
> general.
> 
>   I agree that if it has known problems which destroy data it should be
> unavailable in the stable kernel. It certainly sounds as if that's the
> case, and the driver could be held out until 2.4.20 or so when it can be
> fixed, or if it can't be fixed it can just go away.
> 
>   A stable kernel release should be, well... stable. Give the enemies of
> Linux no ammunition, they make up enough crap as it is.
> 
> -- 
> bill davidsen <davidsen@tmr.com>
>   CTO, TMR Associates, Inc
> Doing interesting things with little computers since 1979.


