Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267624AbUJIXuV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267624AbUJIXuV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 19:50:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267633AbUJIXuV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 19:50:21 -0400
Received: from rproxy.gmail.com ([64.233.170.205]:53630 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267624AbUJIXuO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 19:50:14 -0400
Message-ID: <58cb370e041009165041ecc96@mail.gmail.com>
Date: Sun, 10 Oct 2004 01:50:13 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [Announce] "iswraid" (ICH5R/ICH6R ataraid sub-driver) for 2.4.28-pre3
Cc: Martins Krikis <mkrikis@yahoo.com>, linux-kernel@vger.kernel.org,
       marcelo.tosatti@cyclades.com
In-Reply-To: <416875ED.6090503@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20041009204425.49483.qmail@web13725.mail.yahoo.com>
	 <200410092337.36488.bzolnier@elka.pw.edu.pl>
	 <41686121.7060607@pobox.com>
	 <58cb370e0410091622423bded0@mail.gmail.com>
	 <416875ED.6090503@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 09 Oct 2004 19:36:13 -0400, Jeff Garzik <jgarzik@pobox.com> wrote:
> 
> 
> Bartlomiej Zolnierkiewicz wrote:
> > On Sat, 09 Oct 2004 18:07:29 -0400, Jeff Garzik <jgarzik@pobox.com> wrote:
> >
> >>Bartlomiej Zolnierkiewicz wrote:
> >>
> >>>I may sound like an ignorant but...
> >>>
> >>>Why can't device mapper be merged into 2.4 instead?
> >>>Is there something wrong with 2.4 device mapper patch?
> >>>
> >>>It would more convenient (same driver for 2.4 and 2.6)
> >>>and would benefit users of other software RAIDs
> >>>(easier transition to 2.6).
> >>
> >>OTOH, that would be introducing a brand new RAID/LVM subsystem in the
> >>middle of a stable series...
> >
> >
> > Quoting Marcelo:
> >
> >
> >>New drivers are OK, as long as they dont break existing setups,
> >>and if substantial amount of users will benefit from it.
> >
> >
> > IMHO both conditions are fulfilled.
> 
> 
> Note I said "subsystem", Marcelo said "driver".  I don't object to
> adding DM to 2.4.x, but I think it's a rather large addition with
> consequences WRT LVM1 versus LVM2, and perhaps other issues as well.

I agree but merging iswraid into 2.4 can be compared to adding
new IDE host driver for SATA controller while libata is available.
I hope you get the idea. ;)
