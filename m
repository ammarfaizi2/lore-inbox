Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262570AbTJXTqK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 15:46:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262572AbTJXTqK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 15:46:10 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:16902 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S262570AbTJXTqE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 15:46:04 -0400
Date: Fri, 24 Oct 2003 23:45:05 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Petr Vandrovec <vandrove@vc.cvut.cz>,
       Jeff Garzik <jgarzik@pobox.com>, Eric Anholt <eta@lclark.edu>,
       kronos@kronoz.cjb.net,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fbdev-devel@lists.sourceforge.net,
       dri-devel <dri-devel@lists.sourceforge.net>
Subject: Re: [Dri-devel] Re: [Linux-fbdev-devel] DRM and pci_driver conversion
Message-ID: <20031024234505.B2362@jurassic.park.msu.ru>
References: <Pine.LNX.4.44.0310241051450.8177-100000@home.osdl.org> <20031024183405.36600.qmail@web14915.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20031024183405.36600.qmail@web14915.mail.yahoo.com>; from jonsmirl@yahoo.com on Fri, Oct 24, 2003 at 11:34:04AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 24, 2003 at 11:34:04AM -0700, Jon Smirl wrote:
> PCI ROM enabale/disable has come up before on LKML. Russell made this comment
> about making the code more portable.
> 
> --- Russell King <rmk@arm.linux.org.uk> wrote:
> > You should use pcibios_resource_to_bus() to convert a resource to a
> > representation suitable for a BAR.

pci_assign_resource() does call pcibios_resource_to_bus(),
so Linus' proposal will work correctly as it is.

Ivan.
