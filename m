Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265645AbUFCQf7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265645AbUFCQf7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 12:35:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265650AbUFCQf7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 12:35:59 -0400
Received: from astra.telenet-ops.be ([195.130.132.58]:21728 "EHLO
	astra.telenet-ops.be") by vger.kernel.org with ESMTP
	id S265645AbUFCQf5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 12:35:57 -0400
Date: Thu, 3 Jun 2004 18:32:31 +0200 (CEST)
From: Michael De Nil <michael@flex-it.be>
X-X-Sender: flecxie@lisa.flex-it.be
To: Jakob Oestergaard <jakob@unthought.net>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: Promise PDC20378 Raid Accelerator
In-Reply-To: <20040603140829.GB30687@unthought.net>
Message-ID: <Pine.LNX.4.56.0406031829400.18403@lisa.flex-it.be>
References: <Pine.LNX.4.56.0406012040380.6191@lisa.flex-it.be> <40BD1032.604@pobox.com>
 <20040603140829.GB30687@unthought.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jun 2004, Jakob Oestergaard wrote:

> On Tue, Jun 01, 2004 at 07:24:34PM -0400, Jeff Garzik wrote:
> > Michael De Nil wrote:
> > >Can someone tell me if I will be able to run 2 SATA discs on a raid1 with
> > >this chip, and if yes, what driver you would prefer? I am a litle bit
> > >afraid for using non-stable drivers... ;)
> >
> >
> > The all-open-source solution...  Linux "md" raid, and Linux SATA drivers :)
>
> One caveat: you *may* have to create "one disk RAID-0" arrays of your
> disks (which is equivalent to the single disk), in order to make the
> SATA controller boot from the disk.  So, with two disks, you would
> create two RAID-0 arrays, each containing one disk.  Silly really, but
> at least I had to do this with the Promise TX4.
>
> Other than that; Standard Linux SATA drivers + Software RAID + LVM2 is a
> beautiful all-open-source solution for cheap flexible and reliable
> storage  -  my mom is using that   ;)
>

Thanks for the tip Jakob!

Can someone tell me if there is yet any support for hot swapping the sata
drives?


Thanks

michael
