Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262319AbTFKRIY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 13:08:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262562AbTFKRIY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 13:08:24 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:48300
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262319AbTFKRIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 13:08:23 -0400
Subject: Re: [PATCH] And yet more PCI fixes for 2.5.70
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Greg KH <greg@kroah.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030611163837.GA24951@kroah.com>
References: <1055290315109@kroah.com>
	 <1055335057.2083.14.camel@dhcp22.swansea.linux.org.uk>
	 <20030611163837.GA24951@kroah.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1055351984.2419.23.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 11 Jun 2003 18:19:49 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-06-11 at 17:38, Greg KH wrote:
> So that leaves only this file.  Jeff Garzik and I talked about removing
> pci_present() as it's not needed, and I think for this one case we can
> live without it.  Do you want me to make the pci_present() macro earlier
> in this file, so it's readable again?  I don't want to put it back into
> pci.h.

I still think it belongs in pci.h. Its an API and the API makes sense. The
implementation may change in time so it belongs in pci.h in one spot

