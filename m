Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964877AbWBMWpF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964877AbWBMWpF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 17:45:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964885AbWBMWpF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 17:45:05 -0500
Received: from smtp.enter.net ([216.193.128.24]:65030 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S964877AbWBMWpD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 17:45:03 -0500
From: "D. Hazelton" <dhazelton@enter.net>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Date: Mon, 13 Feb 2006 17:54:05 -0500
User-Agent: KMail/1.8.1
Cc: mj@ucw.cz, peter.read@gmail.com, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, jim@why.dont.jablowme.net,
       jengelh@linux01.gwdg.de
References: <20060208162828.GA17534@voodoo> <mj+md-20060213.140141.31817.atrey@ucw.cz> <43F0A5E1.nailKUS106KMUQ@burner>
In-Reply-To: <43F0A5E1.nailKUS106KMUQ@burner>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602131754.06474.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 February 2006 10:29, Joerg Schilling wrote:
> Martin Mares <mj@ucw.cz> wrote:
> > Hello!
> >
> > > libscg abstracts from a kernel specific transport and allows to write
> > > OS independent applications that rely in generic SCSI transport.
> > >
> > > For this reason, it is bejond the scope of the Linux kernel team to
> > > decide on this abstraction layer. The Linux kernel team just need to
> > > take the current libscg interface as given as _this_  _is_ the way to
> > > do best abstraction.
> >
> > Do you really believe that libscg is the only way in the world how to
> > access SCSI devices?
> >
> > How can you be so sure that the abstraction you have chosen is the only
> > possible one?
> >
> > If an answer to either of this questions is NO, why do you insist on
> > everybody bending their rules to suit your model?
>
> Name me any other lib that is as OS independent and as clean/stable as
> libscg is. Note that the interface from libscg did not really change
> since August 1986.

OS Independant? Almost every userspace library that a linux system uses is OS 
independant. Stable interface? That's much harder since _most_ libraries 
change their interfaces incrementally as new technology or techniques become 
available to support them.

I did have an idea the other day and was wondering - why can't you, Joerg, add 
the capacity to CDRECORD to silently take a given /dev entry and turn it into 
your "needed" btl mapping?

> > > The Linux kernel team has the freedom to boycott portable user space
> > > SCSI applications or to support them.
> >
> > That's really an interesting view ... if anybody is boycotting anybody,
> > then it's clearly you, because you refuse to extend libscg to support
> > the Linux model, although it's clearly possible.
>
> Looks like you did not follow the discussion :-(
>
> I am constantly working on better support for Linux while the Linux kernel
> folks do not even fix obvious bugs.
>

Yes, you are, but you have made a very large mistake in your thinking. As an 
application and library developer you are supposed to build an application 
that works properly inside the framework provided by the OS. If your 
application does not work within the OS, then there is either a large bug in 
the OS (Not unheard of for M$ products, but in an Open Source product like 
Linux bugs that large do not survive long) or a bug in your program.

Since there is obviously no bug in the OS, and obviously no bug in cdrecord (I 
use it about once a week to make multi-cd backups) then your complaints about 
the "badly designed /dev/hd*" interface are just complaints from a programmer 
that thinks he's smarter than a hundred other people.

Since you appear to be a proponent of Solaris and use that on a regular basis 
it's my guess that you either 1) don't have the skill to create an OS and 
release it or 2) you are so mired in history and the "beauty" of your code 
that you refuse to change it at all. In this case I think the second option 
is the truth.

DRH
