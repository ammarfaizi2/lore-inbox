Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130074AbRBPKDp>; Fri, 16 Feb 2001 05:03:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130134AbRBPKDf>; Fri, 16 Feb 2001 05:03:35 -0500
Received: from 4dyn188.delft.casema.net ([195.96.105.188]:17682 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S130074AbRBPKDX>; Fri, 16 Feb 2001 05:03:23 -0500
Message-Id: <200102161003.LAA02713@cave.bitwizard.nl>
Subject: Re: 8139 full duplex?
In-Reply-To: <Pine.LNX.3.96.1010216034551.6404E-100000@mandrakesoft.mandrakesoft.com>
 from Jeff Garzik at "Feb 16, 2001 03:46:44 am"
To: Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>
Date: Fri, 16 Feb 2001 11:03:13 +0100 (MET)
CC: Rogier Wolff <R.E.Wolff@BitWizard.nl>, linux-kernel@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> On Fri, 16 Feb 2001, Rogier Wolff wrote:
> > I have a bunch of computers with 8139 cards. When I moved the cables
> > over from my hub to my new switch all the "full duplex" lights came on
> > immediately.
> > 
> > Would this mean that the driver/card already were in full-duplex? That
> > would explain me seeing way too many collisions on that old hub (which
> > obviously doesn't support full-duplex).
> > 
> > (Some machines run 2.2 kernels, others run 2.4 kernels some run the
> > old driver, others run the 8139too driver). 
> 
> Some versions of the driver bork the LED register, which may lead to
> false assumptions.

Does the driver control the led on my switch?????

(My cards just have a "link" led, and a "100Mbps" led)

I'm not going back to the hub after upgrading just to see the
changeover messages. I'm confident that we're running full-duplex now
on the switch and that that's OK with the switch. I was just wondering
wether this confirmed my suspicion that there was something wrong with
the /duplexicity/. 

			Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
