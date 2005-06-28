Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261568AbVF1OSu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261568AbVF1OSu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 10:18:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261465AbVF1ORH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 10:17:07 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:44713 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261461AbVF1OMQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 10:12:16 -0400
Date: Tue, 28 Jun 2005 09:11:57 -0500 (CDT)
From: Pat Gefre <pfg@americas.sgi.com>
To: Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>
cc: pfg@sgi.com, akpm@osdl.org, hch@infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6] Altix - add ioc3 serial driver support
In-Reply-To: <Pine.GSO.4.10.10506280729520.16758-100000@helios.et.put.poznan.pl>
Message-ID: <Pine.SGI.3.96.1050628090712.40806A-100000@fsgi900.americas.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jun 2005, Stanislaw Skowronek wrote:

+ > > Something I didn't make clear - the driver that I am adding is a pci
+ > > card based on the IOC3 serial part - it is a single function card - 2
+ > > serial ports. This is supported on Altix.
+ 
+ OK. Does it play along with the Ethernet part of the IOC3? And with the
+ pckm part? And with the different devices which hang off the IOC3?
+ (Especially the RTC on Octanes?) If yes, then I'm all over it :)

There is an ioc3 serial part on the same ioc3 as the ethernet - I'm not
sure what the differneces are - I haven't looked at it.

+ 
+ Does your driver use DMA for serial? If not, then it is not really needed
+ as I have a driver that uses 16550-style IRQs.

Yes.

-- Pat

