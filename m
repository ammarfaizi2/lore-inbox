Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932436AbWBMN2R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932436AbWBMN2R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 08:28:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932435AbWBMN2R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 08:28:17 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:4032 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S932108AbWBMN2Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 08:28:16 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Mon, 13 Feb 2006 14:26:54 +0100
To: greg@kroah.com, davidsen@tmr.com
Cc: schilling@fokus.fraunhofer.de, nix@esperi.org.uk,
       linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43F0891E.nailKUSCGC52G@burner>
References: <Pine.LNX.4.61.0601251523330.31234@yvahk01.tjqt.qr>
 <20060125144543.GY4212@suse.de>
 <Pine.LNX.4.61.0601251606530.14438@yvahk01.tjqt.qr>
 <20060125153057.GG4212@suse.de> <43D7AF56.nailDFJ882IWI@burner>
 <20060125181847.b8ca4ceb.grundig@teleline.es>
 <20060125173127.GR4212@suse.de> <43D7C1DF.1070606@gmx.de>
 <878xt3rfjc.fsf@amaterasu.srvr.nix> <43ED005F.5060804@tmr.com>
 <20060210235654.GA22512@kroah.com>
In-Reply-To: <20060210235654.GA22512@kroah.com>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> wrote:

> On Fri, Feb 10, 2006 at 04:06:39PM -0500, Bill Davidsen wrote:
> > 
> > The kernel could provide a list of devices by category. It doesn't have 
> > to name them, run scripts, give descriptions, or paint them blue. Just a 
> > list of all block devices, tapes, by major/minor and category (ie. 
> > block, optical, floppy) would give the application layer a chance to do 
> > it's own interpretation.
>
> It does so today in sysfs, that is what it is there for.

Do you really whant libscg to open _every_ non-directory file under /sys?

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
