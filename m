Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289225AbSAGPmu>; Mon, 7 Jan 2002 10:42:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289231AbSAGPmk>; Mon, 7 Jan 2002 10:42:40 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:49301 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S289225AbSAGPma>;
	Mon, 7 Jan 2002 10:42:30 -0500
Date: Mon, 7 Jan 2002 16:41:37 +0100
From: David Weinehall <tao@acc.umu.se>
To: Christoph Hellwig <hch@ns.caldera.de>
Cc: Jaroslav Kysela <perex@suse.cz>, sound-hackers@zabbo.net,
        linux-sound@vger.rutgers.edu, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: ALSA patch for 2.5.2pre9 kernel
Message-ID: <20020107164136.I5235@khan.acc.umu.se>
In-Reply-To: <Pine.LNX.4.31.0201061814580.545-100000@pnote.perex-int.cz> <200201071432.g07EWI802933@ns.caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <200201071432.g07EWI802933@ns.caldera.de>; from hch@ns.caldera.de on Mon, Jan 07, 2002 at 03:32:18PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2002 at 03:32:18PM +0100, Christoph Hellwig wrote:
> In article <Pine.LNX.4.31.0201061814580.545-100000@pnote.perex-int.cz> you wrote:
> > The latest patch is alsa-2002-01-06-1-linux-2.5.2pre9.patch.gz and
> > contains:
> 
> > * moved linux/drivers/sound directory to linux/sound/oss
> > * moved sound core files to linux/sound
> > * integrated ALSA kernel code
> >   - linux/include/sound - sound header files
> >   - linux/sound/core	- midlevel (no hw dependent) code
> >   - linux/sound/drivers - generic drivers (no arch dependent)
> >   - linux/sound/i2c     - reduced I2C core and drivers
> >   - linux/sound/isa	- ISA sound hardware drivers
> >   - linux/sound/pci	- PCI sound hardware drivers
> >   - linux/sound/ppc	- PowerPC sound hardware drivers
> >   - linux/sound/synth	- generic synthesizer support code
> 
> > We appreciate any comments regarding directory structure
> 
> linux/sound is silly.  It's drivers so put it under linux/drivers/sound.
> Everything else seems to be sane to me.

One question: What happens with hardware both available in both isa & pci
versions (or any other combination that doesn't fit into this
sorting?!)


/David
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
