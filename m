Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131331AbRCHLcw>; Thu, 8 Mar 2001 06:32:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131330AbRCHLcn>; Thu, 8 Mar 2001 06:32:43 -0500
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:16655
	"EHLO ani.animx.eu.org") by vger.kernel.org with ESMTP
	id <S131324AbRCHLce>; Thu, 8 Mar 2001 06:32:34 -0500
Date: Thu, 8 Mar 2001 06:30:16 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: Metod Kozelj <metod.kozelj@rzs-hm.si>
Cc: "Justin T. Gibbs" <gibbs@scsiguy.com>, linux-kernel@vger.kernel.org,
        linux-alpha@vger.kernel.org
Subject: Re: 2.4.3-pre2 aic7xxx crash on alpha
Message-ID: <20010308063016.B1803@animx.eu.org>
In-Reply-To: <200103080445.f284jsO36939@aslan.scsiguy.com> <Pine.HPP.3.96.1010308095215.15847B-100000@hmljhp.rzs-hm.si>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <Pine.HPP.3.96.1010308095215.15847B-100000@hmljhp.rzs-hm.si>; from Metod Kozelj on Thu, Mar 08, 2001 at 10:08:32AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > >(scsi1:A:0:0): data overrun detected in Data-out phase.  Tag == 0x36.
> > >(scsi1:A:0:0): Have seen Data Phase.  Length = 0.  NumSGs = 0.
> > 
> > As I mentioned to you the last time you brought up this problem, I
> > don't believe that this is caused by the aic7xxx driver, but the
> > aic7xxx driver may be the first to notice the corruption.
> 
> I can second this somehow. I was testing 2.4.2 on SX164 alpha, same
> AHA-2940UW controller. In my case, system freezes solid if I do extensive
> reading from CD-ROM (NEC CD-ROM DRIVE:465). It happens using stock AIC7xxx
> driver (5.3.something) as well as the new (6.1.2 or something).
> I'm back to 2.2.18 using AIC7xxx v5.1.31 and everything is happy.
> This makes me believe that it must be mid-layer SCSI drivers causing
> problems.

I tried the aic driver from 2.2.17 and 18 which also lockup this system.

Noone on the list that I've seen has used an adaptec card in an alphaserver
1000a 4/266 and said anything about it.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
