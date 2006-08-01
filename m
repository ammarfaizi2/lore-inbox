Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932495AbWHAQEm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932495AbWHAQEm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 12:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932515AbWHAQEl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 12:04:41 -0400
Received: from xenotime.net ([66.160.160.81]:27574 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932495AbWHAQEl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 12:04:41 -0400
Date: Tue, 1 Aug 2006 09:07:22 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Matt LaPlante <kernel1@cyberdogtech.com>
Cc: linux-kernel@vger.kernel.org, trivial@kernel.org
Subject: Re: [PATCH 18-rc2] Fix typos in /Documentation : 'N'-'P'
Message-Id: <20060801090722.d2f9c4f2.rdunlap@xenotime.net>
In-Reply-To: <20060801023910.9dc4b71d.kernel1@cyberdogtech.com>
References: <20060726023956.2e72b9d5.kernel1@cyberdogtech.com>
	<20060730202145.5c73cb64.rdunlap@xenotime.net>
	<20060801023910.9dc4b71d.kernel1@cyberdogtech.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Aug 2006 02:39:10 -0400 Matt LaPlante wrote:

> On Sun, 30 Jul 2006 20:21:45 -0700
> "Randy.Dunlap" <rdunlap@xenotime.net> wrote:
> 
> > On Wed, 26 Jul 2006 02:39:56 -0400 Matt LaPlante wrote:
> > 
> > > This patch fixes typos in various Documentation txts. The patch addresses some words starting with the letters 'N'-'P'.  
> > 
> > > diff -ru a/Documentation/dell_rbu.txt b/Documentation/dell_rbu.txt
> > > --- a/Documentation/dell_rbu.txt	2006-06-17 21:49:35.000000000 -0400
> > > +++ b/Documentation/dell_rbu.txt	2006-07-24 19:35:40.000000000 -0400
> > > @@ -93,7 +93,7 @@
> > >  NOTE:
> > >  This driver requires a patch for firmware_class.c which has the modified
> > >  request_firmware_nowait function.
> > > -Also after updating the BIOS image an user mdoe application neeeds to execute
> > > +Also after updating the BIOS image an user mode application needs to execute
> >                                       a
> > 
> > >  code which message the BIOS update request to the BIOS. So on the next reboot
> >               ^^^ huh?  change 'message' to 'sends' ?
> > 
> > >  the BIOS knows about the new image downloaded and it updates it self.
> >                                                                 itself.
> > 
> > >  Also don't unload the rbu drive if the image has to be updated.
> >                              driver ?
> > 
> > > diff -ru a/Documentation/s390/Debugging390.txt b/Documentation/s390/Debugging390.txt
> > > --- a/Documentation/s390/Debugging390.txt	2006-06-17 21:49:35.000000000 -0400
> > > +++ b/Documentation/s390/Debugging390.txt	2006-07-24 19:35:51.000000000 -0400
> > > @@ -1704,7 +1704,7 @@
> > >  IOP's can use one or more links ( known as channel paths ) to talk to each 
> > >  IO device. It first checks for path availability & chooses an available one,
> > >  then starts ( & sometimes terminates IO ).
> > > -There are two types of channel path ESCON & the Paralell IO interface.
> > > +There are two types of channel path ESCON & the Parallel IO interface.
> >                                   path: (or) path --
> >  
> > >  IO devices are attached to control units, control units provide the
> > >  logic to interface the channel paths & channel path IO protocols to 
> > 
> > > diff -ru a/Documentation/scsi/NinjaSCSI.txt b/Documentation/scsi/NinjaSCSI.txt
> > > --- a/Documentation/scsi/NinjaSCSI.txt	2006-06-17 21:49:35.000000000 -0400
> > > +++ b/Documentation/scsi/NinjaSCSI.txt	2006-07-24 19:35:51.000000000 -0400
> > > @@ -59,7 +59,7 @@
> > >  ...
> > >  $ make
> > >  
> > > -[5] Copy nsp_cs.o to suitable plase, like /lib/modules/<Kernel version>/pcmcia/ .
> > > +[5] Copy nsp_cs.o to a suitable place, like /lib/modules/<Kernel version>/pcmcia/ .
> > 
> > Should be nsp_cs.ko in 2.6.x.
> > 
> > >  [6] Add these lines to /etc/pcmcia/config .
> > >      If you yse pcmcia-cs-3.1.8 or later, we can use "nsp_cs.conf" file.
> >               use (later in your patches)
> > 
> > Thanks again.
> > ---
> > ~Randy
> 
> Updated below...

Acked-by: Randy Dunlap <rdunlap@xenotime.net>

---
~Randy
