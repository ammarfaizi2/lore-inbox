Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265029AbUJLOha@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265029AbUJLOha (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 10:37:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264704AbUJLOgk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 10:36:40 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:23268 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265029AbUJLOdV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 10:33:21 -0400
Date: Mon, 11 Oct 2004 08:19:43 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Martins Krikis <mkrikis@yahoo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [Announce] "iswraid" (ICH5R/ICH6R ataraid sub-driver) for 2.4.28-pre3
Message-ID: <20041011111943.GA32430@logos.cnet>
References: <20041009204425.49483.qmail@web13725.mail.yahoo.com> <200410092337.36488.bzolnier@elka.pw.edu.pl> <41686121.7060607@pobox.com> <58cb370e0410091622423bded0@mail.gmail.com> <416875ED.6090503@pobox.com> <58cb370e041009165041ecc96@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58cb370e041009165041ecc96@mail.gmail.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 10, 2004 at 01:50:13AM +0200, Bartlomiej Zolnierkiewicz wrote:
> On Sat, 09 Oct 2004 19:36:13 -0400, Jeff Garzik <jgarzik@pobox.com> wrote:
> > 
> > 
> > Bartlomiej Zolnierkiewicz wrote:
> > > On Sat, 09 Oct 2004 18:07:29 -0400, Jeff Garzik <jgarzik@pobox.com> wrote:
> > >
> > >>Bartlomiej Zolnierkiewicz wrote:
> > >>
> > >>>I may sound like an ignorant but...
> > >>>
> > >>>Why can't device mapper be merged into 2.4 instead?
> > >>>Is there something wrong with 2.4 device mapper patch?
> > >>>
> > >>>It would more convenient (same driver for 2.4 and 2.6)
> > >>>and would benefit users of other software RAIDs
> > >>>(easier transition to 2.6).
> > >>
> > >>OTOH, that would be introducing a brand new RAID/LVM subsystem in the
> > >>middle of a stable series...
> > >
> > >
> > > Quoting Marcelo:
> > >
> > >
> > >>New drivers are OK, as long as they dont break existing setups,
> > >>and if substantial amount of users will benefit from it.
> > >
> > >
> > > IMHO both conditions are fulfilled.
> > 
> > 
> > Note I said "subsystem", Marcelo said "driver".  I don't object to
> > adding DM to 2.4.x, but I think it's a rather large addition with
> > consequences WRT LVM1 versus LVM2, and perhaps other issues as well.
> 
> I agree but merging iswraid into 2.4 can be compared to adding
> new IDE host driver for SATA controller while libata is available.
> I hope you get the idea. ;)

Yeah but this is quite different.

We already have device mapper "like" functionality in v2.4 with RAID/LVM. 

I dont think that mergin device mapper is an option really, not in my opinion.

It seems the general consensus is to merge iswraid, so I'm fine with it.

Martins, we are approaching -rc stage, I would prefer the merge to happen 
at the beginning of 2.4.29-pre. Is that fine for you?



