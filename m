Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310825AbSCSXsQ>; Tue, 19 Mar 2002 18:48:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310835AbSCSXsH>; Tue, 19 Mar 2002 18:48:07 -0500
Received: from lafontaine.noos.net ([212.198.2.72]:37727 "EHLO smtp.noos.fr")
	by vger.kernel.org with ESMTP id <S310825AbSCSXr4>;
	Tue, 19 Mar 2002 18:47:56 -0500
From: "Christian HOFFMANN" <christian.hoffmann@noos.fr>
To: linux-kernel@vger.kernel.org
Date: Wed, 20 Mar 2002 00:25:37 +0100
MIME-Version: 1.0
Subject: Re: C-Media 8738 sound driver + A7M266-D problems.
Message-ID: <3C97D701.615.C93FC6@localhost>
In-Reply-To: <Pine.LNX.4.43.0203182216260.32113-100000@bish.net>
X-mailer: Pegasus Mail for Windows (v4.01)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I have the same motherboard at it include the hardware to support 6 
speaker (and win2k support 6 channels)). I'm currently configuring 
linux (gentoo with kernel 2.4.18) on my motherboard and don't yet 
know about the rears chanels. I'll let you know.

Regards


On 20 Mar 2002 at 0:10, Eric Lammerts wrote:

> 
> On Mon, 18 Mar 2002, Mark wrote:
> > I have a dual AMD board that has the 8738 onboard.  I compile 2.4.18 and
> > pass it the '6 speaker' selection which should push the Rear speaker
> > signal out the Line In connector and the Center Speaker Out/ Sub-woofer
> > signal out the Mic In connector.  This does not happen.  I've tried this
> > as a module and passing the params on the command line as well as
> > compiling it directly into the kernel.  Am I missing something (very
> > likely) or is this a known situation that I just have to deal with?
> 
> Are you sure your hardware supports 6-channel output? There are
> several version of the 8738 chip (with/without spdif, 4/6 channel).
> The chip should read something like "CMI8738/PCI-6CH".
> 
> Furthermore, it requires some extra hardware (analog multiplexers, for
> example a 4053) to switch the connections. Maybe the manufacturer
> left that out (to save a few cents).
> 
> Eric
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-----------------------------------------------
Christian HOFFMANN <christian.hoffmann@noos.fr>

