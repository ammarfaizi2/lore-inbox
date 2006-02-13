Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932433AbWBMN0U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932433AbWBMN0U (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 08:26:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932436AbWBMN0U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 08:26:20 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:18111 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S932433AbWBMN0T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 08:26:19 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Mon, 13 Feb 2006 14:24:59 +0100
To: davidsen@tmr.com, chris@gnome-de.org
Cc: schilling@fokus.fraunhofer.de, nix@esperi.org.uk,
       linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43F088AB.nailKUSB18RM0@burner>
References: <787b0d920601241923k5cde2bfcs75b89360b8313b5b@mail.gmail.com>
 <Pine.LNX.4.61.0601251523330.31234@yvahk01.tjqt.qr>
 <20060125144543.GY4212@suse.de>
 <Pine.LNX.4.61.0601251606530.14438@yvahk01.tjqt.qr>
 <20060125153057.GG4212@suse.de>
 <43D7AF56.nailDFJ882IWI@  <43ED005F.5060804@tmr.com>
 <1139615496.10395.36.camel@localhost.localdomain>
In-Reply-To: <1139615496.10395.36.camel@localhost.localdomain>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Neumair <chris@gnome-de.org> wrote:

> Am Freitag, den 10.02.2006, 16:06 -0500 schrieb Bill Davidsen:
> > The kernel could provide a list of devices by category. It doesn't have 
> > to name them, run scripts, give descriptions, or paint them blue. Just a 
> > list of all block devices, tapes, by major/minor and category (ie. 
> > block, optical, floppy) would give the application layer a chance to do 
> > it's own interpretation.
>
> Introducing more than interface for doing the same thing can be very
> confusing and counter-productive. You'll create new, undocumented or
> semi-documented interfaces which will lead to a dependency chaos.

So you concur with me that the fact that Linux introduced another interface
for SCSI was onfusing and counter-productive.


> Some random script will work with kernel 2.6.11, 2.6.12 and 2.6.13, but
> not 2.6.14 and later because a new device class was introduced and two
> typos were fixed. Especially considering that the new linux development
> model makes it likely that major changes go into micro releases,
> stability and reliability will be a huge problem.

The main problem is that there is no grant that a new model will survive
a time frame that makes sense to implement support.

> > Since -scanbus tells you a 
> > device is a CDrecorder, or something else, *any user* is likely to be 
> > able to tell it from DCD, CD-ROM, etc. Nice like of text for most devices...
>
> Well, "any user" just opens his Windows Explorer and takes a look at the
> icon of his drive D:\\ to see whether it's a CD-ROM or DVD. It is
> interesting to see professional programmers often argue that a

This is not true: a drive letter mapping does not need to exist on MS-WIN
in order to be able to access it via ASPI or SPTI.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
