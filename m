Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274272AbRISXd3>; Wed, 19 Sep 2001 19:33:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274269AbRISXd1>; Wed, 19 Sep 2001 19:33:27 -0400
Received: from moline.gci.com ([205.140.80.106]:55307 "EHLO moline.gci.com")
	by vger.kernel.org with ESMTP id <S274272AbRISXdC>;
	Wed, 19 Sep 2001 19:33:02 -0400
Message-ID: <BF9651D8732ED311A61D00105A9CA315061465DF@berkeley.gci.com>
From: Leif Sawyer <lsawyer@gci.com>
To: linux-kernel@vger.kernel.org
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        Arjan van de Ven <arjanv@redhat.com>,
        Petr Vandrovec <VANDROVE@vc.cvut.cz>, Dan Hollis <goemon@anime.net>,
        John Alvord <jalvo@mbay.net>
Subject: RE: [PATCH] Athlon bug stomper. Pls apply.
Date: Wed, 19 Sep 2001 15:33:17 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Hollis continues the line with..
> On Wed, 19 Sep 2001, John Alvord wrote:
> > >Until we have a straight answer what the hell this bit 
> does, its a very
> > >bad idea to put it into *production kernel*.
> > Of course the BIOS versions made exactly that change...
> 
> 1) We dont know if all "fixed" BIOS versions do it
> 2) We dont know if all motherboards do it
> 3) We dont have enough data points to determine if this is a 
> "real fix" yet.
> 4) We dont know if they do it under all circumstances
>    (eg do they read SPD and set it in some situations and not others)
>    It may even be CPU rev specific.
> 
> IMHO its *FAR* too premature to be rolling this into 
> production kernels
> based on the scant evidence we have so far.
> 

You all realize that this ranting about 'not for production kernels' is
a waste of time and bandwidth, right?

Make it a compile time option.  Simple, Elegant, and you can
choose to try it or not.  

Of course, now that this can of worms is open, the debate will
range on whether it's default is Enabled or Disabled.

Sheesh.

(i'd enclose an updated patch, but I deleted the original posting.)
