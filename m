Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264725AbTFLEPF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 00:15:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264730AbTFLEPE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 00:15:04 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:39179
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S264725AbTFLEPB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 00:15:01 -0400
Date: Wed, 11 Jun 2003 21:15:54 -0700 (PDT)
From: Andre Hedrick <andre@pyxtechnologies.com>
To: Alan Cox <alan@redhat.com>
cc: Hugo Mills <hugo-lkml@carfax.org.uk>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: SiI3112 (Adaptec 1210SA): no devices
In-Reply-To: <200306052013.h55KDcP12104@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.10.10306112115300.30142-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It is the SiI3112 or SiI3114 behind and Adaptec munge.


Andre Hedrick
LAD Storage Consulting Group

On Thu, 5 Jun 2003, Alan Cox wrote:

> >    I've just taken delivery of a shiny new Adaptec 1210SA Serial-ATA
> > adapter and a 120Gb Seagate Barracuda native SATA drive. Problem is,
> > the kernel driver doesn't seem to notice this device on boot --
> 
> Its not a PCI identifier I've ever seen before
> 
> > 00:0b.0 RAID bus controller: CMD Technology Inc: Unknown device 0240 (rev 02) (prog-if 01)
> 
> So its some kind of CMD now SIS device, either an SI680 or SI3112 with a 
> weird PCI ID
> 
> 
> Does it have any option to put it into non raid mode in its bios ?
> 

