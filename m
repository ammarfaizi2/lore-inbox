Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293725AbSC0Xye>; Wed, 27 Mar 2002 18:54:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310214AbSC0XyY>; Wed, 27 Mar 2002 18:54:24 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:29826 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S310182AbSC0XyK>;
	Wed, 27 Mar 2002 18:54:10 -0500
Date: Thu, 28 Mar 2002 00:53:39 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Pavel Machek <pavel@suse.cz>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andre Hedrick <andre@linux-ide.org>,
        Wakko Warner <wakko@animx.eu.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: IDE and hot-swap disk caddies
Message-ID: <20020328005339.A22155@ucw.cz>
In-Reply-To: <20020326185238.A324@toy.ucw.cz> <E16qM41-0006HG-00@the-village.bc.nu> <20020327222900.GO19837@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2002 at 11:29:00PM +0100, Pavel Machek wrote:
> Hi!
> 
> 
> > > > You can paint a goose yellow and call it a duck, but it is still a goose.
> > > > The electrical/electronic interface will kill you!
> > > 
> > > USB mass storage is not SCSI (in some cases), either. [Ouch, and some
> > > usb-storage devices *are* IDE.]
> > > 
> > > So it makes sense to view IDE as very odd SCSI controllers.
> > 
> > IDE is very different. Its like calling NFS Netware. The upper layer
> > behaviour is fairly similar, and both ATAPI and USB mass storage is SCSI
> > alike (note if its not SCSI like its not USB mass storage its something else
> > eg a vendor specific driver).
> 
> I have seen USB mass storage devices with ide connector on them, so it
> is certainly possible to translate between scsi and ide. If it makes
> sense from performance standpoint.... I don't know.

That's between SCSI and ATAPI, which are mostly the same on command
level. ATA (IDE), which is used for harddrives is older, and different.

-- 
Vojtech Pavlik
SuSE Labs
