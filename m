Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274508AbRITORk>; Thu, 20 Sep 2001 10:17:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274509AbRITORa>; Thu, 20 Sep 2001 10:17:30 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:49620 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S274508AbRITORT>; Thu, 20 Sep 2001 10:17:19 -0400
Date: Thu, 20 Sep 2001 08:18:45 -0600
Message-Id: <200109201418.f8KEIjG01625@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: drivers/char/sonypi.h broken
In-Reply-To: <E15k37E-0005CC-00@the-village.bc.nu>
In-Reply-To: <200109200401.f8K413n29745@vindaloo.ras.ucalgary.ca>
	<E15k37E-0005CC-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox writes:
> > Yes, I'm annoyed. So much for syncing up tonight with -pre12, testing
> > (yeah, some of us still believe in TESTING), and thence onto coding.
> > I've spent the evening flushing out other people's turds. Grrr.
> 
> Turn off the computer, go spend a day cooling down for god sake.

Well, I went to bed shortly after my missive :-)

> One header file disappeared in the email pile somewhere. Of course
> if you'd _bothered_ to check the l/k archive before ranting you'd
> have found the posting about it.

Hm. I got testy because there were three broken things I stumbled over
in 12 hours. I think this just highlights the need for BitKeeper or
equivalent, where automated regression testing (even a simple "does it
compile and link?") is performed, and if the test fails, it gets
bounced and doesn't even get to Linus.

Alan: I realise it's impractical for you to manually test each
patchlet that you send to Linus, since you carry a large number of
them. But would you consider an automated system? I'm thinking of a
script that you use to "mail" each patch to Linus. Said script applies
and compiles, and either bounces the patch, or sends it off the Linus.
That way you get the same fire-and-forget behaviour you have now with
email, but with better testing.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
