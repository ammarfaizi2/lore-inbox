Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932314AbWBMOfM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932314AbWBMOfM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 09:35:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932346AbWBMOfL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 09:35:11 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:2689 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S932118AbWBMOfJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 09:35:09 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Mon, 13 Feb 2006 15:33:06 +0100
To: schilling@fokus.fraunhofer.de, peter.read@gmail.com, mj@ucw.cz,
       matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       jim@why.dont.jablowme.net, jengelh@linux01.gwdg.de, alex@samad.com.au
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43F098A2.nailKUSL1W9PE@burner>
References: <43EA1D26.nail40E11SL53@burner>
 <20060208165330.GB17534@voodoo> <43EB0DEB.nail52A1LVGUO@burner>
 <Pine.LNX.4.61.0602091729560.30108@yvahk01.tjqt.qr>
 <43EB7210.nailIDH2JUBZE@burner>
 <Pine.LNX.4.61.0602091813260.30108@yvahk01.tjqt.qr>
 <43EB7BBA.nailIFG412CGY@burner>
 <mj+md-20060209.173519.1949.atrey@ucw.cz>
 <43EC71FB.nailISD31LRCB@burner> <20060210114930.GC2750@DervishD>
 <20060213005002.GK26235@samad.com.au>
In-Reply-To: <20060213005002.GK26235@samad.com.au>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Samad <alex@samad.com.au> wrote:

> On Fri, Feb 10, 2006 at 12:49:30PM +0100, DervishD wrote:
> >     Hi Joerg :)
> > 
> >  * Joerg Schilling <schilling@fokus.fraunhofer.de> dixit:
> > > Martin Mares <mj@ucw.cz> wrote:
> > > > > This is why the mapping engine is in the Linux adoption part of
> > > > > libscg. It maps the non-stable device <-> /dev/sg* relation to a
> > > > > stable b,t,l address.
> > > >
> > > > Nonsense. The b,t,l addresses are NOT stable (at least for transports
> > > 
> > > Dou you like to verify that you have no clue on SCSI?
> > 
> >     My system is clueless, too! If I write a CD before plugging my
> > USB storage device, my CD writer is on 0,0,0. If I plug my USB
> > storage device *before* doing any access, my cdwriter is on 1,0,0.
> > Pretty stable.
>
> Had exactly the same problem with firewire and usb devices, depending on
> the order of the loading of the kernel modules it all changes!

This is a deficite of the Linux kernel model. You don't have similar
problems on Solaris.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
