Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280801AbRKGOoP>; Wed, 7 Nov 2001 09:44:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280805AbRKGOoF>; Wed, 7 Nov 2001 09:44:05 -0500
Received: from [195.63.194.11] ([195.63.194.11]:11781 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S280801AbRKGOnv>; Wed, 7 Nov 2001 09:43:51 -0500
Message-ID: <3BE95514.8626CB4F@evision-ventures.com>
Date: Wed, 07 Nov 2001 16:36:52 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
Reply-To: dalecki@evision.ag
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: dalecki@evision.ag, Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Using %cr2 to reference "current"
In-Reply-To: <E161TWH-0004G9-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > somehow encouraged by the compiler comparisions between gcc and intel's
> > free compiler, which use the register passing for anything local
> > to the actual code, where the speed gains are up to 20% im currently
> 
> I was under the impression intels compiler was profoundly non-free ?

Well it's free in terms of money, read: download and "personal usage"
blabla.
This doesn't deterr me from having a look at it ;-).
> 
> > quite inclined to do the redo and finish the experiment.
> > BTW.> It's not just asm fixpus that have to be done for this
> > to work. For example all the c files with -fno-omit-frame-pointer
> 
> 20% is a nice large number.

Yes I was impressed as well and twiddeling with compiler flags is 
actually indicating that the calling convention stuff is one
of the main contributors to this. BTW.> The speed differences 
can go up to 40% for floating point, OK this is irrelevant for
the kernel but it is showing very well that there is still
plenty of room for improvement.
