Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312731AbSDBASf>; Mon, 1 Apr 2002 19:18:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312734AbSDBASZ>; Mon, 1 Apr 2002 19:18:25 -0500
Received: from dyn-212-129-51-155.ppp.libertysurf.fr ([212.129.51.155]:40329
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id <S312731AbSDBASP>; Mon, 1 Apr 2002 19:18:15 -0500
Date: Tue, 2 Apr 2002 02:14:24 +0200 (CEST)
From: Rui Sousa <rui.p.m.sousa@clix.pt>
X-X-Sender: rsousa@localhost.localdomain
To: Adam Huffman <bloch@verdurin.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Oops in emu10k1 driver
In-Reply-To: <20020401224514.GC2718@asus.verdurin.priv>
Message-ID: <Pine.LNX.4.44.0204020206050.1503-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Apr 2002, Adam Huffman wrote:

Hi,

First of all, which kernel are you using?
I believe I already fixed this bug in CVS but I haven't
received any confirmation. Can you give it a try?
You can get the CVS repository at:

http://sourceforge.net/cvs/?group_id=44773

Then edit the config file and point it to your kernel source,
make, make install. That should be it.

Otherwise (when I get your kernel version) I can send you a
patch to try out.

Rui Sousa

> On Mon, 01 Apr 2002, Alan Cox wrote:
> 
> > > VMware died when I put an audio CD into my DVD drive.  I wouldn't have
> > > mentioned it here but for the fact that there was an Oops and when
> > > decoded it pointed to the emu10k1 driver:
> > 
> > Yes but we don't know what vmware has been doing. Please try the same thing
> > a few times without vmware running
> > 
> > > kernel BUG at audio.c:1474!
> > > invalid operand: 0000
> > 
> > 
> > This one does look like a real bug in the emu10k driver, rather than a
> > vmware caused funny
> 
> Haven't been able to reproduce it with the VMware modules removed.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

