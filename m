Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317372AbSFLX1P>; Wed, 12 Jun 2002 19:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317373AbSFLX1O>; Wed, 12 Jun 2002 19:27:14 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:56282 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S317372AbSFLX1O>;
	Wed, 12 Jun 2002 19:27:14 -0400
Date: Wed, 12 Jun 2002 16:27:14 -0700
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Re : ANN: Linux 2.2 driver compatibility toolkit
Message-ID: <20020612162714.A24255@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
In-Reply-To: <20020610174050.A21783@bougret.hpl.hp.com> <3D07D022.5030106@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2002 at 06:50:10PM -0400, Jeff Garzik wrote:
> 
> Sure, that would be fine too.
> 
> The main user demand has been for 2.4.x drivers on 2.2.x.  If there is 
> demand for 2.0.x driver support or, what you describe, 2.5.x driver 
> support on 2.[24].x, that's a good direction to head towards.  I haven't 
> seen any requests for that from driver authors yet.

	It seems that most of the 2.5.X construct are also available
in 2.4.X, but 2.5.X obsolete some of the old 2.4.X construct (for
example pci API).
	For me, the problem between 2.5.X and 2.4.X is the USB API
which has significantely changed (urb_submit anyone ?). I end up
having two quite different version of irda-usb to maintain. But
probably USB in 2.5.X. is too much a moving target for you to include
in your package.

> I am sadly guilty of "NIH" in several cases, but actually this is not 
> one of them :)  I think that kcompat24 provides a bit more of a complete 
> compatibility package than the other solutions.  So, I would like to 
> borrow code from pcmcia and other sources to make this toolkit even 
> better.  (patches accepted! :))

	Actually, NIH works both ways (so don't take personally). It
would be nice to have David Hinds using your package, because you
would immediately gain a sizeable user base, and because a lot of
Pcmcia drivers are both in the kernel and the Pcmcia package, and some
pour souls attempt to keep them in sync.
	For example, we currently have a unsatisfactory situation with
the orinoco and airo drivers.
	By the way, I didn't look in detail at kcompat24, but I
guarantee you that the latest Pcmcia package has quite a complete
solution.

> 	Jeff

	Have fun...

	Jean
