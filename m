Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317141AbSGNUwC>; Sun, 14 Jul 2002 16:52:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317142AbSGNUwB>; Sun, 14 Jul 2002 16:52:01 -0400
Received: from zork.zork.net ([66.92.188.166]:14275 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id <S317141AbSGNUv6>;
	Sun, 14 Jul 2002 16:51:58 -0400
Date: Sun, 14 Jul 2002 21:54:51 +0100
From: Sean Neakums <sneakums@zork.net>
To: linux-kernel@vger.kernel.org
Subject: Re: IDE/ATAPI in 2.5
Message-ID: <20020714205451.GD9202@zork.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <200207142004.g6EK4LaV019433@burner.fokus.gmd.de> <1026683185.13886.81.camel@irongate.swansea.linux.org.uk> <xltn0sujb0v.fsf@shookay.newview.com> <1026683982.13885.85.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1026683982.13885.85.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.28i
X-Fnord: +++ath
X-WebTV-Stationery: Standard; BGColor=black; TextColor=black
X-Message-Flag: Message text advisory: HACKING, DENIAL OF THE ANTECEDENT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

commence  Alan Cox  quotation:
> On Sun, 2002-07-14 at 21:43, Mathieu Chouquet-Stringer wrote:
> > alan@lxorguk.ukuu.org.uk (Alan Cox) writes:
> > > On Sun, 2002-07-14 at 21:21, Mathieu Chouquet-Stringer wrote:
> > > > I'm running tar (the regular version not star) right now on an Athlon @
> > > > 850. The fs is ext3 and the disk is a scsi drive.
> > > > So far, tar has been running for 17 min 25 sec, and that's what top says:
> > > > CPU states:  1.7% user, 98.2% system,  0.0% nice,  0.0% idle
> > >                  ^^^^^^^^^^^^^^^^^^^^^^^^
> > > 
> > > Why are using PIO mode devices ?
> > 
> > I'm using SCSI :
> > Jul 13 16:35:50 mcs kernel: SCSI subsystem driver Revision: 1.00
> 
> Intriguing. Something horrible is happening on your system to see 98%
> system time off a bus mastering DMA controller. It should only look like
> that on things like an AHA152x 

I saw something similar when I tried untarring the file, and assumed
it was due to trying to put many thousands of files into a single flat
directory.

-- 
 /                          |
[|] Sean Neakums            |  Questions are a burden to others;
[|] <sneakums@zork.net>     |      answers a prison for oneself.
 \                          |
