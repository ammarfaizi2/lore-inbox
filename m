Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274031AbRISLab>; Wed, 19 Sep 2001 07:30:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274035AbRISLaU>; Wed, 19 Sep 2001 07:30:20 -0400
Received: from fe010.worldonline.dk ([212.54.64.195]:8452 "HELO
	fe010.worldonline.dk") by vger.kernel.org with SMTP
	id <S274031AbRISLaL>; Wed, 19 Sep 2001 07:30:11 -0400
Date: Wed, 19 Sep 2001 13:30:24 +0200
From: Jens Axboe <axboe@suse.de>
To: root <root@denise.shiny.it>
Cc: Xavier Bestel <xavier.bestel@free.fr>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.9-ac10 hangs on CDROM read error
Message-ID: <20010919133023.G639@suse.de>
In-Reply-To: <1000833035.29346.11.camel@nomade> <Pine.LNX.4.21.0109190949080.16911-100000@denise.shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0109190949080.16911-100000@denise.shiny.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19 2001, root wrote:
> 
> 
> > I have an ABit VP6, CDRW as hdc and DVD as hdd (VIA vt82c686b IDE
> > driver), with SCSI emulation on top, and when I read either:
> >
> > - a DVD with a read error in the DVD drive (UDF mounted, ripping)
> >
> > - a CDR with a read error in the CDRW drive (ISO mounted)
> >
> > the system hangs - no ping, no sysrq, nothing. no log.
> 
> I have the same problem with PowerMac G3 and G4 with IDE drives. No
> problems with SCSI, where read just stops with an I/O error.

Could one of you hook up a serial console and attempt to capture any
oops info?

-- 
Jens Axboe

