Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319731AbSIMRt6>; Fri, 13 Sep 2002 13:49:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319732AbSIMRt5>; Fri, 13 Sep 2002 13:49:57 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:17674 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S319731AbSIMRt5>; Fri, 13 Sep 2002 13:49:57 -0400
Date: Fri, 13 Sep 2002 19:54:41 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Alex Davis <alex14641@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Possible bug and question about ide_notify_reboot in drivers/ide/ide.c (2.4.19)
Message-ID: <20020913175441.GN28541@louise.pinerecords.com>
References: <20020913023744.78077.qmail@web40510.mail.yahoo.com> <1031922553.9056.18.camel@irongate.swansea.linux.org.uk> <20020913151037.GM28541@louise.pinerecords.com> <1031930097.9679.0.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1031930097.9679.0.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
X-OS: GNU/Linux 2.4.20-pre1/sparc SMP
X-Uptime: 18 days, 23:42
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > I have
> > > > to go into the BIOS and force auto-detect to wake them back up. I've removed the "standby"
> > > > code and things seem to be functioning normally. I have an Epox 8K7A motherboard with two
> > > > Maxtor Hard drives (model 5T040H4).
> > > 
> > > Congratulations your BIOS sucks 8)
> > 
> > Alan, obviously this should be made into a config option.
> 
> I dont think so. We can't go around with 15,000 "My bios cant XYZ"
> options and "My PCI bus ...".

How about a kernel boot/module load option then?
Something like "ide0=ata66,noshutdown"
