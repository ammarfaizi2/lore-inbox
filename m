Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132590AbRDBG4w>; Mon, 2 Apr 2001 02:56:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132595AbRDBG4l>; Mon, 2 Apr 2001 02:56:41 -0400
Received: from mehl.gfz-potsdam.de ([139.17.1.100]:26844 "EHLO
	mehl.gfz-potsdam.de") by vger.kernel.org with ESMTP
	id <S132590AbRDBG4d> convert rfc822-to-8bit; Mon, 2 Apr 2001 02:56:33 -0400
Date: Mon, 2 Apr 2001 08:55:50 +0200
From: Steffen Grunewald <steffen@gfz-potsdam.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Cool Road Runner
Message-ID: <20010402085549.A27499@dss19>
Mail-Followup-To: Steffen Grunewald <steffen>, linux-kernel@vger.kernel.org
In-Reply-To: <20010330175900.I1396@dss19> <200103301752.f2UHqmV27328@webber.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200103301752.f2UHqmV27328@webber.adilger.int>; from adilger@turbolinux.com on Fri, Mar 30, 2001 at 10:52:48AM -0700
X-Disclaimer: I don't speak for no one else. And vice versa
X-Operating-System: SunOS
Content-Transfer-Encoding: 8BIT
X-MIME-Autoconverted: from 8bit to quoted-printable by dss19.gfz-potsdam.de id IAA27658
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2001-03-30 (10:52), Andreas Dilger wrote:
> Steffen Gruenwald writes:
> > The CompactFlash disk (a 32 MB SanDisk) is recognized as /dev/hda,
> > but the system fails to see the /dev/hdb disk (an IBM DARA-206000
> > jumpered as slave). When the IDE driver loads, it displays 
> > hda:pio, hdb:DMA - and yes, the BIOS assigns UDMA33 to the slave drive
> > while the master is detected as Mode1.
> > The IDE controller is a CS5530.
> 
> This was just discussed this week by Andre Hedrick.  You need to add a
> mount option like "hdb=flash" (I wasn't paying much attention).  This
> is because CF disks do not properly handle detection of slaves.  See:
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=98580536318380&w=4

OK, that makes things clearer. In addition to that, I also found that
2.2.15 fixes some things wrt the CS5530 controller chip. So I'll try both
things: a newer kernel (2.2.16 is in the SuSE upgrades) _and_ the append
parameter.

And BTW: Isn't Andre's writing style very lovely ?

Steffen, starting with fresh hope into a new week
-- 
 Steffen Grunewald | GFZ | PB 2.2 | Telegrafenberg E3 | D-14473 Potsdam
 » email: steffen(at)gfz-potsdam.de | fax/fon: +49-331-288-1266/-1245 «
 If at first you don't succeed, then you're in good company. - Lincoln
