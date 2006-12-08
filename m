Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1425289AbWLHJb5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425289AbWLHJb5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 04:31:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425290AbWLHJb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 04:31:57 -0500
Received: from ns9.hostinglmi.net ([213.194.149.146]:33842 "EHLO
	ns9.hostinglmi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1425289AbWLHJb4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 04:31:56 -0500
Date: Fri, 8 Dec 2006 10:32:32 +0100
From: DervishD <lkml@dervishd.net>
To: Matthias Schniedermeyer <ms@citd.de>
Cc: linux-kernel@vger.kernel.org, usb-storage@lists.one-eyed-alien.net
Subject: Re: single bit errors on files stored on USB-HDDs via USB2/usb_storage
Message-ID: <20061208093232.GA8065@DervishD>
Mail-Followup-To: Matthias Schniedermeyer <ms@citd.de>,
	linux-kernel@vger.kernel.org, usb-storage@lists.one-eyed-alien.net
References: <45773DD2.10201@citd.de> <20061207221015.GA342@DervishD> <45789C43.9020109@citd.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <45789C43.9020109@citd.de>
User-Agent: Mutt/1.4.2.2i
Organization: DervishD
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ns9.hostinglmi.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - dervishd.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Matthias :)

 * Matthias Schniedermeyer <ms@citd.de> dixit:
> >  * Matthias Schniedermeyer <ms@citd.de> dixit:
> > 
> >>Today i copied a few files back and checked them against the stored
> >>MD5 sums and 5 files of 86 (each about 700 MB) had errors. So i
> >>copied the 5 files again. 4 of the files were OK after that and
> >>coping the last file the third time also resulted in the correct
> >>MD5.
> > 
> > I had more or less the same issue a week or two ago. I performed
> > lots of tests and only by replacing the USB2.0 PCI card, the USB
> > cable and the power supply of the usb-hdd adapter got the
> > problem solved.
> > 
> The 38 HDDs are in 38 enclosures, so each has it's own power supply. I
> have used different cables and i replaced the USB-Controller once.
> 
> So it can't be a single faulty component. Except when the computer
> itself would be the culprit.

    In my case, the same applied: the problem didn't seem to be a single
faulty component, but a combination. Since I finally wasn't able to
check in another computer where I could carry tests, or check under
windows in the same machine, I don't know if the problem was a faulty
device driver, a faulty motherboard, RAM problems (although memtest said
my RAM was OK), etc.

> >     The best advice I can give you, from my limited experience with the
> > problem, is: replace the cable. This minimizes the chance of corrupted
> > data getting into the adapter. If that doesn't solve the problem, try
> > removing any unconnected cable that is plugged into the USB card.
> 
> Hmmm. That's the only thing that i currently may be doing wrong.
> I have a 1,5 Meter and a 4,5 Meter cable connected to the USB-Controller
> and i only use of them depending on where the HDD is placed in my room,
> the other one is dangling unconnected.

    I don't know why the heck this was causing problems, since any
electric noise that could be picked from the dangling cable shouldn't
affect neither the card nor the other USB ports, but...

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736 | http://www.dervishd.net
It's my PC and I'll cry if I want to... RAmen!
