Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310913AbSCSX5Q>; Tue, 19 Mar 2002 18:57:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310916AbSCSX5G>; Tue, 19 Mar 2002 18:57:06 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:50962 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310913AbSCSX45>; Tue, 19 Mar 2002 18:56:57 -0500
Subject: Re: C-Media 8738 sound driver + A7M266-D problems.
To: christian.hoffmann@noos.fr (Christian HOFFMANN)
Date: Wed, 20 Mar 2002 00:13:02 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3C97D701.615.C93FC6@localhost> from "Christian HOFFMANN" at Mar 20, 2002 12:25:37 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16nTiw-0000kL-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Hi,
> I have the same motherboard at it include the hardware to support 6 
> speaker (and win2k support 6 channels)). I'm currently configuring 
> linux (gentoo with kernel 2.4.18) on my motherboard and don't yet 
> know about the rears chanels. I'll let you know.
> 
> Regards
> 
> 
> On 20 Mar 2002 at 0:10, Eric Lammerts wrote:
> 
> > 
> > On Mon, 18 Mar 2002, Mark wrote:
> > > I have a dual AMD board that has the 8738 onboard.  I compile 2.4.18 and
> > > pass it the '6 speaker' selection which should push the Rear speaker
> > > signal out the Line In connector and the Center Speaker Out/ Sub-woofer
> > > signal out the Mic In connector.  This does not happen.  I've tried this
> > > as a module and passing the params on the command line as well as
> > > compiling it directly into the kernel.  Am I missing something (very
> > > likely) or is this a known situation that I just have to deal with?
> > 
> > Are you sure your hardware supports 6-channel output? There are
> > several version of the 8738 chip (with/without spdif, 4/6 channel).
> > The chip should read something like "CMI8738/PCI-6CH".
> > 
> > Furthermore, it requires some extra hardware (analog multiplexers, for
> > example a 4053) to switch the connections. Maybe the manufacturer
> > left that out (to save a few cents).
> > 
> > Eric
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> 
> -----------------------------------------------
> Christian HOFFMANN <christian.hoffmann@noos.fr>
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

