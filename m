Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261312AbSIZOEM>; Thu, 26 Sep 2002 10:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261313AbSIZOEM>; Thu, 26 Sep 2002 10:04:12 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:41720
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261312AbSIZOEL>; Thu, 26 Sep 2002 10:04:11 -0400
Subject: Re: devicefs & sleep support for IDE
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Patrick Mochel <mochel@osdl.org>
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0209250927500.966-100000@cherise.pdx.osdl.net>
References: <Pine.LNX.4.44.0209250927500.966-100000@cherise.pdx.osdl.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 26 Sep 2002 15:14:17 +0100
Message-Id: <1033049657.11848.19.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-09-25 at 17:44, Patrick Mochel wrote:
> Actually, looking at it again, the struct device in hwif_t should probably 
> go away. We should initialize the parent device to the struct device in 
> the struct pci_dev of the controller; at least for PCI controllers.

>From a 2.4 point of view and a making IDE work point of view leave it
alone for now.

> For non-PCI controllers, is there anything else that describes the 
> controller besides hwif_t ?

Undefined and basically to the IDE core "none of your business"
 

Alan

