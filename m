Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265108AbTFEUAL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 16:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265102AbTFEUAK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 16:00:10 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:55201 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S265020AbTFEUAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 16:00:09 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200306052013.h55KDcP12104@devserv.devel.redhat.com>
Subject: Re: SiI3112 (Adaptec 1210SA): no devices
To: hugo-lkml@carfax.org.uk (Hugo Mills)
Date: Thu, 5 Jun 2003 16:13:38 -0400 (EDT)
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       andre@linux-ide.org, alan@redhat.com
In-Reply-To: <20030605193514.GB1542@carfax.org.uk> from "Hugo Mills" at Meh 05, 2003 08:35:14 
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>    I've just taken delivery of a shiny new Adaptec 1210SA Serial-ATA
> adapter and a 120Gb Seagate Barracuda native SATA drive. Problem is,
> the kernel driver doesn't seem to notice this device on boot --

Its not a PCI identifier I've ever seen before

> 00:0b.0 RAID bus controller: CMD Technology Inc: Unknown device 0240 (rev 02) (prog-if 01)

So its some kind of CMD now SIS device, either an SI680 or SI3112 with a 
weird PCI ID


Does it have any option to put it into non raid mode in its bios ?
