Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311494AbSCNDTt>; Wed, 13 Mar 2002 22:19:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311496AbSCNDTi>; Wed, 13 Mar 2002 22:19:38 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:58351 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S311494AbSCNDT3>;
	Wed, 13 Mar 2002 22:19:29 -0500
Date: Wed, 13 Mar 2002 19:19:27 -0800
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.4.19-pre3] New wireless driver API part 1
Message-ID: <20020313191927.C14095@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
In-Reply-To: <20020313185915.A14095@bougret.hpl.hp.com> <3C901455.5000704@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C901455.5000704@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Wed, Mar 13, 2002 at 10:09:09PM -0500
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2002 at 10:09:09PM -0500, Jeff Garzik wrote:
> Tangential question, what's up with the prism2 driver?

	Which one ? ;-)
	Orinoco can work sometime with those cards, David may have
some updates in the pipeline (especially for WEP). The Prism2 driver
from Jouni is actually pretty nice and dedicated for those cards.

> It seems like everybody I meet these days has a wireless card which uses 
> the prism2 driver from linux-wlan.org.  And since I just got two of 
> these cards (D-Link DWL-650), I am strongly tempted to merge the driver 
> into the kernel.

	Before doing that, have a chat with Alan that had a close look
with it for a partial opinion. And you may want to go through the
source yourself.
	My personal take is that linux-wlan-ng is nice, does a lot,
but is huge and complex, and it seems that Mark is not that interested
in merging it in the kernel. Keeping it as a separate module may make
most sense.
	BTW, there was a thread about this on the linux-wlan mailing
lists.

> How well does the prism2 driver work with the current wireless driver API?

	Very basic support (mostly read only). linux-wlan-ng has it's
own set of tools and MIB.

> Is there any particular reason why it is not in the kernel now?

	Nobody ever pushed it in. I can't force people to add their
driver int he kernel (hint : compare the list on my web page with the
list in the kernel).

>     Jeff

	Have fun...

	Jean
