Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261550AbSK0Efp>; Tue, 26 Nov 2002 23:35:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261568AbSK0Efp>; Tue, 26 Nov 2002 23:35:45 -0500
Received: from nakyup.mizi.com ([203.239.30.70]:46745 "EHLO nakyup.mizi.com")
	by vger.kernel.org with ESMTP id <S261550AbSK0Efo>;
	Tue, 26 Nov 2002 23:35:44 -0500
Date: Wed, 27 Nov 2002 13:35:32 +0900
From: Young-Ho Cha <ganadist@nakyup.mizi.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.49 module problem
Message-ID: <20021127043532.GA25666@nakyup.mizi.com>
References: <20021126193026.Q14666-100000@sorrow.ashke.com> <1038362008.2594.112.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline
In-Reply-To: <1038362008.2594.112.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 27, 2002 at 01:53:28AM +0000, Alan Cox wrote:
> On Wed, 2002-11-27 at 00:40, Adam K Kirchhoff wrote:
> > 
> > Hello all.
> > 
> > Sorry to bother everyone with what is probably a stupid user error, but in
> > case it's not I thought I should post my problem to the list.
> > 
> > I recently upgraded my motherboard to one with an ICH4 IDE controller.
> > Since it's not supported in 2.4.*, yet, I decided now would be a good time
> 
> 2.4.20-rc4 should handle your ICH4 fine
> 
> 2.5.49 needs new very different module tools
> 
I use rusty's module init tools with modutils 2.4.22.

But many modules cannot load.

attach some list of modules that kernel cannot load.

--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="test.log"

FATAL: Error inserting /lib/modules/2.5.49-ac2/kernel/ac97_codec.o: Invalid module format
FATAL: Error inserting /lib/modules/2.5.49-ac2/kernel/core.o: Invalid module format
FATAL: Error inserting /lib/modules/2.5.49-ac2/kernel/exportfs.o: Invalid module format
FATAL: Error inserting /lib/modules/2.5.49-ac2/kernel/g450_pll.o: Invalid module format
FATAL: Error inserting /lib/modules/2.5.49-ac2/kernel/gameport.o: Invalid module format
FATAL: Error inserting /lib/modules/2.5.49-ac2/kernel/matroxfb_DAC1064.o: Invalid module format
FATAL: Error inserting /lib/modules/2.5.49-ac2/kernel/matroxfb_Ti3026.o: Invalid module format
FATAL: Error inserting /lib/modules/2.5.49-ac2/kernel/matroxfb_accel.o: Invalid module format
FATAL: Error inserting /lib/modules/2.5.49-ac2/kernel/matroxfb_g450.o: Invalid module format
FATAL: Error inserting /lib/modules/2.5.49-ac2/kernel/matroxfb_misc.o: Invalid module format
FATAL: Error inserting /lib/modules/2.5.49-ac2/kernel/mii.o: Invalid module format
FATAL: Error inserting /lib/modules/2.5.49-ac2/kernel/p8022.o: Invalid module format
FATAL: Error inserting /lib/modules/2.5.49-ac2/kernel/sb_lib.o: Invalid module format
FATAL: Error inserting /lib/modules/2.5.49-ac2/kernel/snd-seq-midi-event.o: Invalid module format
FATAL: Error inserting /lib/modules/2.5.49-ac2/kernel/uart6850.o: Invalid argument
FATAL: Error inserting /lib/modules/2.5.49-ac2/kernel/usbvideo.o: Invalid module format
FATAL: Error inserting /lib/modules/2.5.49-ac2/kernel/v4l2-common.o: Invalid module format
FATAL: Error inserting /lib/modules/2.5.49-ac2/kernel/video-buf.o: Invalid module format

--PEIAKu/WMn1b1Hv9--
