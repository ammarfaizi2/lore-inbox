Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312748AbSCYWVe>; Mon, 25 Mar 2002 17:21:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312737AbSCYWVY>; Mon, 25 Mar 2002 17:21:24 -0500
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:63940
	"EHLO ani.animx.eu.org") by vger.kernel.org with ESMTP
	id <S312748AbSCYWVO>; Mon, 25 Mar 2002 17:21:14 -0500
Date: Mon, 25 Mar 2002 17:32:34 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: IDE and hot-swap disk caddies
Message-ID: <20020325173234.A18888@animx.eu.org>
In-Reply-To: <20020325152617.A18605@animx.eu.org> <Pine.LNX.4.10.10203251319100.1305-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > >   The way you say that makes me think that it does support at some other
> > > > level... hot swap controller? Doesn't match MY hardware. Hot swap
> > > 
> > > Controller level hotswap works mostly (think about pcmcia ide for example)
> > 
> > Just to throw this out there.  Is it possible to make the ide subsystem look
> > like a scsi controller ?  that way the scsi layer could insert/remove
> > devices.  say: ide0/1 = scsi0 (assuming no other scsi controllers) and hda =
> > scsi0 channel0 id0 lun0  and hdc = scsi0 channel1 id0 lun0 ...
> > 
> > Personally, if it's doable, i'd like it.
> 
> Hardware is different.
> You can paint a goose yellow and call it a duck, but it is still a goose.
> The electrical/electronic interface will kill you!

how is it different than all the different scsi controllers?

What I'm saying is an ide module that talks to the ide hardware and to the
scsi subsystem.

both scsi and ide support disks, tapes, cdroms, and other removable media.

IIRC, windows nt sees ide controllers as a scsi controller (in a sence)

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
