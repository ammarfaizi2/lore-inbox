Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262360AbTHaB5k (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 21:57:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262368AbTHaB5k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 21:57:40 -0400
Received: from modemcable009.53-202-24.mtl.mc.videotron.ca ([24.202.53.9]:7297
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S262360AbTHaB5i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 21:57:38 -0400
Date: Sat, 30 Aug 2003 21:57:29 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: papadako@csd.uoc.gr, linux-kernel@vger.kernel.org
Subject: Re: IOMEGA ZIP 100 ATAPI problems with 2.6
In-Reply-To: <33069.4.4.25.4.1062294245.squirrel@www.osdl.org>
Message-ID: <Pine.LNX.4.53.0308302156450.16584@montezuma.fsmlabs.com>
References: <Pine.GSO.4.53.0308310037230.27956@oneiro.csd.uch.gr>
 <33069.4.4.25.4.1062294245.squirrel@www.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Aug 2003, Randy.Dunlap wrote:

> > With all of the 2.5, 2.6 kernels I have tried(currently 2.6.0-test4-mm3), I
> > have problems with my Zip.I can mount and umount it cleanly but when I try
> > to write something from it in my disk either cp will just
> > segfault or my system will just reboot. Also when I am in KDE it will lockup
> > my system and kernel reports the messages that are in the end of the mail.
> > Also with hdparm -I /dev/hdd the kernel prints the following message: hdd:
> > drive_cmd: status=0x51 { DriveReady SeekComplete Error }
> > hdd: drive_cmd: error=0x04
> >
> > P.S.
> > The Zip works with 2.4 kernels...
> 
> What interface on the ZIP 100?  I have parallel, SCSI, USB, or
> ZipPlus (imm driver).  Is there another (ATAPI) interface model also?

There are the internal IDE/ATAPI ones, i have one here. Perhaps it's time 
to torture Bartlomiej some more?

	Zwane

