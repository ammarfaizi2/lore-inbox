Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267448AbSLRWTA>; Wed, 18 Dec 2002 17:19:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267449AbSLRWSk>; Wed, 18 Dec 2002 17:18:40 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:41435 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S267445AbSLRWR0>; Wed, 18 Dec 2002 17:17:26 -0500
Date: Wed, 18 Dec 2002 17:27:30 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: AnonimoVeneziano <voloterreno@tin.it>
Cc: John Reiser <jreiser@BitWagon.com>, "" <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>, "" <black666@inode.at>
Subject: Re: IDE-CD and VT8235 issue!!!
In-Reply-To: <3E00F161.8090501@tin.it>
Message-ID: <Pine.LNX.4.50L.0212181726360.18764-100000@freak.distro.conectiva>
References: <3DFB7B21.7040004@tin.it> <3DFBC4F3.2070603@tin.it>
 <20021215215057.A12689@ucw.cz> <200212152256.25266.black666@inode.at>
 <20021216113458.A31837@ucw.cz> <3DFDD2FC.2030700@tin.it> <20021216141945.A32729@ucw.cz>
 <3DFDDF8C.8030609@tin.it> <20021218100338.B15267@ucw.cz> <3E00EE72.1020506@BitWagon.com>
 <3E00F161.8090501@tin.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 18 Dec 2002, AnonimoVeneziano wrote:

> John Reiser wrote:
>
> > Vojtech Pavlik wrote:
> >
> >> One more here, if you can try it (and remove the two previous ones
> >> first).
> >
> >
> > The earlier vt8235-dvd patch worked for me, but the later vt8235-min
> > did not.
> >
> > Mitsumi FX4830T ATAPI CD-ROM, MSI KT3 Ultra2 (KT333) mainboard, vt8235.
> > -----
> > kernel: hdc: status error: status=0x58 { DriveReady SeekComplete
> > DataRequest }
> > kernel: hdc: drive not ready for command
> > kernel: hdc: status timeout: status=0xd1 { Busy }
> > kernel: hdc: DMA disabled
> > kernel: hdc: drive not ready for command
> > kernel: hdc: ATAPI reset complete
> > kernel: hdc: status timeout: status=0xd1 { Busy }
> > kernel: hdc: drive not ready for command
> > -----
>
> Hunks error? during the patching?
>
> byez
>
> Marcello

Hi,

The lattest workaround from Vojtech fixed the problem for you ?
