Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266249AbUHNW4k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266249AbUHNW4k (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 18:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266259AbUHNW4k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 18:56:40 -0400
Received: from havoc.gtf.org ([216.162.42.101]:3731 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S266249AbUHNW4i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 18:56:38 -0400
Date: Sat, 14 Aug 2004 18:56:34 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux SATA RAID FAQ
Message-ID: <20040814225634.GA17171@havoc.gtf.org>
References: <E1BvFmM-0007W5-00@calista.eckenfels.6bone.ka-ip.net> <1092315392.21994.52.camel@localhost.localdomain> <411BA7A1.403@pobox.com> <411BA940.5000300@pobox.com> <1092520163.27405.11.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092520163.27405.11.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 14, 2004 at 10:49:24PM +0100, Alan Cox wrote:
> On Iau, 2004-08-12 at 18:30, Jeff Garzik wrote:
> > > The SX4 has an on-board DIMM (128M - 2G), through which all data _must_ 
> > > pass.  The data transfer between host and on-board DIMM is a separate 
> > > DMA engine and separate interrupt event from the four ATA DMA engines 
> > > (one per SATA port).  There are several possibilities that are worth 
> > > exploring on this card:
> > > 
> > > * Caching
> 
> Is it battery backed ? If it is battery backed then its useful, if not
> then it becomes less useful although not always. The i2o drivers have
> some ioctls so you can turn on writeback caching even without battery
> backup. While this is suicidal for filesytems its just great for swap..

Nope not battery backed...

	Jeff




