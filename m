Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135335AbRDRVDv>; Wed, 18 Apr 2001 17:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135344AbRDRVDk>; Wed, 18 Apr 2001 17:03:40 -0400
Received: from kweetal.tue.nl ([131.155.2.7]:41790 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S135335AbRDRVDf>;
	Wed, 18 Apr 2001 17:03:35 -0400
Message-ID: <20010418230335.A17216@win.tue.nl>
Date: Wed, 18 Apr 2001 23:03:35 +0200
From: Guest section DW <dwguest@win.tue.nl>
To: Jens Axboe <axboe@suse.de>, Giuliano Pochini <pochini@shiny.it>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        lna@bigfoot.com
Subject: Re: I can eject a mounted CD
In-Reply-To: <E14pqzO-0004bp-00@the-village.bc.nu> <XFMail.010418150323.pochini@shiny.it> <20010418150622.P490@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <20010418150622.P490@suse.de>; from Jens Axboe on Wed, Apr 18, 2001 at 03:06:22PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 18, 2001 at 03:06:22PM +0200, Jens Axboe wrote:
> On Wed, Apr 18 2001, Giuliano Pochini wrote:

> > > vmware and one or two other apps I've also seen do this. WHen you unlock the
> > > cdrom door as root you can unlock it even if a file system is mounted
> > 
> > Right, so I'll check what eject(1) does. It might eject the disk even if it
> > failed to unmount.
> 
> It shouldn't be able to. But check and see what happens.

(1) There are many different programs all called eject(1).
I find at least four of them on this machine.

(2) I missed the start of the discussion; if this is a SCSI cdrom then
many eject programs will use raw SCSI commands and the kernel does not
try to parse raw SCSI commands so does not know that it is ejecting
a mounted cdrom.

Andries
