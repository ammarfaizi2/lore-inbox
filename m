Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750904AbVLOSVN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750904AbVLOSVN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 13:21:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750905AbVLOSVN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 13:21:13 -0500
Received: from isilmar.linta.de ([213.239.214.66]:28552 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S1750904AbVLOSVM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 13:21:12 -0500
Date: Thu, 15 Dec 2005 19:20:28 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Andrew Morton <akpm@osdl.org>, Miles Lane <miles.lane@gmail.com>
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: 2.6.15-rc5-mm3 -- bus may be hidden warning
Message-ID: <20051215182028.GA8469@dominikbrodowski.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Andrew Morton <akpm@osdl.org>, Miles Lane <miles.lane@gmail.com>,
	linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Nick Piggin <nickpiggin@yahoo.com.au>
References: <a44ae5cd0512150035j1e1a032bpe8b271069ad5d008@mail.gmail.com> <20051215004028.0bf9791f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051215004028.0bf9791f.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Dec 15, 2005 at 12:40:28AM -0800, Andrew Morton wrote:
> > [4294669.070000] PCI quirk: region 1000-107f claimed by ICH4 ACPI/GPIO/TCO
> > [4294669.070000] PCI quirk: region 1180-11bf claimed by ICH4 GPIO
> > [4294669.070000] PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
> > [4294669.070000] PCI: Transparent bridge - 0000:00:1e.0
> > [4294669.070000] PCI: Bus #03 (-#06) may be hidden behind transparent
> > bridge #02 (-#02) (try 'pci=assign-busses')
> 
> Greg & Dominik.

http://bugzilla.kernel.org/show_bug.cgi?id=5557

This is just an information that the CardBus bridge _might_ not work
correctly (the bus _may_ be hidden, but may also work correctly), and that
pci=assign-busses should fix this.

	Dominik
