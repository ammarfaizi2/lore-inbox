Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264023AbTFHXFe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jun 2003 19:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264027AbTFHXFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jun 2003 19:05:34 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:32160
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S264023AbTFHXF3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jun 2003 19:05:29 -0400
Subject: Re: [PATCH] [3/3] PCI segment support
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Matthew Wilcox <willy@debian.org>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       David Mosberger <davidm@hpl.hp.com>
In-Reply-To: <20030608223318.C9520@flint.arm.linux.org.uk>
References: <20030407234411.GT23430@parcelfarce.linux.theplanet.co.uk>
	 <20030408203824.A27019@jurassic.park.msu.ru>
	 <20030608164351.GI28581@parcelfarce.linux.theplanet.co.uk>
	 <20030608223318.C9520@flint.arm.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1055114177.29980.1.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 09 Jun 2003 00:16:17 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-06-08 at 22:33, Russell King wrote:
> On Sun, Jun 08, 2003 at 05:43:51PM +0100, Matthew Wilcox wrote:
> > I envisage ia64 will always turn on CONFIG_PCI_DOMAINS but x86 might
> > well have it as a user question.  I suspect most architectures would
> > never turn it on (yeah, I'm going to design an embedded ARM box with
> > multiple PCI domains.  sure.)
> 
> Don't be so sure.  There's already ARM implementations where there are
> multiple PCI buses hanging off the host bridge - mostly stuff from Intel
> though.

And x86 also, although its normally multiple pci host bridges hanging
off an internal faster bus with a large collection of magic hardware
wizardry to make it look like one

