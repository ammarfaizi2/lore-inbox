Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272073AbTHRPka (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 11:40:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272118AbTHRPk3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 11:40:29 -0400
Received: from [63.247.75.124] ([63.247.75.124]:51854 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S272074AbTHRPkZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 11:40:25 -0400
Date: Mon, 18 Aug 2003 11:40:25 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: "Hassard, Stephen" <SHassard@angio.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Communication problem with via-rhine in kernel-2.6.0-test3-bk3+
Message-ID: <20030818154025.GD24693@gtf.org>
References: <E2B3FD6B3FF2804CB276D9ED037268354FF6FA@mail4.angio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E2B3FD6B3FF2804CB276D9ED037268354FF6FA@mail4.angio.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 18, 2003 at 08:28:24AM -0700, Hassard, Stephen wrote:
> Hi all,
> 
> I've been happily using the Rhine-II NIC on my VIA Epia-800 with
> 2.6.0-test3, but ever since bk3 via-rhine seems to be broken.
> 2.6.0-test3-bk2 works without problems.
> 
> I've contacted the driver maintainer, Roger Luethi, and he mentioned that if
> it was a problem since 2.6.0-test3, I should contact the kernel mailing
> list.
> 
> The interface is detected properly, but no data is transmitted. DHCP doesn't
> work. When I manually configure the interface and try to send data, I get
> the following error, which repeats:
> >>
> eth0: Transmit timed out, status 1003, PHY status 786d, resetting...
> eth0: Setting full-duplex based on MII #1 link partner capability of 45e1.
> <<

Does booting with "pci=noapic" or "acpi=off" or "noapic" help?

	Jeff



