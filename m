Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261398AbVE2SOt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261398AbVE2SOt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 14:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261395AbVE2SLd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 14:11:33 -0400
Received: from oldconomy.demon.nl ([212.238.217.56]:59830 "EHLO
	artemis.slagter.name") by vger.kernel.org with ESMTP
	id S261399AbVE2SLF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 14:11:05 -0400
Subject: Re: Playing with SATA NCQ
From: Erik Slagter <erik@slagter.name>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       Jens Axboe <axboe@suse.de>
In-Reply-To: <429A036D.8090104@pobox.com>
References: <20050526140058.GR1419@suse.de>
	 <1117382598.4851.3.camel@localhost.localdomain>
	 <4299EF16.2050208@pobox.com>
	 <1117385429.4851.8.camel@localhost.localdomain>
	 <4299F4E2.4020305@pobox.com>
	 <1117387432.4851.13.camel@localhost.localdomain>
	 <20050529172949.GA3578@havoc.gtf.org>
	 <1117388703.4851.21.camel@localhost.localdomain>
	 <429A036D.8090104@pobox.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 29 May 2005 20:10:51 +0200
Message-Id: <1117390251.4851.24.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-05-29 at 14:01 -0400, Jeff Garzik wrote:
> Erik Slagter wrote:
> > I guess the only way to have, for example the ICH6, not using legacy
> > IRQ/ports, is to switch it to AHCI, which only the BIOS can do (if
> > implemented).
> 
> "native mode" is where PATA and/or SATA PCI device is programmed into 
> full PCI mode -- PCI BARs, PCI irq, etc.  Some BIOSen allow you to 
> enable mode, which disables all use of legacy IRQ/ports.
> 
> Also, ICH6 silicon does not support AHCI, only ICH6-R and ICH6-M.

So, I do have this laptop with ICH6-M, is there a way to get it in
"native" mode without having to enable AHCI mode (can't do that, the
BIOS doesn't allow it)? I still think still using IRQ14/15 etc. is
silly ;-)
