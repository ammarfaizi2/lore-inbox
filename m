Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264608AbTFELKQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 07:10:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264610AbTFELKQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 07:10:16 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:22663
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S264608AbTFELKP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 07:10:15 -0400
Subject: Re: PCI cache line messages 2.4/2.5
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Margit Schubert-While <margitsw@t-online.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1054811157.19407.3.camel@rth.ninka.net>
References: <5.1.0.14.2.20030602084908.00aed558@pop.t-online.de>
	 <3EDE7522.8040206@pobox.com>
	 <1054809554.15276.8.camel@dhcp22.swansea.linux.org.uk>
	 <1054811157.19407.3.camel@rth.ninka.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1054812011.15276.37.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 05 Jun 2003 12:20:12 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-06-05 at 12:05, David S. Miller wrote:
> I don't know how PnP OS plays into it, but the last time I dug into this
> deep dark area, the BIOS was expected to setup the cache line size for
> all PCI devices in the system.

With a non PnP OS the BIOS is supposed to have done a lot of the setup
for things like IRQ routing. With a PnP OS (and nowdays thats often not
even a selectable but a wired in property) the OS has to do a lot of
the work.

And then there is hotplug

