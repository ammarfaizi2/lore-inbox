Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262107AbREPWO5>; Wed, 16 May 2001 18:14:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262109AbREPWOs>; Wed, 16 May 2001 18:14:48 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:11281 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262107AbREPWOn>; Wed, 16 May 2001 18:14:43 -0400
Message-ID: <3B02FBA6.86969BDE@transmeta.com>
Date: Wed, 16 May 2001 15:13:58 -0700
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5-pre1-zisofs i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
CC: Richard Gooch <rgooch@ras.ucalgary.ca>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        viro@math.psu.edu
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <200105152141.f4FLff300686@vindaloo.ras.ucalgary.ca> <Pine.LNX.4.05.10105160921220.23225-100000@callisto.of.borg> <200105161822.f4GIMo509185@vindaloo.ras.ucalgary.ca> <3B02D6AB.E381D317@transmeta.com> <200105162001.f4GK18X10128@vindaloo.ras.ucalgary.ca> <3B02DD79.7B840A5B@transmeta.com> <200105162054.f4GKsaF10834@vindaloo.ras.ucalgary.ca> <3B02F2EC.F189923@transmeta.com> <20010517001155.H806@nightmaster.csn.tu-chemnitz.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Oeser wrote:
> 
> We do this already with ide-scsi. A device is visible as /dev/hda
> and /dev/sda at the same time. Or think IDE-CDRW: /dev/hda,
> /dev/sr0 and /dev/sg0.
> 
> All at the same time.
> 

... and if you don't know about this funny aliasing, you get screwed. 
This is BAD DESIGN, once again.

> It is perfectly normal to export different interfaces for the
> same device. This is basically, what subfunctions on PCI do: Same
> device with different interfaces.
> 
> Just that we do it through a driver with ide and through the
> hardware with a multi function PCI card.
> 
> Applications don't care about devices. They care about entities
> that have capabilities and programming interfaces. What they
> _really_ are and if this is only emulated is not important.
> 
> Sorry, I don't see your point here :-(
> 

That seems to be a common theme with you.

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
