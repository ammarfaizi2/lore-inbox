Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129129AbRBQQ4B>; Sat, 17 Feb 2001 11:56:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129183AbRBQQzv>; Sat, 17 Feb 2001 11:55:51 -0500
Received: from se1.cogenit.fr ([195.68.53.173]:53264 "EHLO se1.cogenit.fr")
	by vger.kernel.org with ESMTP id <S129129AbRBQQzn>;
	Sat, 17 Feb 2001 11:55:43 -0500
Date: Sat, 17 Feb 2001 17:54:48 +0100
From: Francois Romieu <romieu@cogenit.fr>
To: Dennis <dennis@etinc.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux stifles innovation...
Message-ID: <20010217175448.A32170@se1.cogenit.fr>
In-Reply-To: <5.0.0.25.0.20010216170349.01efc030@mail.etinc.com> <E14TtEx-0004Lr-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <E14TtEx-0004Lr-00@the-village.bc.nu>
X-Organisation: Marie's fan club - I
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> écrit :
[...]
> > For example, if there were six different companies that marketed ethernet 
> > drivers for the eepro100, you'd have a choice of which one to buy..perhaps 
> > with different "features" that were of value to you. Instead, you have 
> > crappy GPL code that locks up under load, and its not worth spending 
> 
> Umm I find the driver very reliable. And actually I have choice of two
> eepro100 drivers eepro100.c and e100.c so you cant even pick an example.
> 
> Of course your keenness to let people write alternative free drivers for
> your etinc pci card is extremely well known. Fortunately despite your best
> efforts there is now a choice in 2.4

Some words from the Ural mountains...
I wouldn't suggest to use my code in a production environment today (that's
why it's labelled 'EXPERIMENTAL' :o) ):
- I'm bad at handling Receive Data Overflow events. Here I suffer
from the lack of ability to trigger it. Now that I'm sharing my flat
with a (decent) traffic analyzer, I should be able to fix that.
- there are issues with the upper layers (I must do some more test
and document the whole). 
- the current way to handle the 'DSCC4 sometime forgets events' failure is
really gross and sub-optimal.

I've found time to buy a brand new computer and it should *really* help for 
these two points.

So far, my driver hasn't the required reliability that one expects to 
build a 4 ports router. Etinc's one may be better at this now*.
Well, I'll fix it. No need to be a genius.

Dennis, thanks to your closed source vision, I found an opportunity to 
fill a gap. Now, some people are willing to make $$$ with me.


*but it's not that difficult to find a way to crash it. A "Don't do that"
section on Etincs site would nicely replace the "Mine is bigger than yours" 
pages.

-- 
Ueimor
