Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750984AbWCBNCy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750984AbWCBNCy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 08:02:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750944AbWCBNCy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 08:02:54 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:14466 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750739AbWCBNCy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 08:02:54 -0500
Subject: Re: [PATCH] pcmcia: add another ide-cs CF card id
From: Arjan van de Ven <arjan@infradead.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, Jens Axboe <axboe@suse.de>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <4406E759.2010601@pobox.com>
References: <200603012259.k21MxBXC013582@hera.kernel.org>
	 <44062FF1.4010108@pobox.com> <20060302075004.GA17789@isilmar.linta.de>
	 <4406D44A.4020101@pobox.com>
	 <1141299117.3206.37.camel@laptopd505.fenrus.org>
	 <20060302114220.GH4329@suse.de>
	 <1141301225.3206.50.camel@laptopd505.fenrus.org>
	 <4406E1C7.7020908@pobox.com>
	 <20060302122409.GD14017@flint.arm.linux.org.uk>
	 <4406E759.2010601@pobox.com>
Content-Type: text/plain
Date: Thu, 02 Mar 2006 14:02:22 +0100
Message-Id: <1141304543.3206.60.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-02 at 07:38 -0500, Jeff Garzik wrote:
> Russell King wrote:
> > I think it's fairly safe and obvious to say that Dominik is the peer
> > review for these tables - he _is_ the PCMCIA maintainer, he _is_
> > arguably the maintainer for the ide-cs driver, he _is_ the person
> > who invented these tables, he _is_ the one taking patches from people
> > to add IDs, he _is_ the one reviewing such patches.
> > 
> > If you want to know what's going on in PCMCIA land, subscribe to
> > linux-pcmcia.  In the same way that if you want to know what's going
> > in in IDE land, you subscribe to linux-ide, or PCI land linux-pci,
> > SCSI land linux-scsi, network land netdev.
> > 
> > Using your argument (which seems to be demanding that any patch to
> > any IDE driver no matter how trivial must be on linux-ide) that a patch
> > to a PCI network device driver must be copied to linux-pci and netdev
> > even though it may not touch the PCI specific code.
> 
> IDE driver -> IDE reviewers
> 
> network driver -> network reviewers

I would turn this around

IDE impacting change -> IDE reviewers

network driver impacting change -> network reviewers

the reason for the review is because of the impact, not because a file
happens to live in a certain directory.


