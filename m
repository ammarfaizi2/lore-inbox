Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932553AbVHNPZr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932553AbVHNPZr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 11:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932554AbVHNPZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 11:25:47 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:26601 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S932553AbVHNPZq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 11:25:46 -0400
Subject: Re: IT8212/ITE RAID
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Daniel Drake <dsd@gentoo.org>, CaT <cat@zip.com.au>,
       linux-kernel@vger.kernel.org
In-Reply-To: <58cb370e050814080120291979@mail.gmail.com>
References: <20050814053017.GA27824@zip.com.au>
	 <42FF263A.8080009@gentoo.org> <20050814114733.GB27824@zip.com.au>
	 <42FF3CBA.1030900@gentoo.org>
	 <1124026385.14138.37.camel@localhost.localdomain>
	 <58cb370e050814080120291979@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 14 Aug 2005 16:52:47 +0100
Message-Id: <1124034767.14138.55.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2005-08-14 at 17:01 +0200, Bartlomiej Zolnierkiewicz wrote:
> > Thats probably the fact other patches from -ac are missing in base. It
> > should be harmless.
> 
> Therefore please submit them.

Cut the crap, you know I've submitted the stuff again and again and
again along with other fixes, reports of stuff you broke you ignored
etc. So I got bored of playing your games.

> 
> > > > [227523.229631] hda: cache flushes not supported
> > > > [227523.229932]  hda:hda: recal_intr: status=0x51 { DriveReady SeekComplete Error }
> > > > [227523.230905] hda: recal_intr: error=0x04 { DriveStatusError }
> > > > [227523.230952] ide: failed opcode was: unknown
> > 
> > Yep - on my "wtf" list. In some cases we send a strange command to the
> > IT8212 drive. I'm still trying to find the guilty command we send (none
> > of my drives do this), so that I can fix the ident adjustment to stop
> > it. The noise is just the command being rejected which is ok but messy
> > and wants stomping.
> 
> small hint: WIN_RESTORE

Would make sense, but I thought I had the right bits masked. Will take a
look tomorrow however.

