Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272070AbTHRPtW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 11:49:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272050AbTHRPtW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 11:49:22 -0400
Received: from 204.244.250.2.net-conex.com ([204.244.250.2]:24432 "EHLO
	mail4.angio.com") by vger.kernel.org with ESMTP id S272070AbTHRPr0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 11:47:26 -0400
Message-ID: <E2B3FD6B3FF2804CB276D9ED037268354FF6FB@mail4.angio.com>
From: "Hassard, Stephen" <SHassard@angio.com>
To: "'Jeff Garzik'" <jgarzik@pobox.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Communication problem with via-rhine in kernel-2.6.0-test3-bk
	3+
Date: Mon, 18 Aug 2003 08:47:23 -0700
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

"acpi=off" seems to fix it. I guess a change in the ACPI code betweek
2.6.0-test3-bk2 and bk3 broke ACPI on my machine ..

Thanks,
Steve

> -----Original Message-----
> From: Jeff Garzik [mailto:jgarzik@pobox.com] 
> Sent: Monday, August 18, 2003 8:40 AM
> To: Hassard, Stephen
> Cc: 'linux-kernel@vger.kernel.org'
> Subject: Re: Communication problem with via-rhine in 
> kernel-2.6.0-test3-bk3+
> 
> 
> On Mon, Aug 18, 2003 at 08:28:24AM -0700, Hassard, Stephen wrote:
> > Hi all,
> > 
> > I've been happily using the Rhine-II NIC on my VIA Epia-800 with
> > 2.6.0-test3, but ever since bk3 via-rhine seems to be broken.
> > 2.6.0-test3-bk2 works without problems.
> > 
> > I've contacted the driver maintainer, Roger Luethi, and he 
> mentioned that if
> > it was a problem since 2.6.0-test3, I should contact the 
> kernel mailing
> > list.
> > 
> > The interface is detected properly, but no data is 
> transmitted. DHCP doesn't
> > work. When I manually configure the interface and try to 
> send data, I get
> > the following error, which repeats:
> > >>
> > eth0: Transmit timed out, status 1003, PHY status 786d, resetting...
> > eth0: Setting full-duplex based on MII #1 link partner 
> capability of 45e1.
> > <<
> 
> Does booting with "pci=noapic" or "acpi=off" or "noapic" help?
> 
> 	Jeff
> 
> 
> 
