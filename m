Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317335AbSFGUDT>; Fri, 7 Jun 2002 16:03:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317336AbSFGUDS>; Fri, 7 Jun 2002 16:03:18 -0400
Received: from internal-bristol34.naxs.com ([216.98.66.34]:49373 "EHLO
	coredump.electro-mechanical.com") by vger.kernel.org with ESMTP
	id <S317335AbSFGUDR>; Fri, 7 Jun 2002 16:03:17 -0400
Date: Fri, 7 Jun 2002 15:58:23 -0400
From: William Thompson <wt@electro-mechanical.com>
To: Samuel Flory <sflory@rackable.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: PDC20267 + RAID can't find raid device
Message-ID: <20020607155823.S7291@coredump.electro-mechanical.com>
In-Reply-To: <20020606111918.F7291@coredump.electro-mechanical.com> <1023391095.3423.112.camel@flory.corp.rackablelabs.com> <1023463727.25522.39.camel@irongate.swansea.linux.org.uk> <1023479646.3700.174.camel@flory.corp.rackablelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > >   One major issue for me is that you can use, and mount both the
> > > /dev/ataraid/d0 devices, and the /dev/hd devices.  This makes for lots
> > > of fun in the Red Hat installer, and Cerberus.   
> > 
> > Stupidity management for the superuser is a user space issue in Unix
> > systems. If the RH installer does let you do stupid things, please
> > bugzilla it.
> 
>   Actually I was looking at what it would take to add support for
> ataraid in the RH installer.  Is there some simple way to determine that
> a device is a part of an ataraid array?  Parsing dmesg makes for some
> really ugly and easily broken code.

The controller IIRC writes this information on the disk.  I'm pretty sure
it's toward the end of the disk though.
