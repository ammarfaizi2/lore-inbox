Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263018AbTDRMFA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 08:05:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263026AbTDRMFA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 08:05:00 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:30412
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263018AbTDRME7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 08:04:59 -0400
Subject: Re: Subtle semantic issue with sleep callbacks in drivers
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Greg KH <greg@kroah.com>, John Bradford <john@grabjohn.com>,
       Jeff Garzik <jgarzik@pobox.com>, Patrick Mochel <mochel@osdl.org>,
       Grover Andrew <andrew.grover@intel.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030418101042.B25177@flint.arm.linux.org.uk>
References: <20030417150926.GA25402@gtf.org>
	 <200304171547.h3HFljoK000140@81-2-122-30.bradfords.org.uk>
	 <20030418073754.GA2753@kroah.com>
	 <20030418101042.B25177@flint.arm.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1050664711.1218.2.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 18 Apr 2003 12:18:32 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-04-18 at 10:10, Russell King wrote:
> On Fri, Apr 18, 2003 at 12:37:54AM -0700, Greg KH wrote:
> > PCI Hotplug does not support video cards for just this reason.
> 
> /me points at the Mobility Electronics EV1000 Cardbus-PCI widget
> with a ATI Rage VGA device.  Ok, it's hot-pluggable, but it'd be
> nice to work out a way to support it.

2.4 PCI hotplug correctly supports switching frame buffer on a plug
event. Who broke it 8) ?

