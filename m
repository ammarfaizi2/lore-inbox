Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267773AbTBNXID>; Fri, 14 Feb 2003 18:08:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267815AbTBNXID>; Fri, 14 Feb 2003 18:08:03 -0500
Received: from havoc.daloft.com ([64.213.145.173]:1490 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S267773AbTBNXIC>;
	Fri, 14 Feb 2003 18:08:02 -0500
Date: Fri, 14 Feb 2003 18:17:52 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Ognen Duzlevski <ognen@kc.rr.com>, linux-kernel@vger.kernel.org
Subject: Re: Broadcom 10/100/1000 network cards and linux
Message-ID: <20030214231751.GA3338@gtf.org>
References: <3E4AA262.8060107@kc.rr.com> <20030214231305.GQ20159@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030214231305.GQ20159@fs.tum.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 15, 2003 at 12:13:05AM +0100, Adrian Bunk wrote:
> On Wed, Feb 12, 2003 at 01:37:06PM -0600, Ognen Duzlevski wrote:
> 
> > Hi, there was some discussion here in the past on the bugginess of the 
> > driver for the Broadcom 5702 Gb (10/100/1000) network cadrs (shipped 
> > mostly with Compaq/HP boxes as standard item). Is this still an issue or 
> > have the problems been resolved? Is this network card fully supported 
> > under Linux 2.4.x and 2.5.x?
> 
> It should be supported with the tg3 driver included in 2.4.20.
> 
> This driver should work OK.

Unfortunately this driver is missing several workarounds for
hardware bugs :/  This affects all chips, bcm5700 - bcm5704.

One should grab tg3 from 2.4.21-pre4 patch... or the latest Marcelo
repository.

	Jeff



