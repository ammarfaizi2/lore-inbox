Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129456AbRCFUtr>; Tue, 6 Mar 2001 15:49:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129473AbRCFUt1>; Tue, 6 Mar 2001 15:49:27 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:34054 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S129456AbRCFUtR>;
	Tue, 6 Mar 2001 15:49:17 -0500
Date: Tue, 6 Mar 2001 21:48:38 +0100
From: Jens Axboe <axboe@suse.de>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Microsoft ZERO Sector Virus, Result of Taskfile WAR
Message-ID: <20010306214838.V2803@suse.de>
In-Reply-To: <Pine.LNX.4.10.10103061206270.13719-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10103061206270.13719-100000@master.linux-ide.org>; from andre@linux-ide.org on Tue, Mar 06, 2001 at 12:10:43PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 06 2001, Andre Hedrick wrote:
> > >This virus acts in the following manner: It sends
> > >itself automatically to all contacts on your list
> > >with the title "A Virtual Card for You". As >soon as
> > >the supposed virtual card is opened, the computer
> > >freezes so that the user has to reboot.
> > >When the ctrl+alt+del keys or the reset button are
> > >pressed, the virus destroys Sector Zero, thus
> > >permanently destroying the hard disk.
> 
> This is a LIE, it does not destroy the drive, only the partition table.
> Please recally the limited effects of "DiskDestroyer" and "SCSIkiller"
> 
> This is why we had the flaming discussion about command filters.

But I might want to do this (write sector 0), why would we want
to filter that? If someone a) uses an email client that will execute
java script code (or whatever) and b) runs that as root (which
he would have to do, surely no ordinary user has privileges to send
arbitrary commands) then he gets what he deserves.

-- 
Jens Axboe

