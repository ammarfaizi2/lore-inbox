Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265516AbUFON0Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265516AbUFON0Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 09:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265517AbUFON0Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 09:26:24 -0400
Received: from aun.it.uu.se ([130.238.12.36]:44536 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S265516AbUFON0X convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 09:26:23 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-ID: <16590.63737.935300.398152@alkaid.it.uu.se>
Date: Tue, 15 Jun 2004 15:26:17 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Adolfo =?iso-8859-15?q?Gonz=E1lez=20Bl=E1zquez?= 
	<agblazquez_mailing@telefonica.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: pdc202xx_old serious bug with DMA on 2.6.x series
In-Reply-To: <200406150118.34034.bzolnier@elka.pw.edu.pl>
References: <1087253451.4817.4.camel@localhost>
	<200406150118.34034.bzolnier@elka.pw.edu.pl>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz writes:
 > On Tuesday 15 of June 2004 00:50, Adolfo González Blázquez wrote:
 > > Hi!
 > 
 > Hi,
 > 
 > > Lot of users are reporting seriour problems with pdc202xx_old ide pci
 > > driver. Enabling DMA on any device related with this driver makes the
 > > system unusable.
 > >
 > > This seems to happen in all the 2.6.x kernel series.
 > 
 > Doing binary search on 2.4->2.6 kernels would help greatly
 > (narrowing problem to a specific kernel versions).
 > 
 > > More info on Kerneltrap: http://kerneltrap.org/node/view/3040
 > > More info on Bugzilla: http://bugzilla.kernel.org/show_bug.cgi?id=2494
 > >
 > > I hope someone can fix this, 'cause there's a lot of people using these
 > > ide controllers.
 > 
 > It seems everybody wants it fixed but nobody is willing to help...

FWIW, I run an ASUS P3B-F (440BX chipset) with a 20267 add-on
card and a WD Caviar WD800JB UDMA100 disk as a server spooling
News and other high-volume data. Even when moving GBs of data
around as fast as the disk can read or write it, the system
has never been less than rock solid with the 2.6 kernels.

Of course, ACPI is disabled and the 20267 is not sharing
interrupts with anything else.
