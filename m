Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293351AbSCFVAE>; Wed, 6 Mar 2002 16:00:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310163AbSCFU7z>; Wed, 6 Mar 2002 15:59:55 -0500
Received: from huitzilopochtli.presidencia.gob.mx ([200.57.34.35]:8166 "EHLO
	huitzilopochtli.presidencia.gob.mx") by vger.kernel.org with ESMTP
	id <S293351AbSCFU7s>; Wed, 6 Mar 2002 15:59:48 -0500
Message-ID: <3C868302.31C7BBC4@sandino.net>
Date: Wed, 06 Mar 2002 14:58:42 -0600
From: Sandino Araico =?iso-8859-1?Q?S=E1nchez?= <sandino@sandino.net>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: es-MX, es, es-ES, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Richard Gooch <rgooch@ras.ucalgary.ca>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.17,2.4.18 ide-scsi+usb-storage+devfs Oops
In-Reply-To: <3C7EA7CB.C36D0211@sandino.net> <20020302075847.GE20536@kroah.com> <3C84294C.AE1E8CE9@sandino.net> <200203060528.g265Sh502430@vindaloo.ras.ucalgary.ca> <20020306053355.GA13072@kroah.com> <200203060545.g265jwL02756@vindaloo.ras.ucalgary.ca> <20020306181956.GC16003@kroah.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

> On Tue, Mar 05, 2002 at 10:45:58PM -0700, Richard Gooch wrote:
> > Greg KH writes:
> > > On Tue, Mar 05, 2002 at 10:28:43PM -0700, Richard Gooch wrote:
> > > >
> > > > I suspect the USB-UHCI driver is doing a double-unregister on a devfs
> > > > entry. Please set CONFIG_DEVFS_DEBUG=y, recompile and boot the new
> > > > kernel. Send the new Oops (passed through ksymoops, of course).
> > >
> > > None of the USB host controller drivers (like usb-uhci.c) call any
> > > devfs functions.
> >
> > Well, usb-uhci was in the call trace. Perhaps ksymoops was being given
> > bogus input?
>
> I agree, with symbols like:
>         <[usb-uhci]__module_license+9099/fcd5>
> it looks like this is the case.
>

I had to copy the Oops trace by hand to a paper. Gpm is not working correctly
on my machine. Is there another way to send the Oops trace to a file?

--
Sandino Araico Sánchez
>drop table internet;
OK, 135454265363565609860398636678346496 rows affected.
"oh fuck" --fluxrad



