Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129444AbRAUUuH>; Sun, 21 Jan 2001 15:50:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130138AbRAUUt4>; Sun, 21 Jan 2001 15:49:56 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:54532
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S129444AbRAUUtr>; Sun, 21 Jan 2001 15:49:47 -0500
Date: Sun, 21 Jan 2001 12:49:40 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Mike Galbraith <mikeg@wen-online.de>, linux-kernel@vger.kernel.org
Subject: Re: [preview] Latest AMD & VIA IDE drivers with UDMA100 support
In-Reply-To: <20010121173251.B1073@suse.cz>
Message-ID: <Pine.LNX.4.10.10101211247580.3779-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Jan 2001, Vojtech Pavlik wrote:

> On Sun, Jan 21, 2001 at 01:42:41PM +0100, Mike Galbraith wrote:
> > On Sun, 21 Jan 2001, Vojtech Pavlik wrote:
> > 
> > > On Sat, Jan 20, 2001 at 02:57:07PM -0800, Andre Hedrick wrote:
> > > 
> > > > chipset ---\
> > > >             |
> > > >             \---------IDC-header
> > > > 
> > > > chipset ---+
> > > >            |
> > > >            +----------IDC-header
> > > > 
> > > > These are nearly the same but the corners cause bounce and iCRC's
> > 
> > I don't see how anyone can influence risetime falltime or impedance
> > matching [1] issues via software timing changes.
> > 
> > (the top drawing is what you see on a poorly designed board.. long
> > rise/fall times often cause worse problems than [slight] ringing)
> > 
> > > Well, there are other ways the motherboard maker can screw up the
> > > traces, and often this happens:
> > > 
> > > chipset --------\
> > >                 |
> > > chipset ------\ |
> > >               | \------ header
> > >               \-------- header
> > > 
> > 
> > Can you compensate for these things (to any degree?) in software?
> 
> Not really. Slowing the data rate down is in my opinion the only way to
> compensate for this. Btw, the chipset only controls the write data rate
> with UDMA. The read rate is controlled by the drive.
> 
> > 1.  Only a software guy would call it 'bounce'.. sounds funny ;-)

Er...I help design some of the hardware and the rules, so I do more than
just software.  So does 'echo' or 'reflections'sound better than 'bounce'?

Cheers,

Andre Hedrick
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
