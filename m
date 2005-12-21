Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932375AbVLULkV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932375AbVLULkV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 06:40:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932376AbVLULkV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 06:40:21 -0500
Received: from tag.witbe.net ([81.88.96.48]:21126 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id S932375AbVLULkU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 06:40:20 -0500
Message-Id: <200512211140.jBLBeGD31936@tag.witbe.net>
Reply-To: <rol@witbe.net>
From: "Paul Rolland" <rol@witbe.net>
To: "'Arjan van de Ven'" <arjan@infradead.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [Linux 2.4.32] SATA ICH5/PIIX and Combined mode
Date: Wed, 21 Dec 2005 12:40:18 +0100
Organization: Witbe.net
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
In-Reply-To: <1135164891.3456.11.camel@laptopd505.fenrus.org>
Thread-Index: AcYGIo9UxPqGxkG5RKacB+8MnSAdrgAAIIkw
x-ncc-regid: fr.witbe
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> > I have a machine with two SATA HDD, and one PATA CDRom.
> > Bios is configured for combined mode, and installing a RedHat ES3
> > (Kernel 2.4.21-ELsmp) is fine, the two HDD are up, the installation
> > is fine and the CDRom is working.
> > 
> > Then, upgrading to a vanilla 2.4.32, the ata_piix.c file contains
> > a "combined mode not supported" and booting the machine hangs, as
> > no VFS are up for root device.
> 
> you can't reliably run a non-NPTL kernel on RHES3. Really. Are you
> really sure you want to ? 

Well, the other way around is to upgrade e1000 driver in the 2.4.21EL-smp,
as the machine I'm using is quite new, and RHES3 kernel can't find the
Ethernet device, so the machine has no network.
My first idea was to consider this as an opportunity to upgrade to the
latest 2.4.x kernel, but reading you, this looks like a bad idea...
2.6.x would be better ?

Regards,
Paul

