Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267646AbUIOWBj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267646AbUIOWBj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 18:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267632AbUIOWA6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 18:00:58 -0400
Received: from rproxy.gmail.com ([64.233.170.197]:59848 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267595AbUIOV7H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 17:59:07 -0400
Message-ID: <470b63970409151459635625f5@mail.gmail.com>
Date: Wed, 15 Sep 2004 14:59:03 -0700
From: Tony Lee <tony.p.lee@gmail.com>
Reply-To: Tony Lee <tony.p.lee@gmail.com>
To: Paul Jakma <paul@clubi.ie>
Subject: Re: The ultimate TOE design
Cc: Netdev <netdev@oss.sgi.com>, leonid.grossman@s2io.com,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0409152102050.23011@fogarty.jakma.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <4148991B.9050200@pobox.com>
	 <Pine.LNX.4.61.0409152102050.23011@fogarty.jakma.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Sep 2004 21:04:38 +0100 (IST), Paul Jakma <paul@clubi.ie> wrote:
> On Wed, 15 Sep 2004, Jeff Garzik wrote:
> 
> > Put simply, the "ultimate TOE card" would be a card with network ports, a
> > generic CPU (arm, mips, whatever.), some RAM, and some flash.  This card's
> > "firmware" is the Linux kernel, configured to run as a _totally indepenent
> > network node_, with IP address(es) all its own.
> >
> > Then, your host system OS will communicate with the Linux kernel running on
> > the card across the PCI bus, using IP packets (64K fixed MTU).
> 
> > My dream is that some vendor will come along and implement such a
> > design, and sell it in enough volume that it's US$100 or less.
> > There are a few cards on the market already where implementing this
> > design _may_ be possible, but they are all fairly expensive.
> 
> The intel IXP's are like the above, XScale+extra-bits host-on-a-PCI
> card running Linux. Or is that what you were referring to with
> "<cards exist> but they are all fairly expensive."?
> 
> >       Jeff
> 
> regards,
> --
> Paul Jakma      paul@clubi.ie   paul@jakma.org  Key ID: 64A2FF6A



I believe Broadcom 5704 (570x) chip/nic card come with 2 MIPS CPUs (133 MHz)
one each for both Tx and Rx data path.   The GIGE nic card cost < $50
couple years ago.


Too bad, the software SDK for them is closed (quoted at $96K couple years ago) .

Otherwise, there can be some interesting applications with that extremely
inexpensive chip/nic card.

RDMA over TCP/UDP with that chip/nic card over gige can be very interesting.

so is SSL proxy, SSH tunnel, etc.

With the right distributing processing design, it might even possible
to offload SMB,
NFS to the "right" nic card.


-Tony
--
Having fun with Xilinx Virtex Pro II reconfigurable HW +  integrated PPC + Linux
