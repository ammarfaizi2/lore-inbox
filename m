Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293234AbSCFFqV>; Wed, 6 Mar 2002 00:46:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293242AbSCFFqL>; Wed, 6 Mar 2002 00:46:11 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:38819 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S293234AbSCFFqD>; Wed, 6 Mar 2002 00:46:03 -0500
Date: Tue, 5 Mar 2002 22:45:58 -0700
Message-Id: <200203060545.g265jwL02756@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Greg KH <greg@kroah.com>
Cc: Sandino Araico =?iso-8859-1?Q?S=E1nchez?= <sandino@sandino.net>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.17,2.4.18 ide-scsi+usb-storage+devfs Oops
In-Reply-To: <20020306053355.GA13072@kroah.com>
In-Reply-To: <3C7EA7CB.C36D0211@sandino.net>
	<20020302075847.GE20536@kroah.com>
	<3C84294C.AE1E8CE9@sandino.net>
	<200203060528.g265Sh502430@vindaloo.ras.ucalgary.ca>
	<20020306053355.GA13072@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH writes:
> On Tue, Mar 05, 2002 at 10:28:43PM -0700, Richard Gooch wrote:
> > 
> > I suspect the USB-UHCI driver is doing a double-unregister on a devfs
> > entry. Please set CONFIG_DEVFS_DEBUG=y, recompile and boot the new
> > kernel. Send the new Oops (passed through ksymoops, of course).
> 
> None of the USB host controller drivers (like usb-uhci.c) call any
> devfs functions.

Well, usb-uhci was in the call trace. Perhaps ksymoops was being given
bogus input?

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
