Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262369AbVAOX41@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262369AbVAOX41 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 18:56:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262372AbVAOX4P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 18:56:15 -0500
Received: from [81.2.110.250] ([81.2.110.250]:53378 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262369AbVAOX4I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 18:56:08 -0500
Subject: Re: ARP routing issue
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jan De Luyck <lkml@kcore.org>
Cc: James Courtier-Dutton <James@superbug.co.uk>,
       Steve Iribarne <steve.iribarne@dilithiumnetworks.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-net@vger.kernel.org
In-Reply-To: <200501151331.04879.lkml@kcore.org>
References: <B8561865DB141248943E2376D0E85215846787@DHOST001-17.DEX001.intermedia.net>
	 <200501061711.59301.lkml@kcore.org> <41E84C1D.9060505@superbug.co.uk>
	 <200501151331.04879.lkml@kcore.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105829477.16028.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 15 Jan 2005 22:51:17 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2005-01-15 at 12:31, Jan De Luyck wrote:
> On Friday 14 January 2005 23:47, James Courtier-Dutton wrote:
> > That arp is perfectly OK.
> > The routing table will cause the icmp echo packet to go from 10.216.0.xx
> > to 10.0.24.xx via the 10.0.24.x network.
> > The icmp echo response will return via the 10.0.22.x network back to the
> > 10.216.0.xx network.
> > So the paths in each direction are different.
> 
> Yes, but unfortunately I never ever receive the icmp echo reply, and the arp 
> table always lists the ip as "incomplete". Nothing I try to do to with that 
> interface (ssh/...) ever works.

If the directions are different does your distro enable rp_filter by
default - that may cause such problems. You might also want to ask on
netdev@oss.sgi.com - the network layer list

