Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261388AbVE2Sbq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261388AbVE2Sbq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 14:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261391AbVE2Sbq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 14:31:46 -0400
Received: from atlmail.prod.rxgsys.com ([69.61.70.25]:63389 "EHLO
	bastet.signetmail.com") by vger.kernel.org with ESMTP
	id S261388AbVE2Sbl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 14:31:41 -0400
Date: Sun, 29 May 2005 14:31:25 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Michael Thonke <iogl64nx@gmail.com>
Cc: Erik Slagter <erik@slagter.name>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org, Jens Axboe <axboe@suse.de>
Subject: Re: Playing with SATA NCQ
Message-ID: <20050529183125.GA6593@havoc.gtf.org>
References: <20050526140058.GR1419@suse.de> <1117382598.4851.3.camel@localhost.localdomain> <4299EF16.2050208@pobox.com> <1117385429.4851.8.camel@localhost.localdomain> <4299F4E2.4020305@pobox.com> <1117387432.4851.13.camel@localhost.localdomain> <20050529172949.GA3578@havoc.gtf.org> <1117388703.4851.21.camel@localhost.localdomain> <429A036D.8090104@pobox.com> <429A0977.5040601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <429A0977.5040601@gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 29, 2005 at 08:27:03PM +0200, Michael Thonke wrote:
> Jeff Garzik schrieb:
> 
> > Erik Slagter wrote:
> >
> >> I guess the only way to have, for example the ICH6, not using legacy
> >> IRQ/ports, is to switch it to AHCI, which only the BIOS can do (if
> >> implemented).
> >
> >
> > "native mode" is where PATA and/or SATA PCI device is programmed into
> > full PCI mode -- PCI BARs, PCI irq, etc.  Some BIOSen allow you to
> > enable mode, which disables all use of legacy IRQ/ports.
> >
> > Also, ICH6 silicon does not support AHCI, only ICH6-R and ICH6-M.
> >
> >     Jeff
> >
> Hello Jeff,
> 
> AHCI also works when the so called option "RAID mode" on ICH6R/ICH7 is set.
> 
> One question in addition when will the patch of Jens in libata-2.6
> tree?or is it already merged?

It is merged on the 'ncq' branch of libata-dev.git tree at
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git

If you need an intro to git, read http://lkml.org/lkml/2005/5/26/11

	Jeff




