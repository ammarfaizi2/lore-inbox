Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317328AbSGIHAq>; Tue, 9 Jul 2002 03:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317329AbSGIHAp>; Tue, 9 Jul 2002 03:00:45 -0400
Received: from 62-190-203-199.pdu.pipex.net ([62.190.203.199]:10244 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S317328AbSGIHAn>; Tue, 9 Jul 2002 03:00:43 -0400
From: jbradford@dial.pipex.com
Message-Id: <200207090708.IAA00510@darkstar.example.net>
Subject: Re: ATAPI + cdwriter problem
To: mistral@stev.org (James Stevenson)
Date: Tue, 9 Jul 2002 08:08:17 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <006101c226ca$d0c9a380$0501a8c0@Stev.org> from "James Stevenson" at Jul 08, 2002 11:00:03 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> > What's the make and model of your CD-writer?  There are known firmware
> > bugs with a lot of them.
> 
> its a Benq 32x10x40 CD/RW
> running with the Promise ATA/133 controller

I personally have had loads of problems with Promise controllers, (there's one sitting in my cupboard at the moment, because I could never get it to work, and I was too busy to return it), and a friend of mine who runs an ISP returned some Promise IDE raid equipment, so I am begining to wonder if that is the problem.

If you are near S.E. London, you are welcome to borrow my Promise ATA/100 controller, and see if it helps.

I had a look at the Benq site, and they do have firmware upgrades:

http://www.benq.co.uk/ServiceAndSupport/Drivers/drivers.cfm?product=317

but I wouldn't immediately suspect that that would help.

> seems strange ide-scsi is the only thing i have ever had problems with.
> i know it also does not work with the other 2 cd drives in the machine as
> well.

On the same ATA controller?

> 1 is an old HP 2x2x6 7200+ writer (writes ok reading problems)
> and a normall 44x reader(will causes opps on reading bad media)

That makes me strongly suspect at it it the ATA interface to blame.  Can you try the CD-writer on another one?

> i have sent the oppen to the list before but they have always been ignored.

The list is pretty high volume, so if nobody is around who can answer your specific question at the time, it might get ignored.  Nothing personal :-).

> > John.
> >
> > > Hi
> > >
> > > i have  bunch of messages like these and a hung cd writer
> > >
> > > scsi : aborting command due to timeout : pid 28231, scsi0, channel 0, id
> 2,
> > > lun 0 Test Unit Ready 00 00 00 00 00
> > > SCSI host 0 abort (pid 28231) timed out - resetting
> > > SCSI bus is being reset for host 0 channel 0.
> > > hdg: ATAPI reset timed-out, status=0xd0
> > > PDC202XX: Secondary channel reset.
> > > ide3: reset: success
> > > hdg: irq timeout: status=0xc0 { Busy }
> > > hdg: status timeout: status=0xd0 { Busy }
> > > hdg: drive not ready for command
> > >
> > >
> > > anyone be able to suggest any action to help prevent it in the future ?
> > >
> > > thanks
> > >     James
> > >
> > > --------------------------
> > > Mobile: +44 07779080838
> > > http://www.stev.org
> > >   7:10pm  up 57 min,  3 users,  load average: 2.05, 1.84, 1.10
