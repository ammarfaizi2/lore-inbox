Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267664AbSLTAaG>; Thu, 19 Dec 2002 19:30:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267666AbSLTAaF>; Thu, 19 Dec 2002 19:30:05 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:27401
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S267664AbSLTAaF>; Thu, 19 Dec 2002 19:30:05 -0500
Date: Thu, 19 Dec 2002 19:40:31 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Marek Michalkiewicz <marekm@amelek.gda.pl>
cc: linux-kernel@vger.kernel.org
Subject: Re: parport_serial link order bug, NetMos support
In-Reply-To: <E18P8vO-0005Rs-00@alf.amelek.gda.pl>
Message-ID: <Pine.LNX.4.50.0212191929300.22130-100000@montezuma.mastecende.com>
References: <E18P8vO-0005Rs-00@alf.amelek.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Dec 2002, Marek Michalkiewicz wrote:

> > I have local patches which do the same and have been using them for about
> > a year too (also at 115k). Regarding the parallel port aspect of the card,
> > i have tested using shared IRQs by running an epat cdrom via said port and
> > generating a high amount of serial i/o
>
> Could you send me your local patches?  (I use parport in polling mode.)

Currently i use the following patch since i only tested the epat to ensure
that shared parport/serial irq would work.

For serial in 2.4.20
http://function.linuxpower.ca/patches/patch-parport_serial-2.4

For shared IRQs (probably would need hand patching)
http://function.linuxpower.ca/patches/patch-parport-irq1

> Would be nice to know exactly what these issues are.  My only issue with
> these cards so far is that I have to patch the kernel to use them...

Perhaps google, he did mention that he had netmos support in and then
backed it out again.

	Zwane
-- 
function.linuxpower.ca
